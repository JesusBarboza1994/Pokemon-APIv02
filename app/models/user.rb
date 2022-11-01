class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Associations
  has_many :my_pokemons, dependent: :destroy
  has_many :pokemons, through: :my_pokemons
  
  enum role: {
    member: 0,
    admin: 1
  }

end
