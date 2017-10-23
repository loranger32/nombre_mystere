class MysteryNumber
  attr_accessor :current_pick

  def initialize(start_num, end_num)
    @current_pick = pick_random_number(start_num, end_num)
  end

  def pick_random_number(start_num, end_num)
    rand(start_num..end_num)
  end

  def to_s
    @current_pick.to_s
  end
end
