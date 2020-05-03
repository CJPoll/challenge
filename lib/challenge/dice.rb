class ::Challenge::Dice
  ELIGIBLE_DICE = [2, 3, 4, 6, 8, 10, 12]

  def initialize(count, type, modifier = 0)
    @count = count
    @type = type
    @modifier = modifier
  end

  def average
    self.class.dice_average(@type) * @count + @modifier
  end

  def roll
    if @count == 1
      rand(1..@type) + @modifier
    else
      (1..@count).map do |_n|
        rand(1..@type)
      end
      .reduce do |sum, roll|
        sum + roll
      end + @modifier
    end
  end

  def to_s
    count =
      if @count == 1
        ""
      else
        @count
      end

    modifier =
      if @modifier == 0
        ""
      elsif @modifier > 0
        "+#{@modifier}"
      else
        "-#{@modifier.abs}"
      end

    "#{count}d#{@type}#{modifier}"
  end

  def self.with_average(avg, dice_type=ELIGIBLE_DICE.sample)
    dice_count = ((2 * avg) / dice_type)

    if dice_count < 1
      # Need a minimum of 1 die rolled
      dice_count = 1
    end

    max = dice_type * dice_count
    actual_average = dice_average(dice_type) * dice_count

    modifier = (avg - actual_average - 1).to_i

    new(dice_count, dice_type, modifier)
  end

  private
  #def self.count_modifier
  #  rand(-1..1)
  #end

  def self.dice_average(dice_type)
    (dice_type + 1) / 2.0
  end
end
