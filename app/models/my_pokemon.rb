class MyPokemon < ApplicationRecord
  attr_accessor :current_hp, :attack_points
  include MyPokemonsHelper
  # Associations
  belongs_to :user
  belongs_to :pokemon
  has_one :real_stat, dependent: :destroy
  has_one :indiv_stat, dependent: :destroy
  has_one :effort_stat, dependent: :destroy


  def attack(pokemon, move)
    critical_hit = _getcrit
    multiplier = _getmultiplier(pokemon, move)
    critica_ratio = critical_hit * multiplier
    if SPECIAL_MOVE_TYPE.include?(move.tipo.to_sym)
      offensive_stat = self.real_stat[:special_attack]
      target_defensive_stat = pokemon.real_stat[:special_defense]
    else
      offensive_stat = self.real_stat[:attack]
      target_defensive_stat = pokemon.real_stat[:defense]
    end
    if move.power.nil?
      damage = nil
    else
      damage = (((((2 * self.level / 5.0 + 2).floor * offensive_stat * move.power / target_defensive_stat).floor / 50.0).floor + 2) * critica_ratio).floor
    end
    pokemon.actual_hp -= damage unless damage.nil?
    pokemon.update(actual_hp:pokemon.actual_hp )
  end

  def fainted?
   self.actual_hp <= 0
  end

  def _getcrit
    critical_hit = 1
    if rand(1..16) == 1
      critical_hit = 1.5
      puts "It was a CRITICAL HIT!"
    end
    critical_hit
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

  def _getmultiplier(my_pok, move)
    p_type = move.tipo.to_sym
    r_type = []
    my_pok.pokemon.types.each do |type|
      r_type.push(type[:name].to_sym)
    end

    get_mul = TYPE_MULTIPLIER.find do |type|
      p_type == type[:user] && r_type.include?(type[:target])
    end
    multiplier = if get_mul.nil?
                   1
                 else
                   get_mul[:multiplier]
                 end

    case multiplier
    when 2
      puts "It's super effective!"
    when 0.5
      puts "It's not very effective..."
    when 1
      puts "no pasa nada"
    end
    multiplier
  end
end
