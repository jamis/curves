require 'curves/point'
require 'curves/math'

module Curves
  class Bezier
    def self.coefficients(degree)
      @coefficients ||= []
      @coefficients[degree] ||= (0..degree).map { |i| Curves::Math.choose(degree, i) }
    end

    attr_reader :controls

    def initialize(controls)
      @controls = controls.dup.freeze
    end

    def degree
      @degree ||= controls.length - 1
    end

    def evaluate(at)
      a = 1 - at
      m = (0..degree).map { |i| self.class.coefficients(degree)[i] * a ** (degree - i) * at ** i }

      x = y = z = 0
      controls.each_with_index do |point, i|
        x += point.x * m[i]
        y += point.y * m[i]
        z += point.z * m[i]
      end

      Point.new(x, y, z)
    end

    def tangent(at)
      hodograph.evaluate(at).to_vector
    end

    def hodograph
      @hodograph ||= begin
        points = []

        degree.times do |i|
          points[i] = ((controls[i+1] - controls[i]) * degree).to_point
        end

        Bezier.new(points)
      end
    end
  end
end
