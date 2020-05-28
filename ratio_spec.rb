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

end
