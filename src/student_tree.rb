class StudentTree

  include Enumerable
  
  attr_reader :size
  
  def initialize(array=[])
    @root = nil
    @size = 0
    array.each { |element| append(element) } unless array.empty?
  end
  
  def append(value)
    new_node = Node.new(value)
    
    if @root.nil?
      @root = new_node
    else
      add_node(@root, new_node)
    end    
    @size += 1
  end
  
  def each(node=@root, &block)
    return if node.nil?
    
    each(node.left, &block)
    yield(node.value)
    each(node.right, &block)
  end

  def to_a
    result = []
    self.each(@root){|item| result.append(item)}
    result
  end

  def find    
    self.each do |item|
      if yield(item)
        return item
      end
    end
  end
  
  def select
    result = StudentTree.new()
    self.each do |item|
      if yield(item)
        result.append(item)
       end
    end
    return result
  end
  
  def count
    result = 0
    self.each do |item|
      if yield(item)
        result+=1
       end
    end
    return result
  end

  def remove
    array = self.to_a
    @root=nil
    @size= 0
    array.each do |item|
      if !yield(item)
        self.append(item)
      end
    end
  end


  def map
    result = StudentTree.new()
    self.each do |item|
        result.append(yield(item))
    end
    return result
  end

  def to_s
    result = ""
    self.each do |item|
        result+=item.to_s + "\n"
    end
    return result
  end


  private
  
  def add_node(current, new_node)   
    comparison = current.value <=> new_node.value 
    if comparison < 0
      if current.left.nil?
        current.left = new_node
      else
        add_node(current.left, new_node)
      end
    else
      if current.right.nil?
        current.right = new_node
      else
        add_node(current.right, new_node)
      end
    end
  end
 
  class Node
    attr_accessor :value, :left, :right
    
    def initialize(value)
      @value = value
      @left = nil
      @right = nil
    end
  end
  
end

