# frozen_string_literal: true

class Player
  attr_accessor :cards, :points, :bank, :name

  def initialize(name)
    @name = name
    @cards = []
    @points = 0
    @bank = 100
  end

  def new_hand
    @cards = []
    @points = 0
  end

  def money_bank
    @bank
  end

  def player_move
    puts "Ваши карты - #{@cards}, Ваши очки - #{@points} "
    loop do
      puts "Ваш ход, что хотите выбрать
      1 - Пропустить
      2 - Добавить карту
      3 - Открыть карты
      4 - Завершить игру"
      @choice_player = gets.chomp.to_i
      action(@choice_player)
    end
  end

  def action(choice)
    Game.dealer_game if choice == 1
    Game.add_card(name) if choice == 2 && cards.count < 3
    Game.open_cards if choice == 3
    exit if choice == 4
  end
end
