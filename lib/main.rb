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
    i = 0
    while i < size
      new_arr << self[i] if yield(self[i]) == true
      i += 1
    end
    new_arr
  end

  def my_all(arg = nil)
    unless block_given?
      if arg.nil?
        my_each do |x|
          return false if x == false || x.nil?
        end
        return true
      end
    end

    return self == [arg] unless arg.nil?

    if block_given?
      pos = 0
      i = 0
      while i < size
        pos += 1 if yield(self[i]) == true
        i += 1
      end
      pos == size
    end
  end

  def my_any(arg = nil)
    unless block_given?
      if arg.nil?
        my_each do |x|
          return false if x == false || x.nil?
        end
        return true
      end
    end

    unless arg.nil?
      my_each do |x|
        return true if x == arg
      end
      return false
    end

    if block_given?
      my_each do |x|
        return true if yield(x) == true
      end
      return false
    end
  end

  def my_none
    pos = 0
    i = 0
    while i < size
      pos += 1 if yield(self[i]) == false
      i += 1
    end
    pos == size
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
      return count
    end

    return size if arg.nil?
  end

  def my_map(&block)
    new_arr = []
    i = 0
    while i < size
      new_arr << block.call(self[i])
      i += 1
    end
    new_arr
  end

  def my_inject
    final = self[0]
    i = 0
    while i < size
      final = yield(final, self[i])
      i += 1
    end
    final
  end
end

def multiply_els(arr)
  arr.my_inject do |total, multiple|
    total * multiple
  end
end
