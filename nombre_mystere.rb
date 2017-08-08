require 'pry'
require 'colorize'

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
  - nombres trouvés: #{victories}\n\
  - tentatives de ce tour: #{round_attempts}\n\
  - moyenne de tentatives par tour: #{average_attempts}.\n\
******************".green
  end
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

  attr_accessor :player, :mystery_number, :stat

  def play
    start_game
    loop do
      initialize_mystery_number
      player.choose_number
      stat.add_attempt
      process_results
      number_found? ? process_victory : process_defeat
      show_stats
      break unless play_again?
      process_new_game
    end
    display_goodbye
  end

  private

  def initialize
    @player = nil
    @mystery_number = nil
    @stat = Stats.new
  end

  def start_game
    clear_screen
    display_title
    initialize_player
    display_welcome
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
    puts stat
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
  end

  def display_congratulations
    prompt "Bravo #{player}, tu as trouvé le nombre mystère:\
 #{mystery_number}!!!".green
  end

  def display_lossing_message
    prompt "Dommage #{player}!!! Tu n'as pas trouvé le nombre mystère,\
 c'était #{mystery_number}."
  end

  def number_found?
    mystery_number.current_pick == player.guess
  end

  def try_again
    last_guess = player.guess

    if last_guess < mystery_number.current_pick
      request_bigger_number_than(last_guess)
    elsif last_guess > mystery_number.current_pick
      request_smaller_number_than(last_guess)
    end
  end

  def request_bigger_number_than(last_guess)
    prompt "Le nombre mystère est plus grand.".red
    player.choose_bigger_number_than(last_guess)
    stat.add_attempt
  end

  def request_smaller_number_than(last_guess)
    prompt "Le nombre mystère est plus petit.".blue
    player.choose_smaller_number_than(last_guess)
    stat.add_attempt
  end

  def process_victory
    display_congratulations
    stat.add_victory
  end

  def process_defeat
    display_loosing_message
    stat.add_defeat
  end

  def process_new_game
    stat.add_round
    stat.reset_round_attempts
    display_start_again
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
