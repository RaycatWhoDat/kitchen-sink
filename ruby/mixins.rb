module Malleable
  attr_accessor :malleability

  def strike
    @malleability = @malleability.clamp(0, @malleability - 10)
  end
end

module Moldable
  attr_accessor :molds, :current_mold

  def mold
    @current_mold = @molds.sample
  end
end

class Material
  include Malleable
  include Moldable

  attr_accessor :name

  def initialize name
    @name = name
    @malleability = 100
    @molds = %w[Anchor Ball Cup]
  end

  def status
    puts "Name: #@name"
    puts "Malleability: #@malleability"
    puts "Current Mold: #@current_mold" if @current_mold
    puts
  end
end

material = Material.new("Thesium")
material.status
5.times { material.strike }
material.mold
material.status
    
