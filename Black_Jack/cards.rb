# frozen_string_literal: true

class Cards
  attr_accessor :cards_all, :two_cards_game, :one_cards_game, :all_cards_game

  def initialize
    @cards_all = { "2+": 2, "2<3": 2, "2^": 2, "2<>": 2, "3+": 3, "3<3": 3, "3^": 3, "3<>": 3, "4+": 4, "4<3": 4, "4^": 4, "4<>": 4, "5+": 5, "5<3": 5, "5^": 5, "5<>": 5, "6+": 6, "6<3": 6, "6^": 6, "6<>": 6, "7+": 7, "7<3": 7, "7^": 7, "7<>": 7,
                   "8+": 8, "8<3": 8, "8^": 8, "8<>": 8, "9+": 9, "9<3": 9, "9^": 9, "9<>": 9,
                   "10+": 10, "10<3": 10, "10^": 10, "10<>": 10, "B+": 10, "B<3": 10, "B^": 10, " B<>": 10,
                   "D+": 10, "D<3": 10, "D^": 10, "D<>": 10, "K+": 10, "K<3": 10, "K^": 10, "K<>": 10,
                   "A+": 11, "A<3": 11, "A^": 11, "A<>": 11 }

    @two_cards_game = []
    @one_cards_game = []
  end

  def two_random_cards
    all_cards = []
    two_cards_game.clear
    @cards_all.each do |cards, _volume|
      all_cards << cards
    end

    @two_random_cards = 2.times.map { all_cards.sample.to_s }

    self.two_cards_game += @two_random_cards
  end

  def one_random_cards
    all_cards = []
    one_cards_game.clear
    @cards_all.each do |cards, _volume|
      all_cards << cards
    end

    @one_random_cards = 1.times.map { all_cards.sample.to_s }

    self.one_cards_game += @one_random_cards
  end

  def points_cards
    points = 0
    two_cards_game.each do |card|
      points += @cards_all[card.to_s.to_sym]
    end

    one_cards_game.each do |card|
      points += @cards_all[card.to_s.to_sym]
    end
    points
  end
end
