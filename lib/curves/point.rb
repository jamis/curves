require 'curves/triplet'
require 'curves/vector'

module Curves
  class Point < Triplet
    def -(point)
      result_class = point.is_a?(Vector) ? Point : Vector
      result_class.new(x - point.x, y - point.y, z - point.z)
    end

    def to_vector
      Vector.new(x, y, z)
    end
  end
end
