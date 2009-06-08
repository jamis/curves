require 'curves/point'

module Curves
  class Hermite
    attr_reader :controls

    def initialize(controls)
      raise ArgumentError, "only cubic hermite splines are supported" unless controls.length == 4
      @controls = controls.dup.freeze
    end

    def evaluate(at)
      at2 = at * at
      at3 = at2 * at

      h = [2 * at3 - 3 * at2 + 1, at3 - 2 * at2 + at, -2 * at3 + 3 * at2, at3 - at2]

      x = y = z = 0
      controls.each_with_index do |pt, i|
        x += pt.x * h[i]
        y += pt.y * h[i]
        z += pt.z * h[i]
      end

      return Point.new(x, y, z)
    end

    def tangent(at)
      at2 = at * at

      h = [6 * at2 - 6 * at, 3 * at2 - 4 * at + 1, -6 * at2 + 6 * at, 3 * at2 - 2 * at]

      x = y = z = 0
      controls.each_with_index do |pt, i|
        x += pt.x * h[i]
        y += pt.y * h[i]
        z += pt.z * h[i]
      end

      return Vector.new(x, y, z)
    end
  end
end
