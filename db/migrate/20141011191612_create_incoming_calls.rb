class CreateIncomingCalls < ActiveRecord::Migration
  def change
    create_table :incoming_calls do |t|
      t.integer :practice_phone_number_id
      t.integer :user_id

      t.timestamps
    end
  end
end
