require 'bundler/setup'
require 'colorize'
require_relative 'displayable_module'
require_relative 'game_class'
require_relative 'player_class'
require_relative 'stats_class'
require_relative 'mystery_number_class'

Game.new.play
