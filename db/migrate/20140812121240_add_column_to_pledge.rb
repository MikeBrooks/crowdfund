class AddColumnToPledge < ActiveRecord::Migration
  def change
    add_column :pledges, :comment, :string
  end
end
