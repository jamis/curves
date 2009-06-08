require 'curves/triplet'

module Curves
  class Vector < Triplet
    def *(n)
      Vector.new(x * n, y * n, z * n)
    end

    def /(n)
      Vector.new(x / n, y / n, z / n)
    end

    def magnitude
      @magnitude ||= x * x + y * y + z * z
    end

    def length
      @length ||= ::Math.sqrt(magnitude)
    end

    def normalize
      Vector.new(x/length, y/length, z/length)
    end

    def dot(vector)
      x * vector.x + y * vector.y + z * vector.z
    end

    def cross(vector)
      Vector.new(
        y * vector.z - z * vector.y,
        z * vector.x - x * vector.z,
        x * vector.y - y * vector.x)
    end

    def inverse
      Vector.new(-x, -y, -z)
    end

    def between(vector)
      (self + vector) / 2
    end

    # rotates the vector counter-clockwise 90 degrees around the
    # z axis.
    def rotate_ccw
      Vector.new(-y, x, z)
    end

    # rotates the vector clockwise 90 degrees around the z axis.
    def rotate_cw
      Vector.new(y, -x, z)
    end

    # The angle between this vector and the argument, around the z-axis.
    # Returns 0 if vectors point the same direction relative to the z-axis,
    # and increases as the argument moves counter-clockwise around the
    # z-axis relative to +self+, up to 2*PI.
    def angle(vector)
      # length of the z-component of the cross-product
      cross_z = x * vector.y - y * vector.x

      # dot product, ignoring the z component
      dot_xy = x * vector.x + y * vector.y

      angle = ::Math.atan2(cross_z, dot_xy)
      angle += 2 * ::Math::PI if angle < 0

      return angle
    end

    def to_point
      Point.new(x, y, z)
    end
  end
end
