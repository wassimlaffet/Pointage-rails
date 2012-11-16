module ApplicationHelper
   module Status
    HEURE_START = 1
    HEURE_PAUSE = 2
    HEURE_REPRISE = 3
    HEURE_END = 4
    VALUE_MAP = {1 => "hs", 2 => "hp", 3 => "hr", 4 => "he"}
    VALID_VALUES = Set.new([HEURE_START, HEURE_PAUSE, HEURE_REPRISE,HEURE_END]).freeze
  end
end
