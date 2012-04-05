require './Grid.rb'
require './Rover.rb'

class MarsMission

	attr_reader :grid, :rovers

	def initialize(directive)
		mission_instructions = parse_mission_directive(directive)
		@grid = Grid.new(mission_instructions[:grid_coordinates])
		@rovers = mission_instructions[:rovers].inject([]) do |rovers, rover_design| 
			rover = Rover.new(rover_design, @grid)
			rover.run_mission
			rovers << rover.position 
		end
		@rovers.each do |rover|
			puts rover
		end
	end

	def parse_mission_directive(directive)
		mission_instructions = {}
		instructions = []
		
		File.open(directive, 'r') do |directive|
			count = 0
			while instruction = directive.gets
				instructions << instruction
				count += 1
			end

			raise "Faulty Input" if count % 2 == 0
		end

		grid_coordinates = instructions.shift.split(" ")
		mission_instructions[:grid_coordinates] = {:x => grid_coordinates[0].to_i, :y => grid_coordinates[1].to_i}

		mission_instructions[:rovers] = []
		while rover_starting_position = instructions.shift
			position_coordinates 				= rover_starting_position.split(" ")
			mission_instructions[:rovers] << {:starting_position => {:x => position_coordinates[0].to_i, 
																															 :y => position_coordinates[1].to_i, 
																															 :orientation => position_coordinates[2]}}
			rover_path_instructions 											    = instructions.shift
			rover_directions 																  = rover_path_instructions.chomp.split("")
			mission_instructions[:rovers].last[:instructions] = rover_directions
		end
		mission_instructions
	end
end

MarsMission.new('input.txt')

