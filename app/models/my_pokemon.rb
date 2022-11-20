class MyPokemon < ApplicationRecord
  attr_accessor :current_hp, :attack_points
  
  # Associations
  belongs_to :user
  belongs_to :pokemon
  has_one :real_stat, dependent: :destroy
  has_one :indiv_stat, dependent: :destroy
  has_one :effort_stat, dependent: :destroy


  def attack(pokemon, move)
    puts "==="
    p move.power
    puts "==="
    puts "HP inicial"
    puts pokemon.actual_hp
    puts move.power
    pokemon.actual_hp -= move.power unless move.power.nil?
    
    pokemon.update(actual_hp:pokemon.actual_hp )
    puts "HP final"
    puts pokemon.actual_hp
  end
  def fainted?
   self.actual_hp <= 0
  end

  def gain_experience(pokemon)
    levels = [self.level]
    # amount_stats = pokemon.effort_points[:amount]
    gained_points = (self.pokemon.base_experience * pokemon.level / 7.0).floor
    actual_exp = self.experience
    self.update(experience: actual_exp + gained_points)
    exp = ((6 / 5 * ((self.level+1)**3)) - (15 * ((self.level+1)**2)) + (100 * (self.level+1)) - 140).floor

    while self.experience > exp
      self.update(level: self.level + 1) if self.experience >= exp
      exp = ((6 / 5 * ((self.level+1)**3)) - (15 * ((self.level+1)**2)) + (100 * (self.level+1)) - 140).floor
    end
    self.pokemon.stats.each.with_index do |stat,i|      
      calc_stats = (2 * self.pokemon.pokemon_stats[i][:base_stat]) + self.indiv_stat[stat[:name]] + (self.effort_stat[stat[:name]] / 4).floor
      base_for_st =  calc_stats * self.level / 100
      puts base_for_st
      if self.pokemon.stats[i][:name] == "hp"
        self.real_stat.update(self.pokemon.stats[i][:name]=>(base_for_st + self.level + 10).floor)
      else
        self.real_stat.update(self.pokemon.stats[i][:name]=>(base_for_st + 5).floor)
      end
    end
    levels.push(self.level)
    return levels
  end
end
