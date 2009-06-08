module Curves
  class Triplet
    DELTA = 0.001

    attr_reader :x, :y, :z

    def initialize(x,y,z=0)
      @x, @y, @z = x, y, z
    end

    def to_s
      "(%g,%g,%g)" % [x,y,z]
    end

    def hash
      [self.class.name, (x/DELTA).to_i, (y/DELTA).to_i, (z/DELTA).to_i].hash
    end

    def +(triplet)
      self.class.new(x + triplet.x, y + triplet.y, z + triplet.z)
    end

    def ==(v)
      self.class == v.class &&
        (v.x - x).abs <= DELTA &&
        (v.y - y).abs <= DELTA &&
        (v.z - z).abs <= DELTA
    end
  end
end
