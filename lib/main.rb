# frozen_string_literal: true


module Enumerable
  def my_each
    for i in 0...size
      yield(self[i])
    end
  end

  def my_each_with_index
    for i in 0...size
      yield(self[i], i)
    end
  end

  def my_select
    new_arr = []
    for i in 0...size
      new_arr << self[i] if yield(self[i]) == true
    end
    return new_arr
  end

  def my_all
    pos = 0
    for i in 0...size
      pos += 1 if yield(self[i]) == true
    end
    pos == self.size
  end

  def my_none
    pos = 0
    for i in 0...size
      pos += 1 if yield(self[i]) == false
    end
    pos == self.size
  end

  def my_count
    count = 0
    for i in 0...size
      count +=1 if yield(self[i]== true)
    end
    return count
  end

  def my_map(&block)
    new_arr = []
    for i in 0...size
      new_arr << block.call(self[i])
    end
    return new_arr
  end

  def my_inject
    final = self[0]
    for i in 1...size
      final = yield(final,self[i])
    end
    return final
  end

end

def multiply_els(arr)
  arr.my_inject{|total, multiple| total * multiple}
end


