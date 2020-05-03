require 'challenge/calculable'

module ::Challenge::Damage
  include ::Challenge::Calculable

  FOR_LEVEL = {
    0 => 0..1,
    1/8r => 2..3,
    1/4r => 4..5,
    1/2r => 6..8,
    1 => 9..14,
    2 => 15..20,
    3 => 21..26,
    4 => 27..32,
    5 => 33..38,
    6 => 39..44,
    7 => 45..50,
    8 => 51..56,
    9 => 57..62,
    10 => 63..68,
    11 => 69..74,
    12 => 75..80,
    13 => 81..86,
    14 => 87..92,
    15 => 93..98,
    16 => 99..104,
    17 => 105..110,
    18 => 111..116,
    19 => 117..122,
    20 => 123..140,
    21 => 141..158,
    22 => 159..176,
    23 => 177..194,
    24 => 195..212,
    25 => 213..230,
    26 => 231..248,
    27 => 249..266,
    28 => 267..284,
    29 => 285..302,
    30 => 303..320
  }.freeze
end
