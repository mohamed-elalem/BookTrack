class UnionFind
  def initialize
    @p = {}
    @rank = {}
  end

  def union(i, j)
    unless is_same_set(i, j)
      x = find(i)
      y = find(j)
      if @rank[x] < @rank[y]
        @p[x] = y
      else
        @p[y] = x
        @rank[x] += 1 if @rank[x] == @rank[y]
      end
    end
  end

  def is_same_set(i, j)
    find(i) == find(j)
  end

  private

  def initialize_entry(index)
    @p[index] = index
    @rank[index] = 1
  end

  def find(index)
    initialize_entry(index) unless @p.has_key? index
    until @p[index] == index
      @p[index] = @p[@p[index]]
      index = @p[index]
    end
    index
  end
end