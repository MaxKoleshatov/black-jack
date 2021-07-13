# frozen_string_literal: true

require_relative 'player'
require_relative 'dealer'
require_relative 'cards'

class Game
  def self.new_game
    puts 'Здравствуйте! Как ваше имя?'
    player_name = gets.chomp
    @player = Player.new(player_name)
    @dealer = Dealer.new('Dealer')
    @cards = Cards.new
    @rate = 10
    puts "#{player_name}, началсь новая игра"
    start_game
  end

  def self.dealer_game
    @dealer.dealer_move
  end

  def self.add_card(name)
    if name == 'Dealer'
      @dealer.cards += @cards.random
      @dealer.points = @cards.check_points(@dealer.cards)
      puts 'Дилер взял себе карту'
      open_cards if @player.cards.count == 3
    else
      puts "Ваши новые карты #{@player.cards += @cards.random}"
      puts "Ваши очки теперь #{@player.points = @cards.check_points(@player.cards)}"
      open_cards if @dealer.cards.count == 3
    end
  end

  def self.start_game
    puts 'Началась новая раздача'
    @player.new_hand
    @dealer.new_hand
    2.times do
      @player.cards += @cards.random
      @dealer.cards += @cards.random
    end
    @player.points = @cards.check_points(@player.cards)
    @dealer.points = @cards.check_points(@dealer.cards)
    @player.player_move
  end

  def self.open_cards
    puts 'Открываем карты'
    puts "Ваши карты: #{@player.cards}, Ваши очки: #{@player.points} "
    puts "Карты диллера: #{@dealer.cards}, Очки диллера: #{@dealer.points}"
    winner
  end

  def self.winner
    if @player.points > @dealer.points && @player.points <= 21 || @player.points <= 21 && @dealer.points > 21
      puts "Вы выйграли раздачу, Ваш банк #{@player.bank += @rate}$, Диллера банк #{@dealer.bank -= @rate}$"
    elsif @player.points < @dealer.points || @player.points > 21
      puts "Вы проиграли раздачу, Ваш банк #{@player.bank -= @rate}$, Диллера банк #{@dealer.bank += @rate}$"
    else
      @player.points == @dealer.points && @player.points <= 21
      puts "Ничья, Ваш банк #{@player.bank}$, Диллера банк #{@dealer.bank}$"
    end

    start_game if @player.money_bank != 0 && @dealer.money_bank != 0
    restart if @player.money_bank.zero? || @dealer.money_bank.zero?
  end

  def self.restart
    puts 'Вы выйграли игру' if @dealer.bank.zero?
    puts 'Вы проиграли игру' if @player.bank.zero?
    puts "Хотите сыграть еще раз?
  1 - да
  2 - нет"
    player_answer = gets.chomp.to_i
    new_game if player_answer == 1
    exit if player_answer == 2
  end
end

Game.new_game
