require_relative "alfanumerico/version"

module Cnpj
  module Alfanumerico
    BODY_LENGTH = 12
    FULL_LENGTH = 14
    FIRST_WEIGHTS = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2].freeze
    SECOND_WEIGHTS = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2].freeze
    BODY_PATTERN = /\A[0-9A-Z]{12}\z/.freeze
    FULL_PATTERN = /\A[0-9A-Z]{12}[0-9]{2}\z/.freeze
    FORMATTED_PATTERN = /\A([0-9A-Z]{2})([0-9A-Z]{3})([0-9A-Z]{3})([0-9A-Z]{4})([0-9]{2})\z/.freeze

    module_function

    def normalize(value)
      value.to_s.gsub(/[^0-9A-Za-z]/, "").upcase
    end

    def formatted?(value)
      /\A[0-9A-Z]{2}\.[0-9A-Z]{3}\.[0-9A-Z]{3}\/[0-9A-Z]{4}-[0-9]{2}\z/.match?(value.to_s.upcase)
    end

    def char_value(char)
      code = char.to_s.upcase.ord
      return code - 48 if code.between?(48, 57)
      return code - 48 if code.between?(65, 90)

      raise ArgumentError, "Invalid CNPJ character: #{char}"
    end

    def calculate_check_digits(base)
      normalized = normalize(base)
      raise ArgumentError, "Base CNPJ must contain exactly 12 alphanumeric characters." unless BODY_PATTERN.match?(normalized)

      first_digit = compute_digit(normalized, FIRST_WEIGHTS)
      second_digit = compute_digit("#{normalized}#{first_digit}", SECOND_WEIGHTS)

      "#{first_digit}#{second_digit}"
    end

    def generate(base)
      normalized = normalize(base)
      "#{normalized}#{calculate_check_digits(normalized)}"
    end

    def valid?(value)
      normalized = normalize(value)
      return false unless FULL_PATTERN.match?(normalized)

      base = normalized[0, BODY_LENGTH]
      dv = normalized[BODY_LENGTH, 2]
      calculate_check_digits(base) == dv
    end

    def assert_valid!(value)
      normalized = normalize(value)
      raise ArgumentError, "Invalid CNPJ." unless valid?(normalized)

      normalized
    end

    def format(value)
      normalized = normalize(value)
      raise ArgumentError, "CNPJ must contain 12 alphanumeric characters followed by 2 numeric check digits." unless FULL_PATTERN.match?(normalized)

      match = FORMATTED_PATTERN.match(normalized)
      "#{match[1]}.#{match[2]}.#{match[3]}/#{match[4]}-#{match[5]}"
    end

    def split(value)
      normalized = normalize(value)
      raise ArgumentError, "Invalid CNPJ." unless FULL_PATTERN.match?(normalized)

      {
        raiz: normalized[0, 8],
        ordem: normalized[8, 4],
        dv: normalized[12, 2]
      }
    end

    def compute_digit(base, weights)
      sum = base.chars.each_with_index.sum do |char, index|
        char_value(char) * weights[index]
      end

      remainder = sum % 11
      remainder < 2 ? 0 : 11 - remainder
    end
    private_class_method :compute_digit
  end
end
