require_relative 'student_tree.rb'

class ArrayProcessor
  
  def initialize (origin_array)
    @array = origin_array[0..-1]
    @size = origin_array.length
  end 

  attr_reader :size

  def get_by_id(i)
    if i.nil? or i.class != Integer
      raise ArgumentError, "the index must be integer! given: #{nil ? i.nil? : i.class}"
    end
    if i.abs >= self.size
      raise IndexError, "the index out of range!"
    end
    return @array[i] 
  end

  def to_a
    if @size == 0
      raise "There are no elements in the array!"
    end
    return @array[0..-1] 
  end

  def each 
    i = 0
    until i == @size
      yield self.get_by_id(i)
      i+=1
    end
  end

  def find
    self.each do |elem|
      if yield (elem)
        return elem
      end
    end
    
    return nil
  end

  def sort (&condition)
    condition = condition ||->(arr){arr}
    new_arr = BinTree.new(self.to_a, condition).to_a
  end

  def min_by (elements_count=1, &condition)
    if elements_count.nil? or elements_count.class!=Integer
      raise ArgumentError, "elements_count must be integer! given #{nil ? i.nil? : i.class}"
    end
    if elements_count > self.size or elements_count < 0
      raise IndexError, "elements_count is out of range!"
    end
    elements_count == 1 ? self.sort(&condition)[0] : self.sort(&condition)[0..elements_count-1]
  end

  
  def <=> (other, &condition)
    if other.nil? or other.class != ArrayProcessor
      raise ArgumentException, "Could not compare ArrayProcessor with #{nil ? other.nil? : other.class}"
    end
    condition = condition ||->(arr){ arr.size}
    condition.call(self) <=> condition.call(other) 
  end

  def inject (start_memo=0)
    self.each do |elem|      
      start_memo= yield(start_memo, elem)      
    end
    start_memo
  end

  def one?
    count = 0
    self.each do |el|
      if yield(el)
        count+=1
      end
      if count > 1
        return false
      end
    end
    return count == 1

  end

  def all?
    flg = true
    i = 0
    while i < self.size && flg!=false
      flg = flg && yield(self.get_by_id(i))
      i+=1
    end
    flg
  end


  def flat_map
    result = []
    self.each do |el|
      temp = yield(el)
      temp.each {|item| result.append(item)}      
    end
    result
  end

end
