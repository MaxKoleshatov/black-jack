# frozen_string_literal: true

class Dealer < Player
  def dealer_move
    if points < 17
      Game.add_card(name) if cards.count < 3
    else
      puts 'Дилер не взял карту'
    end
  end
end
