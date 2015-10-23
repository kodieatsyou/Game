require "gosu"
require_relative 'player'
require_relative 'z_order'
require_relative 'star'
require_relative "bomb"

class GameWindow < Gosu::Window

	def initialize
		super 640, 480
		self.caption = "Star Cadet"

		@background_image = Gosu::Image.new("media/grass.png", 
																				:tileable => true)
		@player = Player.new
		@player.warp(width/2.0, height/2.0)

		@star_anim = Gosu::Image::load_tiles("media/star.png", 25, 25)
		@stars = []

		@bombs = []

		@font = Gosu::Font.new(20)
	end

	def update
			@player.turn_left if Gosu::button_down? Gosu::KbLeft
			@player.turn_right if Gosu::button_down? Gosu::KbRight
			@player.accelerate if Gosu::button_down? Gosu::KbUp

			@player.move
			@player.collect_stars(@stars)

			if rand(100) < 4 && @stars.size < 25
				@stars.push(Star.new(@star_anim))
			end

			if rand(100) < 5 && @bombs.size < 10
				@bombs.push(Bomb.new(self, 3000, @bombs.length - 1, 300, @player))
			end

			@bombs.each do |bomb|
				bomb.count_down
			end
			@bombs.each {|bomb| @bombs.delete(bomb) if bomb.remove}
	end

	def draw
		if @player.health > 0
			@player.draw
			@background_image.draw(0, 0, ZOrder::BACKGROUND)
			@stars.each {|star| star.draw}
			@bombs.each {|bomb| bomb.draw}
			@font.draw("Score: #{@player.score}", 10, 10, ZOrder::UI, 1.0, 1.0, 0xff_ffff00)
			@font.draw("Health: #{@player.health}", 10, 25, ZOrder::UI, 1.0, 1.0, 0xff_ffff00)
		else
			@font.draw("GAME OVER", 100, 100, ZOrder::UI, 1.0, 1.0, 0xff_ffff00)
		end
	end

	def button_down(id)
		close if id == Gosu::KbEscape
	end

end

window = GameWindow.new
window.show