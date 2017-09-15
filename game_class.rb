require 'pry'

class Game
  include Displayable

  attr_accessor :player, :range, :mystery_number, :optimal_guess_attempts, :stat

  def initialize
    @player                 = nil
    @range                  = nil
    @mystery_number         = nil
    @optimal_guess_attempts = nil
    @stat                   = Stats.new
  end

  def initialize_player
    self.player = Player.new
  end

  def initialize_mystery_number(range)
    self.mystery_number = MysteryNumber.new(range[0], range[1])
  end

  def initialize_range
    self.range = player.choose_range
  end

  def initialize_optimal_guess_attempts
    self.optimal_guess_attempts = Math.log2(range[1] - range[0]).to_i + 1
  end

  def play
    start_game
    loop do
      initialize_mystery_number(range)
      process_game
      number_found? ? process_victory : process_defeat
      show_stats
      break unless play_again?
      process_new_game
    end
    display_goodbye
  end

  private

  def start_game
    clear_screen
    display_title
    initialize_player
    initialize_range
    initialize_optimal_guess_attempts
    display_welcome
  end

  def display_title
    title = "Bienvenue dans le jeu NOMBRE MYSTERE"
    border = ('*' * title.size)
    puts border.center(110)
    puts title.center(110)
    puts border.center(110)
  end

  def display_welcome
    prompt "Bonjour #{player}!"
    prompt "Dans ce jeu, je vais choisir un nombre entre #{range[0]}\
 et #{range[1]}, et tu vas devoir le deviner.\
 Tu as droit à #{optimal_guess_attempts} tentatives."
  end

  def display_goodbye
    prompt "Ok, merci d'avoir joué #{player}, et à une prochaine fois :-)".blue
  end

  def show_stats
    puts stat
  end

  def process_results
    loop do
      break if number_found? || max_attempts_reached?
      try_again
    end
  end

  def max_attempts_reached?
    stat.round_attempts >= optimal_guess_attempts
  end

  def display_congratulations
    prompt "Bravo #{player}, tu as trouvé le nombre mystère:\
 #{mystery_number}!!!".green
  end

  def display_loosing_message
    prompt "Dommage #{player}!!! Tu n'as pas trouvé le nombre mystère,\
 c'était #{mystery_number}."
  end

  def ask_player_choice
    player.choose_number_from(range)
    stat.add_attempt
  end

  def process_game
    ask_player_choice
    process_results
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

  def display_remaining_attempts
    prompt "Il te reste #{optimal_guess_attempts - stat.round_attempts} tentatives."
  end

  def request_bigger_number_than(last_guess)
    prompt "Le nombre mystère est plus grand.".red
    display_remaining_attempts
    player.choose_bigger_number_than(last_guess, range)
    stat.add_attempt
  end

  def request_smaller_number_than(last_guess)
    prompt "Le nombre mystère est plus petit.".blue
    display_remaining_attempts
    player.choose_smaller_number_than(last_guess, range)
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
    initialize_range
    initialize_optimal_guess_attempts
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
    prompt "Tu dois trouver un nombre entre #{range[0]} et #{range[1]},\
 en #{optimal_guess_attempts} tentatives."
  end
end
