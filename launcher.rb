require './battery.rb'
require './gurps_utils.rb'

class Launcher < Battery
	ARMOR_DIVISOR = 1 # Assume all armor is hardened
	ACC = 2
	MAX_RANGE = 3 # Long range
	HALF_D = 3 # Long range
	BASE_ROF = 1

	PROXIMITY_BONUS = 4 # Always use proximity detonation
	VELOCITY_PENALTY = -3 # Relative velocity is 2 mps

	def roll_damage
		GurpsUtils.d(6) * 8 # Relative velocity 2 mps
	end

  def effective_skill(range)
		# No RoF bonus because we assume launcher is conserving ammo.
		# TODO: Add relative velocity penalty (but it's zero at short range)
		self.section.ship.skill + self.class::ACC + SHIP_SIZE + FIXED_BONUS + PROXIMITY_BONUS - VELOCITY_PENALTY
	end

	def is_ballistic?
		true
	end
end
