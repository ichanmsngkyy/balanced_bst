# frozen_string_literal: true

require_relative 'node'

# Tree Class
class Tree
  attr_reader :root

  def initialize(node)
    @root = build_tree(node.uniq.sort)
  end

  def build_tree(array)
    return nil if array.empty?

    mid = array.length / 2
    Node.new(array[mid], build_tree(array[0...mid]), build_tree(array[mid + 1...]))
  end

  def insert(value, node = @root)
    return if node.nil?

    return unless value < node.data

    if value < node.data
      node.left.nil? ? node.left = Node.new(value) : insert(value, node.left)
    elsif value > node.data
      node.right.nil? ? node.right = Node.new(value) : insert(value, node.right)
    else
      false
    end
  end

  def delete(value, node = @root)
    return if node.nil?

    if value < node.value
      node.left = delete(value, node.left)
    elsif value > node.value
      node.right = delete(value, node.right)
    else
      return node.right || node.left if node.left.nil? || node.right.nil?

      successor = find_min(node.right)
      node.value = successor.value
      node.right = delete(successor.value, node.right)
    end
    node
  end

  def find_min(node)
    current = node
    current = current.left while current.left
    current
  end

  def find(value)
    return false if node.nil?

    if value == node.value
      node
    elsif value < node.value
      find(value, node.left)
    else
      find(value, node.right)
    end
  end

  def level_order
    return false if @root.nil?

    result = []
    queue = Queue.new
    queue << @root

    until queue.empty?
      node = queue.pop
      result << node.data
      queue << node.left if node.left
      queue << node.right if node.right
    end
    result
  end

  def in_order(node, values = [], &block)
    return values if node.nil?

    in_order(node.left, values, &block)
    block_given? ? yield(node) : values << node.data
    in_order(node.right, values, &block)

    values
  end

  def pre_order(node, values = [], &block)
    return values if node.nil?

    block_given? ? yield(node) : values << node.data
    pre_order(node.left, values, &block)
    pre_order(node.right, values, &block)

    values
  end

  def post_order(node, values = [], &block)
    return values if node.nil?

    post_order(node.left, values, &block)
    post_order(node.right, values, &block)
    block_given? ? yield(node) : values << node.data
    values
  end

  def height(value, node = @root)
    target_node = find(value, node)
    return if target_node.nil?

    calculate_height(target_node)
  end

  def calculate_height(node)
    return -1 if node.nil?

    left_height = calculate_height(node.left)
    right_height = calculate_height(node.right)

    [left_height, right_height].max + 1
  end

  def depth(value, node = @root, current_depth = 0)
    return if node.nil?

    if value == node.value
      current_depth
    elsif value < node.value
      depth(value, node.left, current_depth + 1)
    else
      depth(value, node.right, current_depth + 1)
    end
  end

  def balance?(node = @root)
    return true if node.nil?

    left_height = calculate_height(node.left)
    right_height = calculate_height(node.right)

    (left_height - right_height).abs <= 1 && balance?(node.left) && balance?(node.right)
  end

  def rebalance
    value = in_order(@root).map(&:value)
    @root = build_tree(values)
  end
end
