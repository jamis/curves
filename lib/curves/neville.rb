# An implementation of Neville's scheme, a technique for finding a point
# at t on a degree-n polynomial curve which interpolates a given set of
# points.

require 'curves/point'

module Curves
  class Neville
    # `definition` must be a hash, mapping `t` values to points. The resulting
    # curve will interpolate each point at its corresponding t value.
    def initialize(definition)
      if definition.size == 0
        raise ArgumentError, "an empty set cannot be interpolated"
      end

      list = definition.to_a.
                  sort_by { |(t, point)| t }.
                  map { |(t, point)| [t, _normalize(point) ] }

      @ts = list.map { |(t, point)| t }
      @points = list.map { |(t, point)| point }
    end

    def evaluate(t)
      set = @points
      depth = 1

      while set.length > 1
        new_set = []

        (set.length - 1).times do |i|
          new_set << (set[i] * (@ts[i+depth] - t) - set[i+1] * (@ts[i] - t)) / (@ts[i+depth] - @ts[i])
        end

        depth += 1
        set = new_set
      end

      set[0]
    end
    alias [] evaluate

    private

      def _normalize(point)
        if point.is_a?(Curves::Triplet)
          point
        elsif point.is_a?(Array)
          Curves::Point.new(point[0], point[1], point[2])
        else
          raise ArgumentError, "cannot convert #{point.inspect} to a point"
        end
      end
  end
end
