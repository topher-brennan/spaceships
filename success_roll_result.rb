class SuccessRollResult
  attr_reader :type, :margin_of_success

  TYPES = [
    :critical_success,
    :success,
    :failure,
    :critical_failure,
  ]

  def initialize(type, margin_of_success)
    raise ArgumentError.new("Invalid type.") unless TYPES.include?(type)
    @type = type
   
    if is_success
      @margin_of_success = [margin_of_success, 0].max
    else
      @margin_of_success = [margin_of_success, -1].min
    end
  end

  def is_critical_success
    @type == :critical_success
  end

  def is_success
    [:critical_success, :success].include?(@type)
  end

  def is_failure
    !is_success
  end

  def is_critical_failure
    @type == :critical_failure
  end

  def margin_of_failure
    margin_of_success * -1
  end
end
