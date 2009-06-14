module Curves
  class LineSegment
    attr_reader :p1, :p2

    def initialize(p1, p2)
      @p1, @p2 = p1, p2
    end

    def intersection(line)
      x1, y1 = p1.x, p1.y
      x2, y2 = p2.x, p2.y
      x3, y3 = line.p1.x, line.p1.y
      x4, y4 = line.p2.x, line.p2.y

      denom = (y4 - y3) * (x2 - x1) - (x4 - x3) * (y2 - y1)
      return nil if denom == 0.0

      ua = ((x4 - x3) * (y1 - y3) - (y4 - y3) * (x1 - x3)) / denom
      return nil if ua <= 0.0 || ua >= 1.0

      ub = ((x2 - x1) * (y1 - y3) - (y2 - y1) * (x1 - x3)) / denom
      return nil if ub <= 0.0 || ub >= 1.0

      intersection = p1 + (p2 - p1) * ua
      return intersection
    end
  end
end
