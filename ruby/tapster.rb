class Card < Struct.new(:number, :cardholder_name, :balance, :ounces_poured)
  def initialize(number, cardholder_name, balance = 0.00, ounces_poured = 0.00)
    super
  end
end

class ReaderEvent < Struct.new(:type, :payload, :timestamp)
  def initialize(type, payload, timestamp = Time.now.to_i)
    super
  end
end

class Reader
  attr_accessor :current_card, :events

  def initialize
    @events = []
  end

  def insert_card(card)
    @events.push(ReaderEvent.new(:inserted, card.cardholder_name))
    @current_card = card
  end

  def charge_card(ounces_poured, price_per_ounce)
    new_charge = ounces_poured * price_per_ounce
    
    @events.push(ReaderEvent.new(:charged, new_charge))
    @current_card.ounces_poured = ounces_poured
    @current_card.balance += new_charge
  end

  def remove_card
    @events.push(ReaderEvent.new(:removed, @current_card.cardholder_name))
    @current_card = nil
  end

  def display_stats
    return if @current_card == nil
    puts "Cardholder Name: #{@current_card.cardholder_name}"
    puts "Ounces Poured: #{@current_card.ounces_poured.round(2)}"
    puts "Total Balance: $#{@current_card.balance.round(2)}"
  end
end

card = Card.new("5555555555555555", "Ray Perry")
reader = Reader.new
reader.insert_card(card)
reader.charge_card(10.1, 0.79)
reader.display_stats
reader.remove_card

reader.display_stats
