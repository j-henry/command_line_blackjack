class Card

  attr_accessor :suit, :face, :value

  def initialize(suit, face, value)
    self.suit = suit
    self.face = face
    self.value = value
  end

  def to_s
    "#{face}-#{suit}=#{value}"
  end

end
