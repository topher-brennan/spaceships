require './system.rb'
require './gurps_utils.rb'

class Battery < System
	RANGE_PENALTY = {
		0 => 0, # point-blank
		1 => -4, # close
		2 => -8, # short
		3 => -12 # long
	}

	SHIP_SIZE = 4
	FIXED_BONUS = 2

	def fire(hull_section, range)
		raise ArgumentError.new("Max range exceeded.") if range > self.class::MAX_RANGE

		target = hull_section.ship

		# TODO: beam attacks get -2 if the ship is at 0 HP or less.
		effective_skill = self.section.ship.skill + self.class::ACC + RANGE_PENALTY[range] + SHIP_SIZE + FIXED_BONUS + rof_bonus
		attack_roll = GurpsUtils.success_roll(effective_skill)

		if attack_roll.is_success
			hits = [attack_roll.margin_of_success + 1, rof].min

			unless attack_roll.is_critical_success # TODO: Drifting spacecraft can't dodge.
				dodge_roll = GurpsUtils.success_roll(target.dodge, true)

				if dodge_roll.is_success
					hits -= dodge_roll.margin_of_success + 1
					hits = [hits, 0].max
				end
			end

			hits.times do
				damage = roll_damage
				damage = damage / 2 if range > self.class::HALF_D
				
				hit_location = GurpsUtils.d() - 1
				total_armor = 0

				6.times do |i|
					system = hull_section.systems[i]

					if (hit_location != i || system.status != :destroyed) && system.class <= Armor
						total_armor += system.ddr
					end
				end

				damage -= (total_armor / self.class::ARMOR_DIVISOR).floor

				unless hull_section.systems.all? { |system| system.status == :destroyed }
					while hull_section.systems[hit_location].status == :destroyed
						hit_location += 1
						hit_location = 0 if hit_location > 5
					end

					if damage > Ship::MAX_HP / 2
						hull_section.systems[hit_location].destroy
					elsif damage > Ship::MAX_HP / 10
						hull_section.systems[hit_location].disable
					end
				end

				# TODO: Handle spill-over into core, then other hull sections

				target.apply_damage(damage)
			end
		elsif attack_roll.is_critical_failure
			disable
		end
	end
	
	def rof
		Scale::ROF_MULTIPLIER * self.class::BASE_ROF
	end

	def rof_bonus
		case rof
		when (1..4)
			0
		when (5..8)
			1
		when (9..12)
			2
		when (13..16)
			3
		when (17..24)
			4
		else # ROF > 30 not supported.
			5
		end
	end
end	
