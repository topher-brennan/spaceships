require './battery.rb'
require './gurps_utils.rb'

class UvLaser < Battery
	ARMOR_DIVISOR = 1 # Assume all armor is hardened
	ACC = 0
	MAX_RANGE = 2 # Short range
	HALF_D = 2 # Short range
	BASE_ROF = 2

	def roll_damage
		GurpsUtils.d(3)
	end
end
