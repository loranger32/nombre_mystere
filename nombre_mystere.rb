require 'pry'

module Displayable
  def prompt(message)
    puts "=> #{message}"
  end

  def clear_screen
    system('clear') || system('cls')
  end
end

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

class Stats
  attr_accessor :victories
end

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

class Game
  include Displayable

  attr_accessor :player, :mystery_number

  def play
    clear_screen
    display_title
    initialize_player
    display_welcome
    loop do
      initialize_mystery_number
      player.choose_number
      process_results
      break unless play_again?
      display_start_again
    end
    show_stats
    display_goodbye
  end

  private

  def initialize
    @player = nil
    @mystery_number = nil
  end

  def display_welcome
    prompt "Bonjour #{player}!"
    prompt "Dans ce jeu, je vais choisir un nombre entre 1 et 100, et tu vas\
 devoir le deviner."
  end

  def display_goodbye
    prompt "Ok, merci d'avoir joué #{player}, et à une prochaine fois :-)"
  end

  def show_stats
    prompt "Show stats not imlplemented yet"
  end

  def display_title
    title = "Bienvenue dans le jeu NOMBRE MYSTERE"
    border = ('*' * title.size)
    puts border.center(110)
    puts title.center(110)
    puts border.center(110)
  end

  def initialize_player
    self.player = Player.new
  end

  def initialize_mystery_number
    self.mystery_number = MysteryNumber.new
  end

  def process_results
    loop do
      break if number_found?
      try_again
    end
    prompt "Bravo #{player}, tu as trouvé le nombre mystère:\
 #{mystery_number}!!!"
  end

  def number_found?
    mystery_number.current_pick == player.guess
  end

  def try_again
    last_guess = player.guess

    if last_guess < mystery_number.current_pick
      prompt "Le nombre mystère est plus grand."
      player.choose_bigger_number_than(last_guess)
    elsif last_guess > mystery_number.current_pick
      prompt "Le nombre mystère est plus petit."
      player.choose_smaller_number_than(last_guess)
    end
  end

  def play_again?
    prompt "Veux-tu faire une autre partie #{player} ('o' ou 'n')?"
    answer = gets.chomp.downcase
    until ['o', 'n'].include?(answer)
      prompt "Je n'ai pas compris ton choix. Tu dois entrer 'o' ou 'n'."
      answer = gets.chomp.downcase
    end
    answer == 'o' ? true : false
  end

  def display_start_again
    prompt "Ok #{player}, on recommence!"
  end
end

Game.new.play
