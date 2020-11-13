class PolyTreeNode

    attr_reader :parent, :children, :value

    def initialize(val)
        @parent = nil
        @children = []
        @value = val
    end

    def parent=(node)
        oldparent = self.parent
        oldparent.children.delete(self) if oldparent != nil
        @parent = node
        return nil if node == nil
        node.children << self if !node.children.include?(self)
    end

    
    def add_child(child_node)
        child_node.parent = self
    end

    def remove_child(child_node)
        if !self.children.include?(child_node)
            raise "It is not a child"
        end
        child_node.parent = nil
    end

    def dfs(target)
        return self if self.value == target
        children.each do |child|
            found = child.dfs(target)
            return found if found != nil
        end
        nil
    end

    def bfs(target)
        queue = []
        queue << self
        while !queue.empty?
            if queue.first.value == target
                return queue.shift
            else
                queue += queue.shift.children
            end
        end
        nil
    end
    
            

end