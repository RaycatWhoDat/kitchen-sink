BlackjackCard = Struct.new(:repr, :value)

class BlackjackHand
  attr_accessor :cards, :total

  def initialize cards = nil
    @cards = cards
    self.hit
  end

  def status
    puts @cards.map { |card| card.repr }
    puts "Total value: #@total"
  end

  def hit deck = nil
    @cards << deck.hit if deck
    @total = @cards.inject([0, 0]) do |total, card|
      total[0] += card.value[0]
      total[1] += card.value[1]
      total
    end
  end
end

class BlackjackDeck
  @@starting_hand_size = 2
  @@number_of_players = 1

  attr_accessor :cards
  
  def initialize
    self.reset
  end

  def reset
    @cards = [(2..10).to_a, %w[J Q K A]].flatten.product(%w[♥ ♠ ♦ ♣]).map do |value, suit|
      case value
      when 2..9
        BlackjackCard.new("#{value}#{suit}", [value, value])
      when 10, "J", "Q", "K"
        BlackjackCard.new("#{value}#{suit}", [10, 10])
      when "A"
        BlackjackCard.new("#{value}#{suit}", [1, 11])
      end
    end
  end

  def deal
    @cards
      .sample(@@starting_hand_size * (@@number_of_players + 1))
      .each_slice(2)
  end

  def hit
    @cards.sample
  end
end

deck = BlackjackDeck.new
player_hand = BlackjackHand.new(deck.deal.first)
player_hand.status

until player_hand.total.min > 21
  player_hand.hit(deck)
  player_hand.status
end

puts "You've busted!"
