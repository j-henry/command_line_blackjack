require './card'

class Deck

  attr_accessor :order, :undelt, :shoe_of_cards

  def initialize
    self.undelt = make
    self.shoe_of_cards = []
  end

  def make
    faces = %w(2 3 4 5 6 7 8 9 X J K Q A)
    suits = %w(S H D C)
    shoe_of_cards = []

  suits.each do |suit|
      faces.each.with_index do |face, value|
        value += 2
        value = 10 if value > 10
        value = 11 if face == "A"
        shoe_of_cards << Card.new(suit, face, value)
      end
    end
    shoe_of_cards
  end

  def card_wave
    puts "\nStandard French deck..."
    puts "Ace is always 11."
    puts "Player always wins with Blackjack.\n"
  end

  def shuffle!
    self.undelt.shuffle!
  end

end
