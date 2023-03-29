# Usage:
#
# CaesarCipherService.new("abcdefghijklmnopqrstuvwxyz", 0).call
# => abcdefghijklmnopqrstuvwxyz
# CaesarCipherService.new("abcdefghijklmnopqrstuvwxyz", 1).call
# => bcdefghijklmnopqrstuvwxyza
# CaesarCipherService.new("abcdefghijklmnopqrstuvwxyz", 25).call
# => zabcdefghijklmnopqrstuvwxy
class CaesarCipherService
  CHARS = %w(a b c d e f g h i j k l m n o p q r s t u v w x y z).freeze

  attr_reader :string, :shift

  def initialize(string, shift)
    raise ArgumentError if string.nil? || string.empty?
    raise ArgumentError unless shift.between?(0, CHARS.length - 1)

    @string = string.dup
    @shift = shift
  end

  def call
    return string if shift.zero?

    chars_length = CHARS.length

    (0...string.length).each do |index|
      next unless /[a-z]/i.match? char = string[index]

      cipher_char_index = CHARS.index(char.downcase) + shift
      cipher_char_index = cipher_char_index - chars_length unless cipher_char_index < chars_length
      string[index] = /[[:upper:]]/.match?(char) ? CHARS[cipher_char_index].upcase : CHARS[cipher_char_index]
    end

    string
  end

  private

  attr_writer :string, :shift
end
