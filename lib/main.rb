# frozen_string_literal: true

module Enumerable
  def my_each
    i = 0
    while i < size
      yield(self[i])
      i += 1
    end
  end

  def my_each_with_index
    i = 0
    while i < size
      yield(self[i], i)
      i += 1
    end
  end

  def my_select
    new_arr = []
    my_each do |x|
      new_arr << x if yield(x) == true
    end
    new_arr
  end

  def my_all(arg = nil)
    unless block_given?
      if arg.nil?
        falsy = 0
        my_each do |x|
          falsy += 1 if x == false || x.nil?
        end
        return falsy.zero?
      else
        return self == [arg]
      end
    end

    pos = 0
    my_each do |x|
      pos += 1 if yield(x) == true
    end
    pos == size
  end

  def my_any(arg = nil)
    #     unless block_given?
    if arg.nil?
      count = 0
      my_each do |x|
        count += 1 if x != false
      end
      return count.positive?
    end
    #     end

    unless arg.nil?
      count = 0
      my_each do |x|
        count += 1 if x == arg
      end
      return count.positive?
    end

    my_each do |x|
      return true if yield(x) == true
    end
    false
  end

  def my_none
    pos = 0
    my_each do |x|
      pos += 1 if yield(x) == false
    end
    pos == size
  end

  def my_count(arg = nil)
    unless arg.nil?
      count = 0
      my_each do |x|
        count += 1 if x == arg
      end
      return count
    end

    if block_given?
      count = 0
      my_each do |x|
        count += 1 if yield(x) == true
      end
      return count
    end

    return size if arg.nil?
  end

  def my_map(&block)
    new_arr = []
    my_each do |x|
      new_arr << block.call(x)
    end
    new_arr
  end

  def my_inject(param = nil)
    final = self[0]
    my_each do |x|
      final = yield(final, x)
    end
    if param.nil?
      final
      yield(final, param)
    end
  end
end

def multiply_els(arr)
  arr.my_inject do |total, multiple|
    total * multiple
  end
end
