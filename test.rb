require './ship.rb'
require './hull_section.rb'
require './light_alloy.rb'
require './uv_laser.rb'

section_prototype =
	HullSection.new([
		LightAlloy.new(),
		LightAlloy.new(),
		LightAlloy.new(),
		LightAlloy.new(),
		LightAlloy.new(),
		UvLaser.new(),
	], nil)

ship1 = Ship.new(
  section_prototype.deep_dup,
  section_prototype.deep_dup,
  section_prototype.deep_dup
)

ship2 = ship1.deep_dup

ship1.front_hull.systems[5].fire(ship2.front_hull, 2)

[ship1, ship2].each do |ship|
	puts ship.hp
	ship.front_hull.systems.each do |system|
		puts system.status
	end
end
