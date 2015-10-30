require "gosu"
require_relative "z_order"
class Healthpack

	attr_reader :x, :y, :health

	def initialize

		@image = Gosu::Image.new("media/Pumpkin_Pie.png")

		@health = 10

		@x = rand * 640
		@y = rand * 480
	end
end