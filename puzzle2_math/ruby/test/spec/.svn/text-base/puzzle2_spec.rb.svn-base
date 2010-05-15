# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'puzzle2'

describe Puzzle2 do
  before(:each) do
    @puzzle = Puzzle2.new
  end

  describe "evaluate" do
    it "should return result of 1+2 from a simple prefix array" do
      @puzzle.evaluate([:+, 1, 2]).should == 3
    end

    it "should return result of (5-6)*7 from a prefix array when left operand is a symbol" do
      @puzzle.evaluate([:*, :-, 5, 6, 7]).should == -7
    end

    it "should return result of 10/(10/2) from a prefix array when right operand is a symbol" do
      @puzzle.evaluate([:/, 10, :/, 10, 2]).should == 2
    end

    it "should return result of ((2+2)+2)-(2/2)" do
      @puzzle.evaluate([:-, :+, :+, 2, 2, 2, :/, 2, 2]).should == 5
    end

   it "should return result of (4+(4/4))+(4-4)" do
      @puzzle.evaluate([:+, :+, 4, :/, 4, 4, :-, 4, 4]).should == 5
    end
  end

  describe "pretty print" do
    it "should return correct result when array is simple" do
      @puzzle.pretty_print([:+, 1, 2]).should == "(1 + 2)"
    end

    it "should return correct result when left operand is a symbol" do
      @puzzle.pretty_print([:*, :-, 5, 6, 7]).should == "((5 - 6) * 7)"
    end

    it "should return correct result when irght operand is a symbol" do
      @puzzle.pretty_print([:/, 10, :/, 10, 2]).should == "(10 / (10 / 2))"
    end

    it "should return correct result for a compliated prefix expression" do
      @puzzle.pretty_print([:-, :+, :+, 2, 2, 2, :/, 2, 2]).should == "(((2 + 2) + 2) - (2 / 2))"
    end

    it "should reutrun correct result for another prefix expression" do
      #@puzzle.pretty_print([:+, :-, 3, :/, 3, 3, 3, :*, 3]).should == " 3 - (3/3) + 3"
    end
  end

  describe "valid prefix array" do
    it "should return true if an input array is a valid prefix expression" do
      @puzzle.valid_prefix?([:-, :+, :+, 2, 2, 2, :/, 2, 2]).should == true
    end

    it "should return true if an input array is a valid prefix expression 2" do
      @puzzle.valid_prefix?([:+, :+, 4, :/, 4, 4, :-, 4, 4]).should == true
    end

    it "should return false if input array is not a valid prefix expression" do
      @puzzle.valid_prefix?([:-, :+, :+, 2, 2, 2, :/, :+, 2]).should == false
    end

    it "should return false if input array is not a valid prefix expression 2 " do
      @puzzle.valid_prefix?([:+, :-, 3, :/, 3, 3, 3, :*, 3]).should == false
    end
    
  end

end

