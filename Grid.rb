class Grid
	def initialize(grid_coordinates)
		@max_x = grid_coordinates[:x]
		@max_y = grid_coordinates[:y]
		@min_x = 0
		@min_y = 0
		
		@obstacles = []
	end

	def coordinates
		{:max_x => @max_x, :max_y => @max_y, :min_x => @min_x, :min_y => @min_y}
	end	

	def no_obstacles?(coordinates)
		x_coordinate = coordinates[0]
		y_coordinate = coordinates[1]

	  return false if x_coordinate < @min_x || y_coordinate < @min_x
		return false if x_coordinate > @max_x || y_coordinate > @max_y

		@obstacles.each do |rover|
			return false if rover.x_coord == x_coordinate && rover.y_coord == y_coordinate
    end

    return true
	end

	def add_obstacle(rover)
		@obstacles << rover
	end
end
