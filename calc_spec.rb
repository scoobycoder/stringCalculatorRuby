require 'rspec'
require './string_calculator'

describe 'Be a Calculator' do

  before do
    @calc = StringCalc.new
  end

  it 'Sum should eat any character that is not a numbers' do
    expect(@calc.sum('//[,]a,1')).to eq(1)
  end

  it 'Sum should return 0 when nothing is passed to it' do
    expect(@calc.sum).to eq(0)
  end

  it 'Sum should add two numbers' do
    expect(@calc.sum('//[,]1,1')).to eq(2)
  end

  it 'Sum should allow for any delimiter that is passed at beginning of string' do
    expect(@calc.sum('//[;]\n1;2')).to eq(3)
  end

  it 'Sum should throw and exception when negative numbers are passed' do
    expect { @calc.sum('//[;]2;-1;-5') }.to raise_error
  end

  it 'Sum should ignore numbers larger than 1000 when they are passed' do
    expect(@calc.sum('//[;]1000;2;1001')).to eq(1002)
  end

  it 'Sum should allow for long delimiters' do
    expect(@calc.sum('//[***]\n1***2***3')).to eq(6)
  end

  it 'Sum should allow for multiple delimiters' do
    expect(@calc.sum('//[*][%]\n1*2%3')).to eq(6)
  end

  it 'Sum should allow for long multiple delimiters' do
    expect(@calc.sum('//[***][%%]\n1***2%%3')).to eq(6)
  end

end