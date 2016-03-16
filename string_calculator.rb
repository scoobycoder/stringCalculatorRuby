class StringCalc
  def sum(numbers=0)
    return 0 if numbers == 0
    convert_to_integers(numbers).inject(0, :+)
  end

  private

  def convert_to_integers(numbers)
    new_numbers = split_with_delimiter(numbers).collect { |number| number.to_i }
    handle_special_numbers(new_numbers)
  end

  def handle_special_numbers(new_numbers)
    raise_exception_on_negative_numbers(new_numbers)
    filter_out_numbers_larger_than_1000(new_numbers)
  end

  def filter_out_numbers_larger_than_1000(new_numbers)
    new_numbers.select { |number| number < 1001}
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
    new_numbers = remove_delimiter_special_characters(new_numbers)
    return new_numbers.split(delimiter)
  end

  def remove_delimiter_special_characters(new_numbers)
    new_numbers.gsub('//[', '').gsub(']', '')
  end

  def find_delimiter(new_numbers)
    delimiter_start_offset = 3
    delimiter_end_offset = -1
    delimiter_start_location = new_numbers.index('//[') + delimiter_start_offset
    delimiter_end_location = new_numbers.index(']') + delimiter_end_offset
    delimiter = new_numbers[delimiter_start_location..delimiter_end_location]
    return delimiter
  end

  def remove_new_line(numbers)
    numbers.gsub('\n', '')
  end
end