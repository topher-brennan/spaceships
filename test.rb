require './advanced_metallic_laminate.rb'
require './control_room.rb'
require './defensive_ecm.rb'
require './fuel_cell.rb'
require './fuel_tank.rb'
require './hull_section.rb'
require './improved_laser.rb'
require './launcher.rb'
require './light_alloy.rb'
require './metallic_laminate.rb'
require './nanocomposite.rb'
require './nuclear_thermal_rocket.rb'
require './particle_beam.rb'
require './ship.rb'
require './spinal_improved_laser.rb'
require './spinal_particle_beam.rb'
require './spinal_uv_laser.rb'
require './uv_laser.rb'

EXPERIMENTS = 10_000

total_kill_time = 0

EXPERIMENTS.times do
	ship1 = Ship.new(
		HullSection.new([
			AdvancedMetallicLaminate.new(),
			AdvancedMetallicLaminate.new(),
			DefensiveEcm.new(),
			DefensiveEcm.new(),
			DefensiveEcm.new(),
			SpinalImprovedLaser.new()],
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

	round = 0

	while round < 12 && ship2.is_threat?
		round += 1
		ship1.front_hull.systems[5].fire(ship2.front_hull, 2)
	end

	total_kill_time += round
end

average_kill_time = (total_kill_time.to_f / EXPERIMENTS).round(1)

puts "Average kill time: #{average_kill_time}"

"""
4.times do |i|
  puts ship1.delta_v
	ship1.systems.select { |system| system.status == :undamaged && system.class <= FuelTank }.first.disable
end
puts ship1.delta_v
"""

