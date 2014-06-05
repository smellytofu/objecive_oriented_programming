class Rover
	attr_accessor :x, :y, :facing
	attr_reader :xBorder, :yBorder

	def initialize(myXBorder, myYBorder, myX, myY, myFacing)
		@xBorder = myXBorder.to_i
		@yBorder = myYBorder.to_i
		@x = myX.to_i
		@y = myY.to_i
		@facing = myFacing
	end

	def move(cmd)
		if cmd == "M"
			move_helper
		elsif cmd == "L"
			turn_helper("L")
		elsif cmd == "R"
			turn_helper("R")
		end
	end

	def move_helper
		case facing
		when "N"
			@y += 1
		when "E"
			@x += 1
		when "S"
			@y -= 1
		when "W"
			@x -= 1
		end

		if(@x < 0)
			@x = 0
		elsif(@x > xBorder)
			@x = xBorder
		end

		if(@y < 0)
			@y = 0
		elsif(@y > yBorder)
			@y = yBorder
		end
	end

	def turn_helper(turn)
		case turn
		when "R"
			case @facing
			when "N"
				@facing = "E"
			when "E"
				@facing = "S"
			when "S"
				@facing = "W"
			when "W"
				@facing = "N"
			end
		when "L"
			case @facing
			when "N"
				@facing = "W"
			when "W"
				@facing = "S"
			when "S"
				@facing = "E"
			when "E"
				@facing = "N"
			end
		end
	end

end

#making plateau
puts "Input field size (x y):"
border = gets.chomp
border = border.split(" ").collect{|b| b.to_i}

#to store results
roverArray = []

#shitty do-while loop for grabbing rover locations and movement

while (true)
	puts "Input rover location and facing (x y facing):"
	loc = gets.chomp

	if(loc == "\n" || loc == "")
		break
	end

	loc = loc.split(" ")
	loc[0] = loc[0].to_i
	loc[1] = loc[1].to_i

	theRover = Rover.new(border[0], border[1], loc[0], loc[1], loc[2])
	#puts "debug1: border[0] = #{border[0]}, border[1] = #{border[1]}, loc[0] = #{loc[0]}, loc[1] = #{loc[1]}, loc[2] = #{loc[2]}"
	#puts "debug2: borders: #{theRover.xBorder}, #{theRover.yBorder}, rover location: #{theRover.x}, #{theRover.y}, facing: #{theRover.facing}"
	puts "Enter rover movement:"
	movement = gets.chomp
	movement = movement.split("")
	
	#debug
	#movement.each{|b| print b + " "}
	#theRover.move(movement[0])
	# i = 0
	# while(i < movement.length)
	# 	theRover.move(movement[i])
	# 	puts "Debug: current location: #{theRover.x}, #{theRover.y} and facing: #{theRover.facing}"
	# 	i += 1
	# end
	movement.each{|a| theRover.move(a)}

	roverArray.push(theRover)
	#puts "Rover location: \n#{theRover.x} #{theRover.y} #{theRover.facing}"
end

#print result
roverArray = roverArray.reverse
while(roverArray.any?)
	tempRover = roverArray.pop
	puts "#{tempRover.x} #{tempRover.y} #{tempRover.facing}"
end