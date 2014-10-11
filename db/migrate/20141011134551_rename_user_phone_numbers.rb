class RenameUserPhoneNumbers < ActiveRecord::Migration
  def change
    rename_table :user_phone_numbers, :user_practice_phone_numbers
  end
end
