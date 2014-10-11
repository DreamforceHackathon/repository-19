class CreateUserPhoneNumbers < ActiveRecord::Migration
  def change
    create_table :user_phone_numbers do |t|
      t.integer :user_id
      t.integer :phone_number_id

      t.timestamps
    end
  end
end
