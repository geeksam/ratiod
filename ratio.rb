class Ratio
  attr_reader :numerator, :denominator
  def initialize(numerator, denominator)
    raise ZeroDivisionError if denominator.zero?

    gcd = numerator.gcd(denominator)

    @numerator   = numerator   / gcd
    @denominator = denominator / gcd

    if denominator < 0
      @numerator *= -1
      @denominator *= -1
    end
  end

  def ==(other)
    self.numerator == other.numerator && self.denominator == other.denominator
  end

  def +(other)
    a1, b1 = self .numerator, self .denominator
    a2, b2 = other.numerator, other.denominator
    c1 = (a1 * b2) + (a2 * b1)
    c2 = b1 * b2
    self.class.new(c1, c2)
  end

  def -(other)
    a1, b1 = self .numerator, self .denominator
    a2, b2 = other.numerator, other.denominator
    c1 = (a1 * b2) - (a2 * b1)
    c2 = b1 * b2
    self.class.new(c1, c2)
  end

  def *(other)
    a1, b1 = self .numerator, self .denominator
    a2, b2 = other.numerator, other.denominator
    c1 = a1 * a2
    c2 = b1 * b2
    self.class.new(c1, c2)
  end

  def /(other)
    a1, b1 = self .numerator, self .denominator
    a2, b2 = other.numerator, other.denominator
    c1 = a1 * b2
    c2 = a2 * b1
    self.class.new(c1, c2)
  end

  def **(power)
    return self.class.new(1, 1) if power.zero? # by definition

    case power
    when Integer
      if power > 0
        c1 = numerator ** power
        c2 = denominator ** power
      else
        c1 = denominator ** power.abs
        c2 = numerator ** power.abs
      end
      self.class.new(c1, c2)
    when Float
      c1 = numerator ** power
      c2 = denominator ** power
      return c1 / c2
    end
  end

  def to_s
    "%d/%d" % [ numerator, denominator ]
  end

  def inspect
    "#<Ratio(%d, %d)>" % [ numerator, denominator ]
  end

  def abs
    self.class.new( numerator.abs, denominator.abs )
  end
end

def Ratio(x, y)
  Ratio.new(x, y)
end
