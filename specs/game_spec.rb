require_relative '../lib/displayable_module'
require_relative '../lib/player_class'
require_relative '../lib/stats_class'
require_relative '../lib/mystery_number_class'
require_relative '../lib/game_class'

describe 'Game' do

  context 'when initialized at first' do

    before do
      @game = Game.new
    end

    it "has an uninitialized player as attribute" do
      expect(@game.player).to eq(nil)
    end

    it "has an uninitialized mystery number as attribute" do
      expect(@game.mystery_number).to eq(nil)
    end

    it "has a stat object as attribute" do
      expect(@game.stat).to be_instance_of(Stats)
    end
  end

  context 'when a player and a stat have been initialized' do
    before do
      @game = Game.new
      @game.initialize_player
      @game.initialize_mystery_number
    end

    it "has a player as attribute" do
      expect(@game.player).to be_instance_of(Player)
    end

    it "has a mystery_number as attribute" do
      expect(@game.mystery_number).to be_instance_of(MysteryNumber)
    end

    it "still has a stat object as attribute" do
      expect(@game.stat).to be_instance_of(Stats)
    end
  end
end
