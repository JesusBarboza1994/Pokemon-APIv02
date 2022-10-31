class Stat < ApplicationRecord
  has_many :pokemon_stats, dependent: :destroy
  has_many :pokemons, through: :pokemon_stats
end
