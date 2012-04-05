require './Grid.rb'

describe Grid do
	it "exists" do
		Grid
	end

	it "should initialize with the max_x, max_y" do
		grid = Grid.new({:x => 4, :y => 5})
		grid.coordinates[:max_x].should == 4
		grid.coordinates[:max_y].should == 5
	end

	describe "#no_obstacles?" do
		it "should return false if the rover would collide with another one" do
			grid = Grid.new({:x => 4, :y => 5})
			rover = double('rover')
			rover.stub!(:x_coord).and_return(1)
			rover.stub!(:y_coord).and_return(2)
			grid.add_obstacle(rover)
			grid.no_obstacles?([1,2]).should == false
		end
	end
end