class CreateMyPokemons < ActiveRecord::Migration[7.0]
  def change
    create_table :my_pokemons do |t|
      t.references :user, null: false, foreign_key: true
      t.references :pokemon, null: false, foreign_key: true
      t.string :nickname
      t.integer :experience, default: 0
      t.integer :level, default: 1
      t.integer :actual_hp, default: 1
      t.timestamps
    end
  end
end
