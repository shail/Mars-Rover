require './Rover.rb'
require './Grid.rb'

describe Rover do
	it "exists" do
		Rover
	end

	it "should know its x-coord, y-coord, and orientation" do
		rover = Rover.new({:starting_position => {:x => 1, :y => 2, :orientation => "N"}, 
								       :instructions => ["L", "M"]}, Grid.new({:x => 5, :y => 5}))
		rover.position.should == "1 2 N"
	end

	describe "#move" do

		it "should increase the y-coord by 1 if facing North" do
			rover = Rover.new({:starting_position => {:x => 1, :y => 2, :orientation => "N"}, 
												 :instructions => ["L", "M"]}, Grid.new({:x => 5, :y => 5}))
			rover.move()
			rover.position.should == "1 3 N"
		end

		it "should decrease the y-coord by 1 if facing South" do
			rover = Rover.new({:starting_position => {:x => 1, :y => 2, :orientation => "S"}, 
											   :instructions => ["L", "M"]}, Grid.new({:x => 5, :y => 5}))
			rover.move()
			rover.position.should == "1 1 S"
		end

		it "should decrease the x-coord by 1 if facing West" do
			rover = Rover.new({:starting_position => {:x => 1, :y => 2, :orientation => "W"}, 
											   :instructions => ["L", "M"]}, Grid.new({:x => 5, :y => 5}))
			rover.move()
			rover.position.should == "0 2 W"
		end

		it "should increase the x-coord by 1 if facing East" do
			rover = Rover.new({:starting_position => {:x => 1, :y => 2, :orientation => "E"}, 
											   :instructions => ["L", "M"]}, Grid.new({:x => 5, :y => 5}))
			rover.move()
			rover.position.should == "2 2 E"
		end

		it "should raise an error if you try to go past the max-x" do
			rover = Rover.new({:starting_position => {:x => 5, :y => 2, :orientation => "E"}, 
											   :instructions => ["L", "M"]}, Grid.new({:x => 5, :y => 5}))
			lambda { rover.move() }.should raise_error(RuntimeError)
		end

		it "should raise an error if you try to go past the max-y" do
			rover = Rover.new({:starting_position => {:x => 2, :y => 5, :orientation => "N"}, 
											   :instructions => ["L", "M"]}, Grid.new({:x => 5, :y => 5}))
			lambda { rover.move() }.should raise_error(RuntimeError)
		end
	end

	describe "#turn" do
		it "should turn to West if turning left from North position" do
			rover = Rover.new({:starting_position => {:x => 1, :y => 2, :orientation => "N"}, 
											   :instructions => ["L", "M"]}, Grid.new({:x => 5, :y => 5}))
			rover.turn("L")
			rover.position.should == "1 2 W"
		end

		it "should turn to North if turning left from East position" do
			rover = Rover.new({:starting_position => {:x => 1, :y => 2, :orientation => "E"}, 
											   :instructions => ["L", "M"]}, Grid.new({:x => 5, :y => 5}))
			rover.turn("L")
			rover.position.should == "1 2 N"
		end

		it "should turn to North if turning right from West position" do
			rover = Rover.new({:starting_position => {:x => 1, :y => 2, :orientation => "W"}, 
											   :instructions => ["L", "M"]}, Grid.new({:x => 5, :y => 5}))
			rover.turn("R")
			rover.position.should == "1 2 N"
		end

		it "should turn to West if turning right from South position" do
			rover = Rover.new({:starting_position => {:x => 1, :y => 2, :orientation => "S"}, 
											   :instructions => ["L", "M"]}, Grid.new({:x => 5, :y => 5}))
			rover.turn("R")
			rover.position.should == "1 2 W"
		end
	end
end

