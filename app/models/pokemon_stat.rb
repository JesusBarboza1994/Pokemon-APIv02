class PokemonStat < ApplicationRecord
  belongs_to :stat
  belongs_to :pokemon
end
