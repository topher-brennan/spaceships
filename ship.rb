require './fuel_tank.rb'
require './gurps_utils.rb'
require './nuclear_thermal_rocket.rb'
require './scale.rb'

class Ship
	attr_accessor :hp, :destroyed, :delta_v, :front_hull, :central_hull, :rear_hull

	MAX_HP = 15
	HT = 12
	DELTA_V_PER_TANK = 0.45 # Nuclear thermal rockets.

	CREW_SKILL = 11

	def initialize(front_hull, central_hull, rear_hull)
		@hp = MAX_HP
		@destroyed = false

		@front_hull = front_hull
		@central_hull = central_hull
		@rear_hull = rear_hull
		
		[front_hull, central_hull, rear_hull].each do
		 	|section| section.ship = self
		end
		
		@delta_v = starting_delta_v
	end

	def skill
		CREW_SKILL
	end

	def handling
		# TODO: -2 penalty to handling if ship at 0 hp or less.
		# Also TODO: Support other engine types.
		systems.count { |system| system.class == NuclearThermalRocket } > 1 ? 0 : -1
	end

	def dodge
		skill / 2 + handling + Scale::DODGE_BONUS
	end

	def apply_damage(damage)
		damage.times do
			@hp -= 1

			if hp <= MAX_HP * -5
				@destroyed = true
			elsif hp < 0 && hp % MAX_HP == 0
				@destroyed = true unless GurpsUtils.d(3) <= HT
			end
		end
	end

	def deep_dup
		Ship.new(
			front_hull.deep_dup,
			central_hull.deep_dup,
			rear_hull.deep_dup
		)
	end

	def starting_delta_v
		fuel_tanks = 0

		[@front_hull, @central_hull, @rear_hull].each do |section|
			section.systems.each do |system|
				fuel_tanks += 1 if system.class <= FuelTank
			end

			fuel_tanks += 1 if section.core && section.core.class <= FuelTank
		end

		dv_multiplier = nil

		case fuel_tanks
		when (0..5)
			dv_multiplier = 1
		when (6..8)
			dv_multiplier = 1.2
		when (9..12)
			dv_multiplier = 1.4
		when (13..14)
			dv_multiplier = 1.6
		when 15
			dv_multiplier = 1.8
		when 16
			dv_multiplier = 2.0
		else
			dv_multiplier = 2.2
		end

		fuel_tanks * dv_multiplier * DELTA_V_PER_TANK
	end

	def systems
		result = []
		[@front_hull, @central_hull, @rear_hull].each do |section|
			result = result.concat(section.systems)
			result << section.core if section.core
		end
		result
	end

	def is_threat?
		!destroyed && systems.any? { |system| system.class <= Battery && system.status == :undamaged }
	end
end
