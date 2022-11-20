class CreatePokemons < ActiveRecord::Migration[7.0]
  def change
    create_table :pokemons do |t|
      t.string :name
      t.integer :weight
      t.integer :height
      t.string :image
      t.integer :base_experience
      # t.references :move, null: true, foreign_key: true

      t.timestamps
    end
  end
end
