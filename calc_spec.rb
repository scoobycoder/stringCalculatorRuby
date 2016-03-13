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

  it 'Sum should throw and exception when negative numbers are passed' do
    expect { @calc.sum('//;2;-1;-5') }.to raise_error
  end

end

class StringCalc
  def sum(numbers=0)
    return 0 if numbers == 0
    convert_to_integers(numbers).inject(0, :+)
  end

  private

  def convert_to_integers(numbers)
    new_numbers = split_with_delimiter(numbers).collect { |number| number.to_i }
    raise_exception_on_negative_numbers(new_numbers)
    new_numbers
  end

  def raise_exception_on_negative_numbers(new_numbers)
    negatives = select_negative_numbers(new_numbers)
    print_negatives(negatives)
    raise "No Negative Numbers Allowed: #{negatives.to_s}" if negatives.length > 0
  end

  def print_negatives(negatives)
    puts "Negative numbers: #{negatives.to_s}" if negatives.length > 0
  end

  def select_negative_numbers(new_numbers)
    new_numbers.select { |number| number < 0 }
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