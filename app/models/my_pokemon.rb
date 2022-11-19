class MyPokemon < ApplicationRecord
  attr_accessor :current_hp, :attack_points
  
  # Associations
  belongs_to :user
  belongs_to :pokemon
  has_one :real_stat, dependent: :destroy
  has_one :indiv_stat, dependent: :destroy
  has_one :effort_stat, dependent: :destroy

  def prepare_for_battle
    
    # @current_hp = self.real_stat[:hp]
    @current_attack = self.real_stat[:attack]
    @current_defense = self.real_stat[:defense]
    @current_special_attack = self.real_stat[:special_attack]
    @current_special_defense = self.real_stat[:special_defense]
    @current_speed = self.real_stat[:speed]
    @attack_points = 1
  end

  def attack(pokemon)
    puts "HP inicial"
    puts pokemon.actual_hp
    pokemon.actual_hp -= 5
    pokemon.update(actual_hp:pokemon.actual_hp )
    # if pokemon.actual_hp <= 0

    puts "HP final"
    puts pokemon.actual_hp
  end
  def fainted?
   self.actual_hp <= 0
  end

  def gain_experience(pokemon)
    amount_stats = pokemon.effort_points[:amount]
    gained_points = (self.pokemon.base_experience * pokemon.level / 7.0).floor
    actual_exp = self.experience
    self.update(experience: actual_exp + gained_points)
    exp = ((6 / 5 * ((self.level+1)**3)) - (15 * ((self.level+1)**2)) + (100 * (self.level+1)) - 140).floor
    if self.experience >= exp
      self.update(level: self.level + 1)
    end
    puts "antes tenia experiencia:"
    puts actual_exp
    puts "gano puntos"
    puts gained_points
    puts "puntos necesarios para subir"
    puts exp
    puts "nivel que ahora tiene:"
    puts self.level

  end
end
