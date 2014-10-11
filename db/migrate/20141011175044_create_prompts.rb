class CreatePrompts < ActiveRecord::Migration
  def change
    create_table :prompts do |t|
      t.integer :scenario_id
      t.text :content
      t.integer :sequence

      t.timestamps
    end
  end
end
