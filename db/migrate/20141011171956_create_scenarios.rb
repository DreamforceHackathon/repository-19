class CreateScenarios < ActiveRecord::Migration
  def change
    create_table :scenarios do |t|
      t.integer :practice_phone_number_id
      t.string :name
      t.integer :sequence

      t.timestamps
    end
  end
end
