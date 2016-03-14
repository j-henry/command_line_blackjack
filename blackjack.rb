require './deck'
require './card'

# Rubocop Offenses Down from 55 to 31
# For storing core game logic
# Handles pathing for round advancing and winning
class BlackJack
                # core game instance vars
  attr_accessor :shoe, :dealer_hand, :player_hand, :round_num, :dealer_wins,
                :player_wins,
                # betting instance variables
                :betting_box, :player_cash, :player_bet

  def initialize
    self.shoe = Deck.new.shuffle!
    shoe.card_wave
    self.player_cash = 100
    self.round_num = 0
    self.dealer_wins = 0
    self.player_wins = 0
  end

  def round  # assignment branch size and cyclomatic complexity too high, method has too many lines, complexity too high
    discard
    puts deal(2, 2)
    check_blackjack

    # I broke player hitting somehow!

    while player_score < 21
      if hit? # Use a guard clause instead
        puts "you drew a #{player_hand.last}. Current points #{player_score}"
      else
        break
      end
      puts 'You busted!' if player_score > 21
    end

    if player_score < 21
      while hit
        deal(0, 1)
        puts "dealer drew a #{dealer_hand.last}. Current points #{dealer_score}"
        puts "Dealer busted!" if dealer_score > 21
      end
    end
    self.round_num += 1
    player_wins?
    resolution
  end

  def discard
    self.player_hand = []
    self.dealer_hand = []
    self.betting_box = 0
  end

  def deal(to_player, to_dealer = 0)
      to_player.times {player_hand << shoe.shift if to_player > 0}
      to_dealer.times {dealer_hand << shoe.shift if to_dealer > 0}
    "You have #{player_hand.join(' and ')} (#{player_score})...Dealer shows #{dealer_hand.first}"
  end

  def hit?
    print '(h)it or (s)tay?'
    player_score if gets.downcase.chomp == 'h\n'
  end

  def hit
    if dealer_score < 16 && player_score <= 21
      print "Dealer hits - "
      true
    end
  end

  def player_score
    player_hand.reduce(0) { |a, e| a += e.value }
  end

  def dealer_victory
    puts "Dealer wins"
    self.dealer_wins += 1
  end

  def player_victory
    puts "Player wins"
    `say "great job!"`
    self.player_wins += 1
  end

  def dealer_score
    dealer_hand.reduce(0) { |a, e| a += e.value }
  end

  def check_blackjack
    if player_score == 21
      puts 'Player wins with Blackjack'
      player_wins?
      resolution
    elsif dealer_score == 21
      puts 'Dealer wins with Blackjack'
      `say 'Better luck next time'`
      player_wins?
      resolution
    end
  end

  def player_wins? # too long, too complex
    if player_score > 21
      dealer_victory
    elsif dealer_score > 21
      player_victory
    elsif player_hand.size > 5
      player_victory

    elsif dealer_score > player_score
      dealer_victory
    elsif player_score > dealer_score
      player_victory

    elsif player_score == dealer_score
      if player_hand.size > dealer_hand.size
        player_victory
      elsif dealer_hand.size > player_hand.size
        dealer_victory
      else
        player_victory
      end
    end
  end

  def resolution
    puts "_____________________Round #{round_num}_________________"
    puts "Dealer: #{dealer_score} with #{dealer_hand.join(", ")}"
    puts "Player: #{player_score} with #{player_hand.join(", ")}\n"
    puts "Player wins #{((self.player_wins/round_num.to_f)*100).round(2)} percent of the time\n\n"
    puts "----Hit return for another round. Type exit to quit.----"
    round if gets.chomp == ''
  end
end

game = BlackJack.new
game.round

  # def bet
  #   p "You have #{player_cash}$. How much do you want to bet?"
  #   player_bet = gets.chomp.to_i
  #   p betting_box
  #   p player_bet
  #   self.betting_box += player_bet
  #   self.player_cash -= player_bet
  # end
