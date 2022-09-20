UserAccount = Struct.new(:current_balance)

class SlotMachine
  attr_accessor :reel_height,
                :number_of_reels,
                :minimum_of_winning_reels,
                :minimum_bet,
                :current_bet,
                :maximum_bet,
                :max_multiplier,
                :payout_table,
                :all_reels,
                :number_of_spins,
                :last_spin,
                :last_payout

  def initialize
    @reel_height = 5
    @number_of_reels = 6
    @minimum_of_winning_reels = 4
    @minimum_bet = 100
    @current_bet = 100000
    @maximum_bet = 100000
    @max_multiplier = 5000
    @slot_symbols = %i[TEN J Q K A SCROLL URN HELMET PEGASUS ATHENA]
    @payout_table = {
      :TEN => [0.15, 0.20, 0.30],
      :J => [0.20, 0.30, 0.40],
      :Q => [0.30, 0.40, 0.50],
      :K => [0.25, 0.50, 1],
      :A => [0.50, 1, 2],
      :SCROLL => [3, 5, 10],
      :URN => [10, 25, 50],
      :HELMET => [50, 100, 200],
      :PEGASUS => [250, 500, 1_000],
      :ATHENA => [500, 2_500, @max_multiplier]
    }

    @all_reels = @number_of_reels.times.map { @slot_symbols }
    @number_of_spins = 0
  end

  def can_spin? account
    account.current_balance >= @current_bet
  end

  def spin account
    unless can_spin?(account)
      puts "Not enough credits to spin."
      return
    end

    account.current_balance -= @current_bet
    @number_of_spins += 1
    @last_spin = @all_reels.map { |reel| reel.sample(@reel_height) }
    is_winning_spin? account
  end

  def is_winning_spin? account
    winning_symbols = @last_spin[0].uniq
    number_of_winning_reels = 1
    possible_wins = @last_spin[1..].inject([]) do |wins, reel|
      next_wins = winning_symbols.select { |symbol| reel.uniq.include?(symbol) }
      break if next_wins.length < 1
      number_of_winning_reels += 1
      winning_symbols = next_wins
      wins << reel
    end
    @last_payout = 0
    multipliers = [0]

    if number_of_winning_reels >= @minimum_of_winning_reels
      puts "Won on #{winning_symbols.join(', ')} across #{number_of_winning_reels} reels!"

      multipliers = winning_symbols.map do |symbol|
        @payout_table[symbol][number_of_winning_reels - @minimum_of_winning_reels]
      end
    end

    @last_payout = multipliers.sum { |multiplier| multiplier * @current_bet }
    puts "Current bet: $#{@current_bet / 100}"
    multipliers.map! { |multiplier| multiplier.to_s + "x" }
    puts "Multipliers: #{multipliers.join(', ')}"
    puts "Payout: $#{@last_payout / 100}"
    account.current_balance += @last_payout
    puts "Current balance: $#{account.current_balance / 100}"
    puts "==============="
  end
end

user_account = UserAccount.new(100000)
slot_machine = SlotMachine.new

loop do
  break unless slot_machine.can_spin?(user_account) and slot_machine.number_of_spins <= 10
  slot_machine.spin user_account
end

puts "Total number of spins: #{slot_machine.number_of_spins}"
