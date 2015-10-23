require "gosu"
require_relative 'z_order'
require_relative 'player'

class Bomb

	attr_accessor :x, :y, :remove

	def initialize(window, time, index, remove_time, player)
		@window = window
		@radius = 100
		@explode_time = Gosu::milliseconds + time
		@remove_time = @explode_time + remove_time
		@image = Gosu::Image.new("media/bomb.bmp")	
		@exploded = false
		@remove = false
		@index = index
		@hurt_player = false
		@player = player


		@x = rand * 640
		@y = rand * 480
	end

	def draw
		if !@exploded
			@image.draw(@x, @y, ZOrder::STARS)
		end
		if @exploded
			animation = Gosu::Image::load_tiles("media/explosion.png", 33, 36)
			img = animation[Gosu::milliseconds / 100 % animation.size]
			img.draw(
				@x - img.width / 10.0,
				@y - img.height / 10.0,
				ZOrder::STARS)
		end
	end

	def count_down
		if Gosu::milliseconds > @explode_time 
			@exploded = true
		end
		if @exploded && !remove && Gosu::milliseconds > @remove_time
			@remove = true;
		end
		if @exploded && !@hurt_player && Gosu::distance(@x, @y, @player.x, @player.y) <= @radius
			@player.hurt(100)
			@hurt_player = true
		end
	end
end