require_relative"player"

class Laser

	SPEED = 5

	def initialize (x, y, angle)
		@x = x
		@y = y
		@angle = angle
		@img = Gosu::Image.new("media/laser.png")
	end

	def update 
		@x += Gosu::offset_x(@angle, SPEED)
		@y += Gosu::offset_y(@angle, SPEED)
	end

	def draw
		@img.draw_rot(@x,@y, ZOrder::PLAYER, @angle)
	end
end