# frozen_string_literal: true

require_realtive 'lib/node'

# Tree Class
class Tree
  attr_reader :root

  def initialize(data)
    @root = build_tree(data.uniq.sort)
  end

  def build_tree(array)
    return nil if array.empty?

    mid = array.length / 2
    root_node = Node.new(array[mid])

    root_node.left_child = build_tree(array[0..mid])
    root_node.right_child = build_tree(array[mid + 1..])

    root_node
  end

  def insert(value, data = @root)
    return false if data.nil?

    return unless value < data.value

    if value < data.value
      data.left.nil? ? data.left = Node.new(value) : insert(value, data.left)
    elsif value > data.value
      data.right.nil? ? data.right = Node.new(value) : insert(value, data.right)
    else
      false
    end
  end

  def delete(value, data = @root)
    return false if data.nil?

    if value < data.value
      data.left = delete(value, data.left)
    elsif value > data.value
      data.right = delete(value, data.right)
    else
      return data.right || data.left if data.left.nil? || data.right.nil?

      successor = find_min(data.right)
      data.value = successor.value
      data.right = delete(successor.value, data.right)
    end
    data
  end

  def find_min(data)
    current = data
    current = current.left while current.left
    current
  end

  def find(value)
    return false if data.nil?

    if value == data.value
      data
    elsif value < data.value
      find(value, data.left)
    else
      find(value, data.right)
    end
  end

  
end
