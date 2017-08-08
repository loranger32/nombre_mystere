require_relative '../displayable_module'
require_relative '../player_class'

describe 'A player' do

  before do
    @player = Player.new

  end
  it 'has a name' do
    expect(@player.name).not_to be_nil
  end

  it 'has a number of guess equal to 0' do
    expect(@player.guess).to eq(0)
  end
end
