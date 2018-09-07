require 'curves/hermite'

module Curves
  class HermiteChain
    attr_reader :max_t

    def initialize(points, c=0.0)
      raise ArgumentError, "must be at least 4 points" if points.length < 4

      @segments = []
      i = 1
      while i+2 < points.length
        p0 = points[i]
        p1 = points[i+1]

        v0 = points[i+1] - points[i-1]
        v1 = points[i+2] - points[i]

        m0 = v0 * (1 - c) / 2.0
        m1 = v1 * (1 - c) / 2.0

        @segments << Curves::Hermite.new([p0, m0, p1, m1])

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
