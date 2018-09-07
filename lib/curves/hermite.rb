require 'curves/point'

module Curves
  class Hermite
    def initialize(controls)
      raise ArgumentError, "only cubic hermite splines are supported" unless controls.length == 4
      @p0, @m0, @p1, @m1 = controls
    end

    def evaluate(at)
      at2 = at * at
      at3 = at2 * at

      h = [ 2*at3 - 3*at2 + 1,
              at3 - 2*at2 + at,
           -2*at3 + 3*at2,
              at3 -   at2]

      x = @p0.x * h[0] + @m0.x * h[1] + @p1.x * h[2] + @m1.x * h[3]
      y = @p0.y * h[0] + @m0.y * h[1] + @p1.y * h[2] + @m1.y * h[3]
      z = @p0.z * h[0] + @m0.z * h[1] + @p1.z * h[2] + @m1.z * h[3]

      return Point.new(x, y, z)
    end

    def tangent(at)
      at2 = at * at

      h = [ 6*at2 - 6*at,
            3*at2 - 4*at + 1,
           -6*at2 + 6*at,
            3*at2 - 2*at ]

      x = @p0.x * h[0] + @m0.x * h[1] + @p1.x * h[2] + @m1.x * h[3]
      y = @p0.y * h[0] + @m0.y * h[1] + @p1.y * h[2] + @m1.y * h[3]
      z = @p0.z * h[0] + @m0.z * h[1] + @p1.z * h[2] + @m1.z * h[3]

      return Vector.new(x, y, z)
    end
  end
end
