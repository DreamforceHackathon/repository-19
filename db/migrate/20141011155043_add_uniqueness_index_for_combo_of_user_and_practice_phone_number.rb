class AddUniquenessIndexForComboOfUserAndPracticePhoneNumber < ActiveRecord::Migration
  def change
    add_index :user_practice_phone_numbers, [:user_id, :practice_phone_number_id], unique: true, name: "uppn_idx"
  end
end
