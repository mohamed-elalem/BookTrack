class GraphFactory

  class << self
    def make_prioritizer(prioritizer)
      instance = nil
      case prioritizer
      when :dag_dfs
        instance = DagDepthTopoSort.new
      when :kahn
        instance = KahnTopoSort.new
      end
      instance
    end

    # Not used for now
    # Can be used when another cycle detector is implemented
    def make_cycle_detector(cycle_detector)
      instance = nil
      # # For now Kosoraju class needs a graph in the constructor
      # case cycle_detector
      # when :kosoraju
      #   instance = Kosoraju.new 
      # end
      instance
    end
  end
end