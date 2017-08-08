class Stats
  attr_accessor :victories, :defeats, :round_attempts, :total_attempts, :rounds

  def initialize
    @victories      = 0
    @defeats        = 0
    @round_attempts = 0
    @total_attempts = 0
    @rounds         = 1
  end

  def average_attempts
    total_attempts / rounds
  end

  def add_victory
    self.victories += 1
  end

  def add_defeat
    self.defeats += 1
  end

  def add_round
    self.rounds += 1
  end

  def add_attempt
    self.round_attempts += 1
    self.total_attempts += 1
  end

  def reset_round_attempts
    self.round_attempts = 0
  end

  def to_s
    "******************\n\
  Statistiques:\n\
  - tours joué: #{rounds}\n\
  - parties gagnées: #{victories}\n\
  - parties perdues: #{defeats}\n\
  - tentatives de ce tour: #{round_attempts}\n\
  - moyenne de tentatives par tour: #{average_attempts}.\n\
******************".green
  end
end
