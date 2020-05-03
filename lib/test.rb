require 'challenge/monster'

module ::Test
  def self.test
    mock_plan = Struct.new(:high_ac?, :high_hp?, :high_attack?, :high_damage?, :defense_level, :offense_level, :defensive_variance, :offensive_variance, :level)


    # =============================================


    #m1 = ::Challenge::Monster.new(16, 191, 3, 84, 16)

    #puts m1.inspect

    #unless m1.defense_level == 9
    #  raise "Expected defense of 9, got: #{m1.defense_level}"
    #end

    #unless m1.offense_level == 11
    #  raise "Expected offense of 11, got: #{m1.offense_level}"
    #end

    #unless m1.challenge_rating == 10
    #  raise "Expected CR of 10, got: #{m1.challenge_rating}"
    #end


    # =============================================


    plan = mock_plan.new(true, false, true, false, 10, 10, 0, 0, 10)

    challenge = ::Challenge::Challenge.new(plan)

    unless challenge.ac == 17
      raise "Expected AC of 17, got: #{challenge.ac}"
    end

    unless challenge.hp == ::Challenge::HP.for_level(10)
      raise "Expected HP for level 10, got: #{challenge.hp}"
    end

    unless challenge.damage == ::Challenge::Damage.for_level(10)
      raise "Expected Damage for level 10, got: #{challenge.damage}"
    end

    unless challenge.attack == ::Challenge::Attack.for_level(10)
      raise "Expected Attack of 7, got: #{challenge.attack}"
    end

    unless challenge.save == ::Challenge::Save.for_level(10)
      raise "Expected Save for level 10, got: #{challenge.attack}"
    end


    # =============================================


    :ok
  end
end
