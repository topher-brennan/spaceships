require './success_roll_result.rb'

module GurpsUtils
  def self.d(n = 1)
    result = 0
    n.times { |i| result += 1 + Random.rand(6) }
    result
  end

  def self.quick_contest(skill_1, skill_2)
    mos_1 = skill_1 - d(3)
    mos_2 = skill_2 - d(3)
    mos_1 - mos_2
  end

  # defensive flag is for FAQ item 3.1.3.
  def self.success_roll(skill, defensive = false)
    roll = d(3)
    type = nil
    mos = skill - roll    

    if roll <= 4 && (skill > 2 || defensive)
      type = :critical_success
    elsif roll <= 6 && roll <= skill - 10
      type = :critical_success
    elsif roll == 18 || (roll == 17 && skill <= 15) || (roll >= skill + 10)
      type = :critical_failure
    elsif roll > skill || roll == 17
      type = :failure
    else
      type = :success
    end

    SuccessRollResult.new(type, mos)
  end
end
