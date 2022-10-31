class User < ApplicationRecord
  # Associations
  has_many :my_pokemons, dependent: :destroy
  has_many :pokemons, through: :my_pokemons
  
  enum role: {
    member: 0,
    admin: 1
  }

end
