require "gosu"
require_relative "z_order"

class Star

	attr_reader :x, :y, :points
	attr_accessor :zoomlvl, :color, :points

	def initialize(animation)
		@animation = animation
		@color = Gosu::Color.new(0xff_000000)
		@color.red = random_color_component_not_too_dark
		@color.green = random_color_component_not_too_dark
		@color.blue = random_color_component_not_too_dark
		@points = 1

		@x = rand * 640
		@y = rand * 480

		@zoomlvl = 1
	end

	def draw
		img = @animation[Gosu::milliseconds / 100 % @animation.size]
		img.draw(
			@x - img.width / 2.0,
			@y - img.height / 2.0,
			ZOrder::STARS,
			zoomlvl, zoomlvl, color, :add)
	end

	private

		def random_color_component_not_too_dark
			rand(256 - 40) + 40
		end

end