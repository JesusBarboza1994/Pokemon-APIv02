class CreateJoinTablePokemonType < ActiveRecord::Migration[7.0]
  def change
    create_join_table :pokemons, :types do |t|
      # t.index [:pokemon_id, :type_id]
      # t.index [:type_id, :pokemon_id]
    end
  end
end
