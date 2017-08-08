require_relative 'nombre_mystere'

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
end
