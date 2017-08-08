class MysteryNumber
  attr_accessor :current_pick

  def initialize
    @current_pick = pick_random_number
  end

  def pick_random_number
    rand(1..100)
  end

  def to_s
    @current_pick.to_s
  end
end
