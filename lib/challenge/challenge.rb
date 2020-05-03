require 'challenge/ac'
require 'challenge/attack'
require 'challenge/challenge'
require 'challenge/damage'
require 'challenge/hp'
require 'challenge/save'

class ::Challenge::Plan
  attr_reader :ac, :hp, :attack, :damage, :save, :offense_level, :defense_level, :overall_level, :defensive_variance, :offensive_variance, :level

  def initialize(level)
    @level = level
    @overall_level = level
    @high_trait = high_trait
    @variance = variance(level)
    @offense_level = offensivee_level
    @defense_level = defensive_level

    @defensive_variance = variance(@defense_level)
    @high_defensive_trait = high_defensive_trait

    @offensive_variance = variance(@offense_level)
    @high_offensive_trait = high_offensive_trait
  end

  def high_ac?
    @high_defensive_trait == :ac
  end

  def high_hp?
    @high_defensive_trait == :hp
  end

  def high_attack?
    @high_offensive_trait == :attack
  end

  def high_damage?
    @high_offensive_trait == :damage
  end

  def high_defense?
    @high_trait == :defense
  end

  def high_offense?
    @high_trait == :offense
  end

  private
  def high_trait
    case rand(0..1)
    when 0
      :defense
    when 1
      :offense
    end
  end

  def high_defensive_trait
    case rand(0..1)
    when 0
      :ac
    when 1
      :hp
    end
  end

  def high_offensive_trait
    case rand(0..1)
    when 0
      :damage
    when 1
      :attack
    end
  end

  def variance(level)
    if level == 1
      0
    elsif level == 2
      rand(0..1)
    else
      rand(0..2)
    end
  end

  def offensivee_level
    if high_offense?
      return @overall_level + @variance
    end

    if high_defense?
      return @overall_level - @variance
    end
  end

  def defensive_level
    if high_defense?
      return @overall_level + @variance
    end

    if high_offense?
      return @overall_level - @variance
    end
  end
end

class ::Challenge::Challenge
  attr_reader :ac, :hp, :damage, :attack, :save
  def initialize(plan)
    @plan = plan
    @ac = ac_level(plan)
    @hp = ::Challenge::HP.for_level(hp_level(plan))
    @damage = ::Challenge::Damage.for_level(damage_level(plan))
    @attack = attack_level(plan)
    @save = ::Challenge::Save.for_level(plan.level)
  end

  def validate!
    if @ac.nil? or @hp.nil? or @damage.nil? or @attack.nil? or @save.nil?
      raise """

      From Plan: #{@plan.inspect}

      Invalid Challenge: #{self.inspect}

      """
    end
  end

  private
  def ac_level(plan)
    if plan.high_ac?
      return ::Challenge::AC.for_level(hp_level(plan)) + (2 * plan.defensive_variance)
    end

    if plan.high_hp?
      return ::Challenge::AC.for_level(hp_level(plan)) - (2 * plan.defensive_variance)
    end
  end

  def hp_level(plan)
    if plan.high_ac?
      return plan.defense_level - plan.defensive_variance
    end

    if plan.high_hp?
      return plan.defense_level + plan.defensive_variance
    end
  end

  def damage_level(plan)
    if plan.high_attack?
      return plan.offense_level - plan.offensive_variance
    end

    if plan.high_damage?
      return plan.offense_level + plan.offensive_variance
    end
  end

  def attack_level(plan)
    if plan.high_attack?
      attack = ::Challenge::Attack.for_level(damage_level(plan)) 
      attack = attack + (2 * plan.offensive_variance)
      return attack
    end

    if plan.high_damage?
      return ::Challenge::Attack.for_level(damage_level(plan)) - (2 * plan.offensive_variance)
    end
  end
end
