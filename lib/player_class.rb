class Player
  include Displayable

  attr_accessor :name, :guess

  def initialize
    @name = set_name
    @guess = 0
  end

  def choose_range
    puts ''
    puts "Choisis les nombre entre lesquels je vais choisir le nombre mystère:"
    puts "Le nombre bas:"
    low_number = gets.chomp
    until low_number =~ /\A\d+\z/ do
      puts "Tu n'as pas entré un nombre, recommence:"
      low_number = gets.chomp
    end
    puts "Le nombre haut maintenant:"
    high_number = gets.chomp
    until high_number =~ /\A\d+\z/ do
      puts "Tu n'as pas entré un nombre, recommence:"
      high_number = gets.chomp
    end
    until high_number > low_number do
      puts "Tu as choisis un nombre plus petit que #{low_number}, recommence:"
      high_number = gets.chomp
    end
    [low_number.to_i, high_number.to_i]
  end

  def choose_number_from(range)
    prompt "Entre ton choix: "
    self.guess = gets.to_i
    until (range[0]..range[1]).cover?(guess)
      prompt "Tu n'as pas entré un numéro, ou bien le numéro est plus grand que\
 100, essaie encore: "
      self.guess = gets.to_i
    end
  end

  def choose_bigger_number_than(last_pick, range)
    prompt "Entre un nombre plus grand: "
    self.guess = gets.to_i
    until (range[0]..range[1]).cover?(guess)
      prompt "Tu n'as pas entré un numéro, ou bien le numéro est plus grand que\
 100, essaie encore: "
      self.guess = gets.to_i
    end
    until guess > last_pick
      prompt "Tu n'as pas entré un nombre plus grand que #{last_pick},\
 recommence: "
      self.guess = gets.to_i
    end
  end

  def choose_smaller_number_than(last_pick, range)
    prompt "Entre un nombre plus petit: "
    self.guess = gets.to_i
    until (range[0]..range[1]).cover?(guess)
      prompt "Tu n'as pas entré un numéro, ou bien le numéro est plus grand que\
 100, essaie encore: "
      self.guess = gets.to_i
    end
    until guess < last_pick
      prompt "Tu n'as pas entré un nombre plus petit que #{last_pick},\
 recommence: "
      self.guess = gets.to_i
    end
  end

  private

  def set_name
    prompt "Bonjour, comment t'apples-tu ?"
    name = ''
    loop do
      name = gets.chomp
      break unless name.empty? || name =~ /\A\s+\z/
      prompt "Tu n'as rien entré, j'ai besoin d'un nom valide, recommence."
    end
    name
  end

  def to_s
    name.capitalize
  end
end
