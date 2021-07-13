# frozen_string_literal: true

class Cards
  attr_accessor :cards_all

  def initialize
    @cards_all = { "2♣": 2, "2♥": 2, "2♠": 2, "2♦": 2, "3♣": 3, "3♥": 3, "3♠": 3, "3♦": 3,
                   "4♣": 4, "4♥": 4, "4♠": 4, "4♦": 4, "5♣": 5, "5♥": 5, "5♠": 5, "5♦": 5,
                   "6♣": 6, "6♥": 6, "6♠": 6, "6♦": 6, "7♣": 7, "7♥": 7, "7♠": 7, "7♦": 7,
                   "8♣": 8, "8♥": 8, "8♠": 8, "8♦": 8, "9♣": 9, "9♥": 9, "9♠": 9, "9♦": 9,
                   "10♣": 10, "10♥": 10, "10♠": 10, "10♦": 10, "B♣": 10, "B♥": 10, "B♠": 10, " B♦": 10,
                   "D♣": 10, "D♥": 10, "D♠": 10, "D♦": 10, "K♣": 10, "K♥": 10, "K♠": 10, "K♦": 10,
                   "A♣": 11, "A♥": 11, "A♠": 11, "A♦": 11 }
  end

  def random
    all_cards = []
    @cards_all.each do |cards, _volume|
      all_cards << cards
    end
    random_card = 1.times.map { all_cards.sample.to_s }
  end

  def check_points(cards)
    points = 0
    cards.each do |card|
      points += @cards_all[card.to_sym]
      points -= 10 if points > 21 && cards.join('').include?('A')
    end
    points
  end
end
