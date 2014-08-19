=begin
Once you start creating model associations, looking at the data, and talking with users, you'll likely come up 
with all sorts of interesting business logic. The secret is to always try to push as much business logic as you 
can back into the model. That makes the logic easier to use (and reuse) and easier to test! Also, although it 
may be tempting to perform calculations in Ruby, you'll get better performance if you instead use Active Record's 
calculation methods. 
=end


class Project < ActiveRecord::Base
  
	validates :name, presence: true

	validates :description, presence: true, length: { maximum: 500 }

	validates :target_pledge_amount, numericality: { greater_than: 0.00 }

  validates :website, format: {
    with: /https?:\/\/[\S]+\b/i,
    message: "must reference a valid URL"
  }

	validates :image_file_name, allow_blank: true, format: {
		with: /\w+\.(gif|jpg|png)\z/i,
		message: "must reference a GIF, JPG, or PNG image"
	}

  has_many :pledges, dependent: :destroy

  def self.accepting_pledges
    where("pledging_ends_on >= ?", Time.now).order("pledging_ends_on asc")
  end

  def pledging_expired?
    pledging_ends_on < Date.today
  end


  # calculations Active Records built-in

  def funded?
    amount_outstanding <= 0
  end

  def amount_outstanding
    target_pledge_amount - total_amount_pledged
  end

  def total_amount_pledged
    pledges.sum(:amount)
  end

end
