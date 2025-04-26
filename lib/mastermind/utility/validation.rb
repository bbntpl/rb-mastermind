# frozen_string_literal: true

# Validation is a module that contains utility methods for
# validating values used by components of Mastermind Program
module Validation
  def validate_option!(selected, opts, msg)
    raise ArgumentError 'Invalid option!' unless opts.include?(selected)
  rescue ArgumentError => e
    puts "#{e} #{msg}: "
  end

  def value_for!(hash, key, msg: 'Unknown error key: ')
    hash.fetch(key) do
      raise KeyError, "#{msg} #{key.inspect}"
    end
  end

  def str_max_len!(str, str_len, msg)
    raise ArgumentError, 'Try again!' unless str =~ /[1-#{str_len}]{#{str_len}}$/
  rescue ArgumentError => e
    puts "#{e} #{msg}: "
  end

  def int_between!(len, range, msg)
    raise ArgumentError, 'Invalid input!' unless len.between?(*range)
  rescue ArgumentError => e
    puts "#{e} #{msg}: "
  end
end
