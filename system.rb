class System
  attr_accessor :section, :status, :parent

  def initialize
    @status = :undamaged
  end

	def disable
		if status == :undamaged
			@status = :disabled
		else
			@status = :destroyed
		end
	end

	def destroy
		@status = :destroyed
	end

	def ship
		parent.ship
	end
end
