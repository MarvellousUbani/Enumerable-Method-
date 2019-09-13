
module Enumerable
  def my_each
    for i in 0...self.size
      yield(self[i])
    end
  end

  def my_each_with_index
    for i in 0...self.size
      yield(self[i], i)
    end
  end

  def my_select
    newArr = []
    for i in 0...self.size
      newArr << self[i] if yield(self[i]) == true
    end
    return newArr
  end

  def my_all
    pos = 0
    for i in 0...self.size
      pos += 1 if yield(self[i]) == true
    end
    pos == self.size
  end

  def my_none
    pos = 0
    for i in 0...self.size
      pos += 1 if yield(self[i]) == false
    end
    pos == self.size
  end

  def my_count
    count = 0
    for i in 0...self.size
      count +=1 if yield(self[i]== true)
    end
    return count
  end

  def my_map(&block)
    newArr = []
    for i in 0...self.size
      newArr << block.call(self[i])
    end
    return newArr
  end

  def my_inject
    final = self[0]
    for i in 1...self.size
      final = yield(final,self[i])
    end
    return final
  end

end

def multiply_els(arr)
  arr.my_inject{|total, multiple| total * multiple}
end


