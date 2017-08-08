class Player
  include Displayable

  attr_accessor :name, :guess

  def choose_number
    prompt "Entre ton choix: "
    self.guess = gets.to_i
    until (1..100).cover?(guess)
      prompt "Tu n'as pas entré un numéro, ou bien le numéro est plus grand que\
 100, essaie encore: "
      self.guess = gets.to_i
    end
  end

  def choose_bigger_number_than(last_pick)
    prompt "Entre un nombre plus grand: "
    self.guess = gets.to_i
    until (1..100).cover?(guess)
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

  def choose_smaller_number_than(last_pick)
    prompt "Entre un nombre plus petit: "
    self.guess = gets.to_i
    until (1..100).cover?(guess)
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

  def initialize
    @name = set_name
    @guess = 0
  end

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
