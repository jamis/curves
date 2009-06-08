module Curves
  module Math
    def self.factorial(n)
      n <= 1 ? 1 : (n * factorial(n-1))
    end

    def self.choose(n, i)
      factorial(n) / (factorial(i) * factorial(n - i))
    end
  end
end
