require_relative '../lib/displayable_module'
require_relative '../lib/stats_class'

describe "A stat" do

  before do
    @stat = Stats.new
  end

    it 'has a victories attribute set to 0' do
      expect(@stat.victories).to eq(0)
    end

    it 'has a defeats attribute set to 0' do
      expect(@stat.defeats).to eq(0)
    end

    it 'has a round_attempts attribute set to 0' do
      expect(@stat.round_attempts).to eq(0)
    end

    it 'has a total_attempts attribute set to 0' do
      expect(@stat.total_attempts).to eq(0)
    end

    it 'has a rounds attribute set to 1' do
      expect(@stat.rounds).to eq(1)
    end

    it 'can have a victory added' do
      @stat.add_victory
      expect(@stat.victories).to eq(1)
    end

    it 'can have a defeat added' do
      @stat.add_defeat
      expect(@stat.defeats).to eq(1)
    end

    it 'can have a round added' do
      @stat.add_round
      expect(@stat.rounds).to eq(2)
    end

    it 'can have both round_attempts and total_attempts increased by one when\
 an attempt is added' do
      @stat.add_attempt
      expect(@stat.round_attempts).to eq(1)
      expect(@stat.total_attempts).to eq(1)
    end

    it 'can have round_attemps reset' do
      @stat.reset_round_attempts
      expect(@stat.round_attempts).to eq(0)
    end

    it 'can calculate the average attempts through rounds' do
    end
end
