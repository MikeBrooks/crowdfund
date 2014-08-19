class Pledge < ActiveRecord::Base
  
  validates :name, presence: true

  validates :email, format: {
  	with: /(\S+)@(\S+)/,
  	message: "must be in valid format"
  }

  AMOUNT_LEVELS = [
  	25.00, 50.00, 100.00, 200.00, 500.00
  ]

  validates :amount, inclusion: {
  	in: AMOUNT_LEVELS,
  	message: "must be either 25.00, 50.00, 100.00, 200.00, or 500.00"
  }

  belongs_to :project
end
