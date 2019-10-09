module BaseConverter
  BASE_62_DIGITS = [('0'..'9'), ('A'..'Z'), ('a'..'z')].map(&:to_a).flatten.freeze
  BASE_62_VALUES = BASE_62_DIGITS.zip((0..61).to_a).to_h

  def base_10_to_62(base10)
    dividend = base10.to_i

    return '0' if dividend == 0

    base62 = ''

    while dividend > 0
      remainder = dividend % 62
      digit = BASE_62_DIGITS[remainder]
      base62.prepend(digit)
      dividend /= 62
    end

    base62
  end

  def base_62_to_10(base64)
    base10 = 0
    exponent = 0

    while !base64.empty?
      digit = base64.slice!(-1)
      value = BASE_62_VALUES[digit]
      base10 += value * (62**exponent)
      exponent += 1
    end

    base10.to_s
  end
end
