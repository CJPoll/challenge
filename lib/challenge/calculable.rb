require 'challenge/calculable'

module ::Challenge::Calculable
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def for_level(level)
      self::FOR_LEVEL[level]
    end

    def level_for(ac)
      all_for_level =
        self::FOR_LEVEL.select do |l, a|
          if a.is_a? Integer
            a == ac 
          elsif a.is_a? Range
            a.include?(ac)
          else
            raise "Unknown Value: #{inspect a}"
          end
        end

      min = all_for_level.keys.min
      max = all_for_level.keys.max

      if min == max
        min
      else
        min..max
      end
    end
  end
end
