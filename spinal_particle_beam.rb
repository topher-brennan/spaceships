require './battery.rb'
require './gurps_utils.rb'

class SpinalParticleBeam < Battery
	ARMOR_DIVISOR = 3 # Assume all armor is hardened
	ACC = 0
	MAX_RANGE = 2 # Short range
	HALF_D = 1 # Close range
	BASE_ROF = 1

	def roll_damage
		GurpsUtils.d(4)
	end
end
