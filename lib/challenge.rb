module ::Challenge
end

require 'challenge/ac'
require 'challenge/attack'
require 'challenge/challenge'
require 'challenge/damage'
require 'challenge/dice'
require 'challenge/hp'
require 'challenge/monster'
require 'challenge/save'

module ::Challenge
  def self.for_level(level)
    plan = ::Challenge::Plan.new(level)
    puts plan.inspect

    challenge = ::Challenge::Challenge.new(plan)
    puts challenge.inspect

    challenge.validate!

    monster = ::Challenge::Monster.new(
      challenge.ac,
      challenge.hp,
      challenge.attack,
      challenge.damage,
      challenge.save
    )

    puts monster.inspect

    unless plan.defense_level == monster.defense_level
      raise "Non-Matching Defense - Expected #{plan.defense_level}, got: #{monster.defense_level}"
    end

    unless plan.offense_level == monster.offense_level
      raise "Non-Matching Offense - Expected #{plan.offense_level}, got: #{monster.offense_level}"
    end

    unless plan.overall_level == monster.challenge_rating
      raise "Non-Matching Challenge Rating - Expected #{plan.overall_level}, got: #{monster.challenge_rating}"
    end

    monster
  end
end
