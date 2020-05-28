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
    a = self.numer * other.denom + other.numer * self.denom
    b = self.denom * other.denom
    self.class.new(a, b)
  end

  def -(other)
    a = self.numer * other.denom - other.numer * self.denom
    b = self.denom * other.denom
    self.class.new(a, b)
  end

  def *(other)
    a = self.numer * other.numer
    b = self.denom * other.denom
    self.class.new(a, b)
  end

  def /(other)
    a = self.numer * other.denom
    b = other.numer * self.denom
    self.class.new(a, b)
  end

  def **(power)
    case power
    when Integer
      if power > 0
        a = numer ** power
        b = denom ** power
      elsif power == 0
        a, b = 1, 1 # by definition
      else
        a = denom ** power.abs
        b = numer ** power.abs
      end
      return self.class.new(a, b)
    when Float
      a = numer ** power
      b = denom ** power
      return a / b
    end
  end

  def coerce(other)
    case other
    when Float
      self_as_float = numer.to_f / denom
      return other, self_as_float
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
