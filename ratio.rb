class Ratio
  attr_reader :numer, :denom
  def initialize(numer, denom)
    unless numer.is_a?(Integer) && denom.is_a?(Integer)
      raise TypeError, "numerator and denominator must be integers!"
    end

    raise ZeroDivisionError if denom.zero?

    gcd = numer.gcd(denom)

    @numer = numer / gcd
    @denom = denom / gcd

    # Make sure the negative sign, if there is one, is always on the numerator
    if denom < 0
      @numer *= -1
      @denom *= -1
    end
  end

  def numerator   ; numer ; end
  def denominator ; denom ; end

  def ==(other)
    case other
    when self.class
      self.numer == other.numer && self.denom == other.denom
    when Integer
      self.numer == other && self.denom == 1
    else
      raise TypeError, "IDK, how *do* you compare a Ratio with a #{other.class}?"
    end
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
      raised_to_integer(power)
    when Float
      raised_to_float(power)
    else
      raise TypeError, "IDK, how *do* you raise a Ratio to a #{power.class}?"
    end
  end

  def coerce(other)
    case other
    when Float
      coerced = numer.to_f / denom.to_f
      return other, coerced
    else
      raise TypeError, "IDK, how *do* you coerce a Ratio to a #{other.class}?"
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

  private

  def raised_to_integer(power)
    return self.class.new(1, 1) if power.zero? # by definition
    if power > 0
      a, b = numer, denom
    else
      a, b = denom, numer
    end
    a, b = a ** power.abs, b ** power.abs # "power abs" sounds like an absurd fitness product
    self.class.new(a, b)
  end

  def raised_to_float(power)
    a = numer ** power
    b = denom ** power
    a / b
  end
end

def Ratio(x, y)
  Ratio.new(x, y)
end
