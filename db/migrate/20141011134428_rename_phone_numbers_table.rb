class RenamePhoneNumbersTable < ActiveRecord::Migration
  def change
    rename_table :phone_numbers, :practice_phone_numbers
  end
end
