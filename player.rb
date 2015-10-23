require "gosu"
require_relative "z_order"
require_relative "star"
require_relative "bomb"

class Player

	attr_accessor :health, :x, :y

	TURN_INCREMENT = 2.5
	ACCELERATION = 0.2
	COLLISION_DISTANCE = 35

	def initialize
		@x = @y = @vel_x = @vel_y = @angle = 0.0
		@score = 0
		@image = Gosu::Image.new("media/starfighter.bmp")		
		@beep = Gosu::Sample.new("media/beep.wav")
		@health = 100
	end

	def warp(x, y)
		@x, @y = x, y
	end

	def turn_left
		@angle -= TURN_INCREMENT
	end

	def turn_right
		@angle += TURN_INCREMENT
	end

	def accelerate
		@vel_x += Gosu::offset_x(@angle, ACCELERATION)
		@vel_y += Gosu::offset_y(@angle, ACCELERATION)
	end

	def move
		@x += @vel_x
		@y += @vel_y

		@x %= 640
		@y %= 480

		@vel_x *= 0.95
		@vel_y *= 0.95
	end

	def draw
		@image.draw_rot(@x, @y, ZOrder::PLAYER, @angle)
	end

	def score
		@score
	end

	def health
		@health
	end

	def collect_stars(stars)
		if stars.reject! {|star| colliding_with_star?(star)}
			@score += 1
			@beep.play
			true
		else
			false
		end
	end

	def hurt(health)
		@health -= health
	end

	private

		def colliding_with_star?(star)
			Gosu::distance(@x, @y, star.x, star.y) < COLLISION_DISTANCE
		end
end