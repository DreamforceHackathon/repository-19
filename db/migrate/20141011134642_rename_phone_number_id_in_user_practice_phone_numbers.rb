class RenamePhoneNumberIdInUserPracticePhoneNumbers < ActiveRecord::Migration
  def change
    rename_column :user_practice_phone_numbers, :phone_number_id, :practice_phone_number_id
  end
end
