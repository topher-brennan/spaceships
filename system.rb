class System
  attr_accessor :section, :status

  def initialize
    @status = :undamaged
  end

	def disable
		if status == :undamaged
			status = :disabled
		else
			status = :destroyed
		end
	end

	def destroy
		status = :destroyed
	end
end
