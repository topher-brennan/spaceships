require './ship.rb'
require './hull_section.rb'
require './armor.rb'

ship = Ship.new(
	HullSection.new([
		Armor.new(1),
		Armor.new(1),
		Armor.new(1),
		Armor.new(1),
		Armor.new(1),
		Armor.new(1)
	], nil),

	HullSection.new([
		Armor.new(1),
		Armor.new(1),
		Armor.new(1),
		Armor.new(1),
		Armor.new(1),
		Armor.new(1)
	], nil),

	HullSection.new([
		Armor.new(1),
		Armor.new(1),
		Armor.new(1),
		Armor.new(1),
		Armor.new(1),
		Armor.new(1)
	], nil)
)
