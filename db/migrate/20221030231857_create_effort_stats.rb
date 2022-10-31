class CreateEffortStats < ActiveRecord::Migration[7.0]
  def change
    create_table :effort_stats do |t|
      t.integer :hp
      t.integer :attack
      t.integer :defense
      t.integer :special_attack
      t.integer :special_defense
      t.integer :speed
      t.references :my_pokemon, null: false, foreign_key: true

      t.timestamps
    end
  end
end
