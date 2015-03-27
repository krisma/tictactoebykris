class Singlegame < ActiveRecord::Base
	def cur
		return @singlegame.status[@singlegame.turn * 9, 9]
	end
end
