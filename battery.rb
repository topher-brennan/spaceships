require './system.rb'

class Battery < System
	include GurpsUtils

	RANGE_PENALTY = {
		point_blank: 0,
		close: -4,
		short: -8,
		long: -12
	}

	SHIP_SIZE = 4

	def fire(hull_section, range)
		target = hull_section.ship

		effective_skill = self.section.ship.crew_skill + RANGE_PENALTY[range] + SHIP_SIZE
    attack_roll = success_roll(effective_skill)

		if attack_roll.is_success
			hits = attack_roll.margin_of_success + 1

			unless attack_roll.is_critical_success
				dodge_roll = success_roll(target.dodge, true)

				if dodge_roll.is_success
					hits -= dodge_roll.margin_of_success + 1
					hits = [hits, 0].max
				end
			end

			hits.times do
				damage = d(3)
			  damage = damage / 2 if range == :long
				# subtract armor		
			end
		elsif attack_roll.is_critical_failure
			# battery becomes disabled
		end
	end
end	
