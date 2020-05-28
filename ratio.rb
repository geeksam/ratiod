class Ratio
  attr_reader :numerator, :denominator
  def initialize(numerator, denominator)
    raise ZeroDivisionError if denominator.zero?

    @numerator   = numerator
    @denominator = denominator
  end

  def to_s
    "%d/%d" % [ numerator, denominator ]
  end
end

def Ratio(x, y)
  Ratio.new(x, y)
end
