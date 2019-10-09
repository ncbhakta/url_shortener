module BaseConverter
  BASE_62_DIGITS = [('0'..'9'), ('A'..'Z'), ('a'..'z')].map(&:to_a).flatten.freeze

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
  end
end
