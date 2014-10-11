class AddOwnerIdToPracticePhoneNumbers < ActiveRecord::Migration
  def change
    add_column :practice_phone_numbers, :owner_id, :integer
  end
end
