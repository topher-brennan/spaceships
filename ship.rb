class Ship
	attr_accessor :hp

	MAX_HP = 15

	CREW_SKILL = 11
	HANDLING = 0
	SCALE_DODGE_BONUS = 2

	def initialize(front_hull, central_hull, rear_hull)
		@hp = MAX_HP

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
		skill / 2 + HANDLING + SCALE_DODGE_BONUS
	end
end
