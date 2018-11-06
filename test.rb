require './advanced_metallic_laminate.rb'
require './control_room.rb'
require './fuel_cell.rb'
require './fuel_tank.rb'
require './hull_section.rb'
require './nuclear_thermal_rocket.rb'
require './particle_beam.rb'
require './ship.rb'

ship1 = Ship.new(
	HullSection.new([
		AdvancedMetallicLaminate.new(),
		AdvancedMetallicLaminate.new(),
		AdvancedMetallicLaminate.new(),
		AdvancedMetallicLaminate.new(),
		AdvancedMetallicLaminate.new(),
		ParticleBeam.new()],
	nil),
	HullSection.new([
		AdvancedMetallicLaminate.new(),
		AdvancedMetallicLaminate.new(),
		AdvancedMetallicLaminate.new(),
		FuelTank.new(),
		FuelTank.new(),
		FuelTank.new()],
	ControlRoom.new()),
	HullSection.new([
		AdvancedMetallicLaminate.new(),
		AdvancedMetallicLaminate.new(),
		AdvancedMetallicLaminate.new(),
		NuclearThermalRocket.new(),
		NuclearThermalRocket.new(),
		FuelTank.new()],
	FuelCell.new())
)

ship2 = ship1.deep_dup

6.times do
	ship1.front_hull.systems[5].fire(ship2.front_hull, 1)
end

"""
[ship1, ship2].each do |ship|
	puts ship.hp
	ship.front_hull.systems.each do |system|
		puts system.status
	end
	puts ship.destroyed
end
"""

4.times do |i|
  puts ship1.delta_v
	ship1.systems.select { |system| system.status == :undamaged && system.class <= FuelTank }.first.disable
end
puts ship1.delta_v

