module Enumerable
  # Your code goes here
  def my_all?
    my_each do |x|
      valid = yield x
      return false unless valid
    end
    true
  end

  def my_map
    new_arr = []
    my_each do |x|
      transformed = yield x
      new_arr << transformed
    end
    new_arr
  end

  def my_any?
    my_each do |x|
      return true if yield x
    end
    false
  end

  def my_none?
    my_each do |x|
      return false if yield x
    end
    true
  end

  def my_count
    return size unless block_given?

    counter = 0
    my_each do |x|
      counter += 1 if yield x
    end
    counter
  end

  def my_select
    new_arr = []
    my_each do |x|
      valid = yield x
      new_arr << x if valid
    end
    new_arr
  end

  def my_inject(initial_value)
    accumulator = initial_value
    my_each do |x|
      accumulator = yield(accumulator, x)
    end
    accumulator
  end

  def my_each_with_index
    index = 0
    my_each do |x|
      yield(x, index)
      index += 1
    end
    self
  end
end

# Custom #my_each method
class Array
  def my_each
    return to_enum unless block_given?

    length.times { |x| yield self[x] }
    self
  end
end

# Custom my_each method
class Hash
  def my_each_pair
    return to_enum unless block_given?

    keys.my_each { |k| yield(k, self[k]) }
  end
end
