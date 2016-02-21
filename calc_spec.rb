require 'rspec'

describe 'Be a Calculator' do

  before do
    @calc = StringCalc.new
  end

  it 'Sum should eat any character that is not a numbers' do
    expect(@calc.sum(['a', 1])).to eq(1)
  end

  it 'Sum should return 0 when nothing is passed to it' do
    expect(@calc.sum()).to eq(0)
  end

end

class StringCalc
  def sum(numbers=[0])
    filtered_numbers = numbers.select{|number| number.is_a?(Fixnum)}
    filtered_numbers.first
  end
end