class MyPokemon < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :pokemon
  has_one :real_stat
  has_one :indiv_stat
  has_one :effort_stat
end
