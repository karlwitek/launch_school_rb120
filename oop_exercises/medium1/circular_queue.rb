class CircularQueue
  attr_accessor :max_size, :buffer

  def initialize(max_size)
    @max_size = max_size
    @buffer = Array.new
  end

  def enqueue(int)
    if buffer.size < max_size
      buffer << int
    else
      item_to_remove = buffer.min
      index = buffer.index(item_to_remove)
      buffer[index] = int
    end
  end

  def dequeue
    return nil if buffer.empty?
    item_to_remove = buffer.min
    index = buffer.index(item_to_remove)
    buffer.delete_at(index)
    item_to_remove
  end
end

# q = CircularQueue.new(3)
# q.enqueue(1)
# q.enqueue(2)
# q.enqueue(3)
# q.enqueue(4)
# q.dequeue
# puts q.dequeue == 3
# puts q.buffer

queue = CircularQueue.new(3)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil

queue = CircularQueue.new(4)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 4
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil
