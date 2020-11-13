require_relative "./00_tree_node.rb"

class KnightPathFinder

    def self.valid_move(pos)
        valid_moves = []
        if pos[0] - 2 >= 0 && pos[0] - 2 < 8 && pos[1] + 1 >= 0 && pos[1] + 1 < 8
            valid_moves <<  [pos[0] - 2, pos[1] + 1]
        end
        if pos[0] - 2 >= 0 && pos[0] - 2 < 8 && pos[1] - 1 >= 0 && pos[1] - 1 < 8
            valid_moves <<  [pos[0] - 2, pos[1] - 1]
        end
        if pos[0] + 2 >= 0 && pos[0] + 2 < 8 && pos[1] + 1 >= 0 && pos[1] + 1 < 8
            valid_moves <<  [pos[0] + 2, pos[1] + 1]
        end
        if pos[0] + 2 >= 0 && pos[0] + 2 < 8 && pos[1] - 1 >= 0 && pos[1] - 1 < 8
            valid_moves <<  [pos[0] + 2, pos[1] - 1]
        end
        if pos[0] - 1 >= 0 && pos[0] - 1 < 8 && pos[1] + 2 >= 0 && pos[1] + 2 < 8
            valid_moves <<  [pos[0] - 1, pos[1] + 2]
        end
        if pos[0] - 1 >= 0 && pos[0] - 1 < 8 && pos[1] - 2 >= 0 && pos[1] - 2 < 8
            valid_moves <<  [pos[0] - 1, pos[1] - 2]
        end
        if pos[0] + 1 >= 0 && pos[0] + 1 < 8 && pos[1] + 2 >= 0 && pos[1] + 2 < 8
            valid_moves <<  [pos[0] + 1, pos[1] + 2]
        end
        if pos[0] + 1 >= 0 && pos[0] + 1 < 8 && pos[1] - 2 >= 0 && pos[1] - 2 < 8
            valid_moves <<  [pos[0] + 1, pos[1] - 2]
        end
        valid_moves
    end

    def initialize(position)
        @root_node = PolyTreeNode.new(position)
        @considered_positions = [position]
        build_move_tree
    end

    def build_move_tree
        #queue of nodes
        queue = []
        #initialize queue to start with root node
        queue << @root_node

        until queue.empty?
            #first node in queue
            first_node = queue.shift
            #find all new positions from current front of queue's position
            new_position = new_move_positions(first_node.value)
            #turns all new positions into nodes
            new_pos_nodes = new_position.map{|pos| PolyTreeNode.new(pos)}
            #add all new nodes(new positions) to child of the current node we are dealing with (front of queue)
            new_pos_nodes.each{|node| first_node.add_child(node)}
            #add all new positions into queue so we can find new positions from each of these
            queue += new_pos_nodes
        end
        nil
    end

    def new_move_positions(position)
        new_pos = KnightPathFinder.valid_move(position).select{|pos| !@considered_positions.include?(pos)}
        @considered_positions += new_pos
        new_pos
    end

    


end