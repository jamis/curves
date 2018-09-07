require 'curves/bezier'

module Curves
  class BezierChain
    attr_reader :max_t

    def initialize(points, c=0)
      @segments = []
      i = 1
      while i+2 < points.length
        p0 = points[i]
        p3 = points[i+1]

        p1 = p0 + (points[i+1] - points[i-1]) * 0.5 * (1 - c)
        p2 = p3 - (points[i+2] - points[i]) * 0.5 * (1 - c)

        @segments << Curves::Bezier.new([p0, p1, p2, p3])

        i += 1
      end

      @max_t = @segments.length
    end

    def evaluate(at)
      segment, t = localize(at)
      segment.evaluate(t)
    end

    def tangent(at)
      segment, t = localize(at)
      segment.tangent(t)
    end

    def localize(at)
      segment = at.to_i
      segment = @segments.length - 1 if segment >= @segments.length
      t = at - segment
      [@segments[segment], t]
    end
  end
end
