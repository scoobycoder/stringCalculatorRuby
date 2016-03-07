require 'rspec'

describe 'Be a Calculator' do

  before do
    @calc = StringCalc.new
  end

  it 'Sum should eat any character that is not a numbers' do
    expect(@calc.sum('//,a,1')).to eq(1)
  end

  it 'Sum should return 0 when nothing is passed to it' do
    expect(@calc.sum).to eq(0)
  end

  it 'Sum should add two numbers' do
    expect(@calc.sum('//,1,1')).to eq(2)
  end

  it 'Sum should allow for any delimiter that is passed at beginning of string' do
    expect(@calc.sum('//;\n1;2')).to eq(3)
  end

end

class StringCalc
  def sum(numbers=0)
    return 0 if numbers == 0
    convert_to_integers(numbers).inject(0, :+)
  end

  private

  def convert_to_integers(numbers)
    split_with_delimiter(numbers).collect { |number| number.to_i }
  end

  def split_with_delimiter(numbers)
    new_numbers = remove_new_line(numbers)
    delimiter = find_delimiter(new_numbers)
    return new_numbers.split(delimiter)
  end

  def find_delimiter(new_numbers)
    delimiter_offset = 2
    delimiter_location = new_numbers.index('//') + delimiter_offset
    delimiter = new_numbers[delimiter_location]
    return delimiter
  end

  def remove_new_line(numbers)
    numbers.gsub('\n', '')
  end
end