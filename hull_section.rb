class HullSection
	attr_accessor :ship, :systems, :core

	def initialize(systems, core)
		raise ArgumentError.new("Must have six systems.") unless systems.count == 6

		@systems = systems
		@core = core
		
		systems.each do |system|
			system.section = self
		end

		core.section = self if core
	end

	def deep_dup
		new_systems = systems.map { |system| system.dup }
		new_core = (core == nil ? nil : core.dup)
		HullSection.new(new_systems, new_core)
	end
end
