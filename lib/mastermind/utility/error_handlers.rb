# frozen_string_literal: true

# ErrorHandlers is a module that contains utility methods for
# validating values and handling errors used by components
# of Mastermind Program
module ErrorHandlers
  def validate_option!(selected, opts, msg = '')
    raise ArgumentError, "\nInvalid option! #{msg}" unless opts.include?(selected)
  end

  def ensure_uniq!(val, arr, msg = '')
    raise ArgumentError, "\nTry again! #{msg}" if arr.include?(val)
  end

  def value_for!(hash, key, msg: "\nUnknown error key: ")
    hash.fetch(key) do
      raise KeyError, "#{msg} #{key.inspect}"
    end
  end

  def str_max_len!(str, str_len, msg = '')
    raise ArgumentError, "\nTry again! #{msg}" unless str =~ /[1-#{str_len}]{#{str_len}}$/
  end

  def int_between!(len, range, msg = '')
    raise ArgumentError, "\nInvalid input! #{msg}" unless len.between?(*range)
  end

  def convertible_to_i!(input)
    raise ArgumentError, "\nMust be integer!" unless Integer(input)
  end
end
