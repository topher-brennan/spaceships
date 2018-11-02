require './system.rb'

class Armor < System
  attr_accessor :ddr

  def initialize(ddr)
    @ddr = ddr
    super()
  end
end
