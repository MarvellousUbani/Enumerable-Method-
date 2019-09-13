# frozen_string_literal: true

module Enumerable
  def my_each
    (0...size).each do |i|
      yield(self[i])
    end
  end

  def my_each_with_index
    (0...size).each do |i|
      yield(self[i], i)
    end
  end

  def my_select
    new_arr = []
    (0...size).each do |i|
      new_arr << self[i] if yield(self[i]) == true
    end
    new_arr
  end

  def my_all
    pos = 0
    (0...size).each do |i|
      pos += 1 if yield(self[i]) == true
    end
    pos == size
  end

  def my_none
    pos = 0
    (0...size).each do |i|
      pos += 1 if yield(self[i]) == false
    end
    pos == size
  end

  def my_count
    count = 0
    (0...size).each do |i|
      count += 1 if yield(self[i] == true)
    end
    count
  end

  def my_map(&block)
    new_arr = []
    (0...size).each do |i|
      new_arr << block.call(self[i])
    end
    new_arr
  end

  def my_inject
    final = self[0]
    (1...size).each do |i|
      final = yield(final, self[i])
    end
    final
  end
end

def multiply_els(arr)
  arr.my_inject { |total, multiple| total * multiple }
end
