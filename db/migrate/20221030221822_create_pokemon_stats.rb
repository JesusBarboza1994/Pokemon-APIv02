class CreatePokemonStats < ActiveRecord::Migration[7.0]
  def change
    create_table :pokemon_stats do |t|
      t.references :stat, null: false, foreign_key: true
      t.references :pokemon, null: false, foreign_key: true
      t.integer :base_stat
      t.integer :effort

      t.timestamps
    end
  end
end
