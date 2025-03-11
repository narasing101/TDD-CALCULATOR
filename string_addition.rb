require 'minitest/autorun'

class StringCalculator
  class NegativeNumberError < StandardError; end

  def add(numbers)
    return 0 if numbers.empty?

    delimiter = ",|\n"
    if numbers.start_with?("//")
      parts = numbers.split("\n", 2)
      delimiter_part = parts[0][2..-1]

      if delimiter_part.start_with?('[') && delimiter_part.end_with?(']')
        delimiters = delimiter_part[1..-2].split('][')
        delimiter = delimiters.map { |d| Regexp.escape(d) }.join('|')
      else
        delimiter = Regexp.escape(delimiter_part)
      end

      numbers = parts[1]
    end

    number_list = numbers.split(/#{delimiter}/).map(&:to_i).reject { |n| n > 1000 }
    negatives = number_list.select { |n| n < 0 }

    if negatives.any?
      raise NegativeNumberError, "negative numbers not allowed: #{negatives.join(', ')}"
    end

    number_list.reduce(0, :+)
  end
end

