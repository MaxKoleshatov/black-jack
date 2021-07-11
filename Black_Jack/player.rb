# frozen_string_literal: true

class Player
  attr_accessor :cards_player, :points_player, :player_bank

  def initialize
    @cards_player = []
    @points_player = 0
    @player_bank = 100
  end

  def player_game(cards)
    @cards = cards
    if cards_player.count < 3
      self.points_player = 0
      self.cards_player += @cards.one_random_cards
      self.cards_player.each do |cards|
        self.points_player += @cards.cards_all[cards.to_s.to_sym]
      end
      player_game_ace
      puts "Теперь ваши карты #{self.cards_player}, Ваши очки #{self.points_player}"
    else
      puts 'Можно брать только одну карту за раздачу'
    end
  end

  def player_game_ace
    self.points_player -= 10 if self.points_player > 21 && self.cards_player.join('').include?('A')
  end
end
