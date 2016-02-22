require 'rspec'

describe 'Be a Calculator' do

  before do
    @calc = StringCalc.new
  end

  it 'Sum should eat any character that is not a numbers' do
    expect(@calc.sum('a,1')).to eq(1)
  end

  it 'Sum should return 0 when nothing is passed to it' do
    expect(@calc.sum).to eq(0)
  end

  it 'Sum should add two numbers' do
    expect(@calc.sum('1,1')).to eq(2)
  end

  it 'Sum should allow for new line characters instead of commas' do
    expect(@calc.sum('1\n2,3')).to eq(6)
  end

end

class StringCalc
  def sum(numbers=0)
    return 0 if numbers == 0
    convert_to_integers(numbers).inject(0, :+)
  end

  private

  def convert_to_integers(numbers)
    create_numbers_array(numbers).collect { |number| number.to_i }
  end

  def create_numbers_array(numbers)
    split_newline(numbers).collect { |number| number.split(',') }.flatten!
  end

  def split_newline(numbers)
    numbers.split('\n')
  end
end