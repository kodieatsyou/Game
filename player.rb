require "gosu"
require_relative "z_order"
require_relative "star"
require_relative "bomb"
require_relative "laser"
require_relative "healthpack"

class Player

	attr_accessor :health, :x, :y, :lasers

	TURN_INCREMENT = 2.5
	ACCELERATION = 0.2
	COLLISION_DISTANCE = 35

	def initialize
		@x = @y = @vel_x = @vel_y = @angle = 0.0
		@score = 0
		@image = Gosu::Image.new("media/starfighter.bmp")		
		@beep = Gosu::Sample.new("media/beep.wav")
		@health = 100
		@can_shoot = true
		@shoot_delay = 4000
		@lasers = []
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
		stars.reject!  do |star| 
			if colliding_with_star?(star)
			@score += star.points
			@beep.play
			true
			else
			false
			end
		end
	end

	def hurt(health)
		@health -= health
	end

	def shoot
		if @can_shoot == true
			@lasers.push(Laser.new(@x,@y,@angle)) 
			@can_shoot = false
			@shoot_delay = Gosu::milliseconds + 500
		end
	end

	def shoot_delay
		if Gosu::milliseconds > @shoot_delay
			@can_shoot = true
		end
	end

	def collect_healthpack(healthpack)
		healthpacks.reject!  do |pack| 
		if colliding_with_pack?(pack)
			@health += healthpack.health
			true
		else
			false
		end
	end
end

	private

		def colliding_with_star?(star)
			Gosu::distance(@x, @y, star.x, star.y) < COLLISION_DISTANCE
		end
		def colliding_with_pack?(healthpack)
			Gosu::distance(@x, @y, healthpack.x, healthpack.y) < COLLISION_DISTANCE
		end
end