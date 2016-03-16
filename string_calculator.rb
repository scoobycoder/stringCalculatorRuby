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
    delimiters = find_delimiter(new_numbers)
    new_numbers = remove_delimiter_special_characters(new_numbers)
    return split_on_all_delimiters(new_numbers, delimiters)
  end

  def split_on_all_delimiters(new_numbers, delimiters, newer_numbers=[])
    return newer_numbers if delimiters.length == 0
    new_numbers = new_numbers.lines.to_a if new_numbers.is_a?(String)
    delimiter = delimiters.pop
    newer_numbers = new_numbers.collect {|number| number.split(delimiter)}.flatten
    split_on_all_delimiters(newer_numbers.flatten, delimiters, newer_numbers)
  end

  def remove_delimiter_special_characters(new_numbers)
    new_numbers.gsub('//[', '').gsub(']', '').gsub('[','')
  end

  def find_delimiter(new_numbers, delimiters=[])
    newer_numbers = new_numbers
    delimiter_start_offset = 3
    delimiter_end_offset = -1
    delimiter_start_location = new_numbers.index('//[') + delimiter_start_offset
    delimiter_end_location = new_numbers.index(']') + delimiter_end_offset
    delimiter = new_numbers[delimiter_start_location..delimiter_end_location]
    remove_delimiter = '[' + delimiter + ']'
    newer_numbers = newer_numbers.gsub(remove_delimiter,'')
    delimiters << delimiter
    return delimiters if !newer_numbers.include?('[')
    find_delimiter(newer_numbers, delimiters)
  end

  def remove_new_line(numbers)
    numbers.gsub('\n', '')
  end
end