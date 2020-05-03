require 'challenge/ac'
require 'challenge/attack'
require 'challenge/damage'
require 'challenge/dice'
require 'challenge/hp'
require 'challenge/monster'
require 'challenge/save'

class ::Challenge::Monster
  attr_accessor :ac, :hp, :attack, :damage, :save

  def initialize(ac, hp, attack, damage, save)
    @ac = determine(ac)
    @hp = determine(hp)
    @attack = determine(attack)
    average_damage = determine(damage)
    @damage = ::Challenge::Dice.with_average(average_damage)
    @save = determine(save)
  end

  def defense_level
    hp_level = ::Challenge::HP.level_for(@hp)
    expected_ac = ::Challenge::AC.for_level(hp_level)
    ac_level_adjustment = ((@ac - expected_ac) / 2).floor

    hp_level + ac_level_adjustment
  end
  
  def offense_level
    damage_level = ::Challenge::Damage.level_for(@damage.average)

    expected_attack = ::Challenge::Attack.for_level(damage_level)

    t = ((@attack - expected_attack).to_f / 2.0)

    attack_level_adjustment =
      if t < 0
        t.ceil
      else
        t.floor
      end

    damage_level + attack_level_adjustment
  end

  def to_hit
    ::Challenge::Dice.new(1, 20, @attack)
  end

  def challenge_rating
    ((defense_level + offense_level).to_f / 2.0).floor
  end

  private
  def determine(value)
    if value.is_a? Integer
      value
    elsif value.is_a? Range
      rand(value)
    end
  end
end
