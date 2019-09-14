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

  def my_all
    pos = 0
    i = 0
    while i < size
      pos += 1 if yield(self[i]) == true
      i += 1
    end
    pos == size
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

  def my_count
    count = 0
    i = 0
    while i < size
      count += 1 if yield(self[i] == true)
      i += 1
    end
    count
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
