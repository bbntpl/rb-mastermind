# frozen_string_literal: true

# GameValidation is a module that contains utility methods for
# value validation mostly used by components of Mastermind Program
module GameValidation
  def validate_option!(selected, opts, msg)
    raise ArgumentError, msg unless opts.include?(selected)
  end

  def value_for!(hash, key, msg: 'Unknown error key: ')
    hash.fetch(key) do
      raise KeyError, "#{msg} #{key.inspect}"
    end
  end

  def str_max_len!(str, str_len, msg)
    raise ArgumentError, msg unless str =~ /[1-#{str_len}]{#{str_len}}$/
  end

  def int_between!(len, range, msg)
    raise ArgumentError, msg unless len.between?(*range)
  end
end
