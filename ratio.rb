class Ratio
  attr_reader :numer, :denom
  def initialize(numer, denom)
    raise ZeroDivisionError if denom.zero?

    gcd = numer.gcd(denom)

    @numer = numer / gcd
    @denom = denom / gcd

    if denom < 0
      @numer *= -1
      @denom *= -1
    end
  end

  def numerator   ; numer ; end
  def denominator ; denom ; end

  def ==(other)
    self.numer == other.numer && self.denom == other.denom
  end

  def +(other)
    c1 = self.numer * other.denom + other.numer * self.denom
    c2 = self.denom * other.denom
    self.class.new(c1, c2)
  end

  def -(other)
    c1 = self.numer * other.denom - other.numer * self.denom
    c2 = self.denom * other.denom
    self.class.new(c1, c2)
  end

  def *(other)
    c1 = self.numer * other.numer
    c2 = self.denom * other.denom
    self.class.new(c1, c2)
  end

  def /(other)
    c1 = self.numer * other.denom
    c2 = other.numer * self.denom
    self.class.new(c1, c2)
  end

  def **(power)
    case power
    when Integer
      if power > 0
        c1 = numer ** power
        c2 = denom ** power
      elsif power == 0
        c1, c2 = 1, 1 # by definition
      else
        c1 = denom ** power.abs
        c2 = numer ** power.abs
      end
      return self.class.new(c1, c2)
    when Float
      c1 = numer ** power
      c2 = denom ** power
      return c1 / c2
    end
  end

  def to_s
    "%d/%d" % [ numer, denom ]
  end

  def inspect
    "#<Ratio(%d, %d)>" % [ numer, denom ]
  end

  def abs
    self.class.new( numer.abs, denom.abs )
  end
end

def Ratio(x, y)
  Ratio.new(x, y)
end
