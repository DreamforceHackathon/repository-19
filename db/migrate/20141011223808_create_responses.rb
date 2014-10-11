class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.integer :prompt_id
      t.integer :incoming_call_id

      t.timestamps
    end
  end
end
