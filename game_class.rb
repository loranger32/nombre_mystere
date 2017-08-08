class Game
  include Displayable

  attr_accessor :player, :mystery_number, :stat

  MAX_ATTEMPTS = 7

  def play
    start_game
    loop do
      process_game
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
 devoir le deviner. Tu as droit à #{MAX_ATTEMPTS} tentatives."
  end

  def display_goodbye
    prompt "Ok, merci d'avoir joué #{player}, et à une prochaine fois :-)".blue
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
      break if number_found? || max_attempts_reached?
      try_again
    end
  end

  def max_attempts_reached?
    stat.round_attempts >= MAX_ATTEMPTS
  end

  def display_congratulations
    prompt "Bravo #{player}, tu as trouvé le nombre mystère:\
 #{mystery_number}!!!".green
  end

  def display_loosing_message
    prompt "Dommage #{player}!!! Tu n'as pas trouvé le nombre mystère,\
 c'était #{mystery_number}."
  end

  def process_game
    initialize_mystery_number
    player.choose_number
    stat.add_attempt
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
    prompt "Il te reste #{MAX_ATTEMPTS - stat.round_attempts} tentatives."
  end

  def request_bigger_number_than(last_guess)
    prompt "Le nombre mystère est plus grand.".red
    display_remaining_attempts
    player.choose_bigger_number_than(last_guess)
    stat.add_attempt
  end

  def request_smaller_number_than(last_guess)
    prompt "Le nombre mystère est plus petit.".blue
    display_remaining_attempts
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
