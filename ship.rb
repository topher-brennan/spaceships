require './scale.rb'

class Ship
	attr_accessor :hp, :destroyed?

	MAX_HP = 15

	CREW_SKILL = 11
	HANDLING = 0

	def initialize(front_hull, central_hull, rear_hull)
		@hp = MAX_HP
		@destroyed? = false

		@front_hull = front_hull
		@central_hull = central_hull
		@rear_hull = rear_hull
		
		[front_hull, central_hull, rear_hull].each do
		 	|section| section.ship = self
		end
	end

	def skill
		CREW_SKILL
	end

	def dodge
		skill / 2 + HANDLING + Scale::DODGE_BONUS
	end

	def apply_damage(damage)
		damage.times do
			hp -= 1

			if hp <= MAX_HP * -5
				destroyed? = true
			elsif hp < 0 && hp % MAX_HP == 0
				destroyed? = true unless d(3) < HT
			end
		end
	end
end
