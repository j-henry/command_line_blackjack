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
    puts "#{suit}"
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
    puts "\nStandard French deck..."#; sleep(2)
    self.undelt.each {|card| puts card; sleep(0.0)}#;sleep(1)
    puts "Ace is alwsys 11."#; sleep(2)
    puts "Player always wins with Blackjack."#; sleep(2)
  end

  def shuffle!
    self.undelt.shuffle!
  end

end
