require 'rspec'

require_relative 'ratio'

RSpec.describe Ratio do

  specify "Ratios can be constructed with a #Ratio function" do
    ratio = Ratio(1, 3)
    expect( ratio ).to be_kind_of( Ratio )

    expect( ratio.numerator   ).to eq( 1 )
    expect( ratio.denominator ).to eq( 3 )
  end

  describe "string representation" do
    specify "simple case" do
      expect( Ratio(1, 3).to_s ).to eq( "1/3" )
    end
  end

  specify "can't divide by zero" do
    expect { Ratio(1, 0) }.to raise_error( ZeroDivisionError )
  end

  specify "equality compares numerator and denominator" do
    a = Ratio(1, 3)
    b = Ratio(1, 3)
    expect( a ).to eq( b )
    expect( b ).to eq( a )

    c = Ratio(2, 3)
    expect( a ).to_not eq( c )
    expect( b ).to_not eq( c )
    expect( c ).to_not eq( a )
    expect( c ).to_not eq( b )
  end

  specify "equality works no matter where the minus sign started out" do
    a = Ratio(-1,  3)
    b = Ratio( 1, -3)
    expect( a ).to eq( b )
    expect( b ).to eq( a )
  end

  specify "equality with integers" do
    a = Ratio( 1, 1 )
    b = Ratio( 2, 1 )
    expect( a ).to     eq( 1 )
    expect( b ).to     eq( 2 )
    expect( b ).to_not eq( 3 )
    expect( 1 ).to     eq( a )
    expect( 2 ).to     eq( b )
    expect( 3 ).to_not eq( b )
  end

  specify "#abs (absolute value)" do
    expect( Ratio( 1,  3).abs ).to eq( Ratio(1, 3) )
    expect( Ratio(-1,  3).abs ).to eq( Ratio(1, 3) )
    expect( Ratio( 1, -3).abs ).to eq( Ratio(1, 3) )
    expect( Ratio(-1, -3).abs ).to eq( Ratio(1, 3) )
  end

  specify "reduction" do
    a = Ratio(2, 4)
    expect( a.numerator   ).to eq( 1 )
    expect( a.denominator ).to eq( 2 )
    expect( a.to_s        ).to eq( "1/2" )

    a = Ratio(4, 2)
    expect( a.numerator   ).to eq( 2 )
    expect( a.denominator ).to eq( 1 )
    expect( a.to_s        ).to eq( "2/1" )
  end

  specify "addition" do
    expect( Ratio(1, 3) + Ratio(1, 3) ).to eq( Ratio(2, 3) )
    expect( Ratio(1, 3) + Ratio(2, 3) ).to eq( Ratio(1, 1) )
    expect( Ratio(1, 4) + Ratio(1, 2) ).to eq( Ratio(3, 4) )
  end

  specify "subtraction" do
    expect( Ratio(1, 3) - Ratio(1, 3) ).to eq( Ratio(0, 3) )
    expect( Ratio(1, 3) - Ratio(1, 6) ).to eq( Ratio(1, 6) )
    expect( Ratio(1, 2) - Ratio(1, 4) ).to eq( Ratio(1, 4) )
    expect( Ratio(1, 4) - Ratio(1, 2) ).to eq( Ratio(-1, 4) )
  end

  specify "multiplication" do
    expect( Ratio(1, 2) * Ratio( 1,  2) ).to eq( Ratio( 1,  4) )
    expect( Ratio(1, 3) * Ratio( 1,  6) ).to eq( Ratio( 1, 18) )
    expect( Ratio(1, 2) * Ratio(-1,  2) ).to eq( Ratio(-1,  4) )
    expect( Ratio(1, 2) * Ratio( 1, -2) ).to eq( Ratio(-1,  4) )
  end

  specify "division" do
    expect( Ratio(1, 2) / Ratio( 1, 2) ).to eq( Ratio(1, 1) )
    expect( Ratio(1, 3) / Ratio( 1, 6) ).to eq( Ratio(2, 1) )
  end

  specify "exponentiation to non-negative integer power" do
    expect( Ratio(2, 3) ** 2 ).to eq( Ratio(4, 9) )
    expect( Ratio(3, 5) ** 2 ).to eq( Ratio(9, 25) )

    # for fun, let's just cross-check multiplication while we're here
    expect( Ratio(2, 3) ** 2 ).to eq( Ratio(2, 3) * Ratio(2, 3) )
    expect( Ratio(3, 5) ** 2 ).to eq( Ratio(3, 5) * Ratio(3, 5) )
  end

  specify "exponentiation to negative integer power" do
    expect( Ratio(1, 3) ** -2 ).to eq( Ratio(9, 1) )
    expect( Ratio(2, 3) ** -2 ).to eq( Ratio(9, 4) )
    expect( Ratio(3, 5) ** -2 ).to eq( Ratio(25, 9) )
  end

  specify "exponentiation to a float" do
    result = Ratio(2, 3) ** 1.1
    expect( result ).to be_a( Float )
    expect( result ).to eq( (2 ** 1.1) / (3 ** 1.1) )
  end

  specify "raising a float to a Ratio" do
    result = 2.0 ** Ratio(2, 3)
    expect( result ).to be_a( Float )
    expect( result ).to be_within( 0.00001 ).of( 1.587401052 )
  end
end
