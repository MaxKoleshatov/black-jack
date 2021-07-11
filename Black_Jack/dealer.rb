# frozen_string_literal: true

class Dealer
  attr_accessor :cards_dealer, :points_dealer, :dealer_bank

  def initialize
    @cards_dealer = []
    @points_dealer = 0
    @dealer_bank = 100
  end

  def dealer_game(cards)
    @cards = cards
    if points_dealer < 17
      self.points_dealer = 0
      self.cards_dealer += @cards.one_random_cards
      self.cards_dealer.each do |cards|
        self.points_dealer += @cards.cards_all[cards.to_s.to_sym]
        self.points_dealer
      end
      puts 'Диллер взял себе одну карту'
    else
      self.cards_dealer
      puts 'Диллер не взял себе карту'
    end
  end
end
