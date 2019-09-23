# frozen_string_literal: true

module Enumerable
  def my_each
    return to_enum(:each) unless block_given?

    i = 0
    while i < size
      yield(self[i])
      i += 1
    end
  end

  def my_each_with_index
    return to_enum(:each) unless block_given?

    i = 0
    while i < size
      yield(self[i], i)
      i += 1
    end
  end

  def my_select
    return to_enum(:each) unless block_given?

    new_arr = []
    my_each do |x|
      new_arr << x if yield(x) == true
    end
    new_arr
  end

  def my_any?(arg = nil)
    count = []
    if arg.nil?
      if block_given?
        my_each do |x|
          count << true if yield(x) == true
        end
      end
      count = my_select { |x| x != false && !x.nil? }
    end

    unless arg.nil?
      if arg.class == Class
        count = my_select { |x| x.is_a?(arg) }
      elsif arg.class == Regexp

        my_each do |x|
          return true if x.match(arg)
        end
      else
        count = my_select { |x| x == arg }
      end
    end
    count.size.positive?
  end

  def my_all?(arg = nil)
    unless block_given?
      falsy = 0
      if arg.nil?
        my_each do |x|
          falsy += 1 if x == false || x.nil?
        end
      elsif arg.class == Class
        my_each do |x|
          falsy += 1 unless x.is_a?(arg)
        end
      elsif arg.class == Regexp
        num = 0
        my_each do |x|
          num += 1 if x.match(arg)
        end
        return num == size
      end
      return self == [arg]
      return falsy.zero?
      
    end

    pos = 0
    my_each do |x|
      pos += 1 if yield(x) == true
    end
    pos == size
  end

  def my_none?(arg = nil)
    count = []
    if block_given?
      my_each do |x|
        count << true if yield(x) == true
      end
    elsif arg.nil?
        count = my_select { |x| !x.nil? && x != false }
    elsif arg.class == Class
        count = my_select { |x| x.is_a?(arg) }
    elsif arg.class == Regexp
        num = 0
        my_each do |x|
          num += 1 if x.match(arg)
        end
        return num.zero?
    end

    count.size.zero?
  end

  def my_count(arg = nil)
    unless arg.nil?
      count = 0
      my_each do |x|
        count += 1 if x == arg
      end
      count
    end

    if block_given?
      count = 0
      my_each do |x|
        count += 1 if yield(x) == true
      end
      count
    end

    size if arg.nil?
  end

  def my_map(&block)
    return to_enum(:each) unless block_given?

    new_arr = []
    my_each do |x|
      new_arr << block.call(x)
    end
    new_arr
  end

  def my_inject(*params)
    symbol_obj = %i[+ - * /]
    res = to_a
    final = res[0]

    if params.empty?
      # do normal block and conversion from range stuff
      drop(1).my_each do |x|
        final = yield(final, x)
      end
      final
    else
      # if its not empty, it either has an integer or a block
      symbol = ''
      number = ''

      if params.size <= 2 && params.my_any?(Symbol)
        symbol = params[0]
        number = params[1]

        drop(1).my_each do |x|
          final = if symbol == symbol_obj[0]
                    final + x
                  elsif symbol == symbol_obj[1]
                    final - x
                  elsif symbol == symbol_obj[2]
                    final * x
                  else
                    final / x
                  end
        end
        return final * number if params.size == 2

        final
      elsif params[0].is_a?(Integer)
        drop(1).my_each do |x|
          final = yield(final, x)
        end
        final *= params[0]
      end
    end
  end
end

def multiply_els(arr)
  arr.my_inject do |total, multiple|
    total * multiple
  end
end
