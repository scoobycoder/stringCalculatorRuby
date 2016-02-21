require 'rspec'

describe 'Be a Calculator' do

  before do
    @calc = StringCalc.new
  end

  it 'Sum should eat any character that is not a numbers' do
    expect(@calc.sum(['a', 1])).to eq(1)
  end

end

class StringCalc
  def sum(numbers=[])
    filtered_numbers = numbers.select{|number| number.is_a?(Fixnum)}
    filtered_numbers.first
  end
end