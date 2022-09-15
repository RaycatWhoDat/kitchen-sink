require "set"
require "csv"

Item = Struct.new(:name)

class Weapon < Item
  @@all_weapons = Set.new

  def initialize(name, attack, size)
    super name
    @attack = attack
    @size = size

    @@all_weapons.add(self)
  end

  def self.get_all_weapons
    @@all_weapons
  end
  
  def self.rebuild_weapons
    @@all_weapons = Set.new
    File.new("./data/weapons.csv", chomp: true).readlines[1..].each do |line|
      next if line.chomp.empty?
      name, attack, size = CSV.parse_line(line)
      Weapon.new(name, attack, size)
    end
  end
end

Weapon.rebuild_weapons
p Weapon.get_all_weapons
