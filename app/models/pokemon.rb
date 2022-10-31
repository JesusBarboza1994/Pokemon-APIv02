class Pokemon < ApplicationRecord
  # Associations
  has_and_belongs_to_many :types
  has_many :my_pokemons, dependent: :destroy
  has_many :pokemons, through: :my_pokemons

  has_many :pokemon_stats, dependent: :destroy
  has_many :stats, through: :pokemon_stats
end
