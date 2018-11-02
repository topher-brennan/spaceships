class HullSection
	attr_accessor :ship

	def initialize(systems, core)
		raise ArgumentError.new("Must have six systems.") unless systems.count == 6

		@systems = systems
		@core = core
		
		systems.each do |system|
			system.section = self
		end

		core.section = self if core
	end
end
