# frozen_string_literal: true

require_relative 'lib/node'
require_relative 'lib/tree'
# Create a binary search tree from an array of random numbers
tree = Tree.new(Array.new(15) { rand(1..100) })
puts 'Tree created.'

# Confirm the tree is balanced
puts "Is the tree balanced? #{tree.balance?}"

# Print all elements in level-order, pre-order, post-order, and in-order
puts "Level-order traversal: #{tree.level_order}"
puts "Pre-order traversal: #{tree.in_order(tree.root)}"
puts "Post-order traversal: #{tree.post_order(tree.root) if defined?(tree.post_order)}" # Optional if post_order exists
puts "In-order traversal: #{tree.in_order(tree.root)}"
