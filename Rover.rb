class Rover

	attr_reader :x_coord, :y_coord

	Orientations = ["N", "E", "S", "W"]

	def initialize(directions, grid)
		@x_coord 				   = directions[:starting_position][:x]
		@y_coord 					 = directions[:starting_position][:y]
		@orientation 			 = directions[:starting_position][:orientation]
		@path_instructions = directions[:instructions]
		@grid = grid
		@grid.add_obstacle(self)
  end

	def move
		movement_hash = {"N" => lambda { @y_coord += 1},
										 "S" => lambda { @y_coord -= 1},
						 				 "E" => lambda { @x_coord += 1},
						 				 "W" => lambda { @x_coord -= 1}}

		if @orientation == "N"
			@grid.no_obstacles?([x_coord, y_coord + 1]) ? movement_hash[@orientation].call : raise("Mission Abort!")
		elsif @orientation == "S"
		  @grid.no_obstacles?([x_coord, y_coord - 1]) ? movement_hash[@orientation].call : raise("Mission Abort!")
		elsif @orientation == "E"
			@grid.no_obstacles?([x_coord + 1, y_coord]) ? movement_hash[@orientation].call : raise("Mission Abort!")
		else
			@grid.no_obstacles?([x_coord - 1, y_coord]) ? movement_hash[@orientation].call : raise("Mission Abort!")
		end
	end

	def turn(direction)
		orientation_index = Orientations.index(@orientation)
		if direction == "L"  
			if orientation_index > 0
				@orientation = Orientations[orientation_index - 1] 
			else
				@orientation = Orientations[3]
			end

		else
			if orientation_index < Orientations.length - 1 
				@orientation = Orientations[orientation_index + 1]
			else
				@orientation = Orientations[0]
			end
		end
	end

	def position
		"#{x_coord} #{y_coord} #{@orientation}"
	end

	def run_mission
		@path_instructions.each do |command|
			command == "M" ? move() : turn(command)
		end
	end
end