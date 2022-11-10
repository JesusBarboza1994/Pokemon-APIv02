class MyPokemon < ApplicationRecord
  attr_accessor :current_hp, :attack_points
  
  # Associations
  belongs_to :user
  belongs_to :pokemon
  has_one :real_stat, dependent: :destroy
  has_one :indiv_stat, dependent: :destroy
  has_one :effort_stat, dependent: :destroy

  def train(bot)
    puts "hola"
    bot.destroy
  end

  def prepare_for_battle
    @current_hp = self.real_stat[:hp]
    @current_attack = self.real_stat[:attack]
    @current_defense = self.real_stat[:defense]
    @current_special_attack = self.real_stat[:special_attack]
    @current_special_defense = self.real_stat[:special_defense]
    @current_speed = self.real_stat[:speed]
    @attack_points = 1
  end

  def attack(pokemon)
    puts pokemon.current_hp
    pokemon.current_hp -= @attack_points
    puts pokemon.current_hp
  end
  def fainted?
   @current_hp <= 0
  end
end
