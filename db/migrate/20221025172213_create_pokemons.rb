class CreatePokemons < ActiveRecord::Migration[7.0]
  def change
    create_table :pokemons do |t|
      t.string :name
      t.integer :weight
      t.integer :height
      t.string :image

      t.timestamps
    end
  end
end
