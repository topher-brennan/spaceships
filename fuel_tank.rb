require './system.rb'

class FuelTank < System
	def disable
		leak_fuel if @status == :undamaged
		super
	end

	def destroy
		leak_fuel if @status == :undamaged
		super
	end

	def leak_fuel
		undamaged_fuel_tanks = ship.systems.count { |system| system.status == :undamaged && system.class <= FuelTank }
		ship.delta_v = ship.delta_v * (undamaged_fuel_tanks - 1) / undamaged_fuel_tanks
	end
end
