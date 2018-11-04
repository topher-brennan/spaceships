require './ship.rb'
require './hull_section.rb'
require './light_alloy.rb'


section_prototype =
	HullSection.new([
		LightAlloy.new(),
		LightAlloy.new(),
		LightAlloy.new(),
		LightAlloy.new(),
		LightAlloy.new(),
		UvLaser.new(),
	], nil)

ship = Ship.new(
  section_prototype.deep_dup,
  section_prototype.deep_dup,
  section_prototype.deep_dup
)
