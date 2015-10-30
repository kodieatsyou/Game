require_relative "star"

class SuperStar < Star

	def initialize(animation)
		super(animation)
		self.zoomlvl = 3
		self.points = 10
		c = Gosu::Color.new(0xff_000000)
		c.red = 256
		c.green = 0
		c.blue = 0
		color = c
	end
end