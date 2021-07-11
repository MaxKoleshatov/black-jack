# frozen_string_literal: true

require_relative 'dealer'
require_relative 'player'
require_relative 'cards'

def game
  puts 'Здравствуйте! Как ваше имя?'
  player_name = gets.chomp
  loop do
    puts "#{player_name}, Желаете сыграть?
    1 - Да
    2 - Нет"
    player_answer = gets.chomp.to_i
    case player_answer
    when 1
      @player = Player.new
      @dealer = Dealer.new
      @rate = 10
      puts "Началась новая игра. Ставка - #{@rate}"
      start_game
      break
    when 2
      puts 'Игра закончена'
      exit
    else
      puts 'Неверный ввод, попробуйте еще раз'
    end
  end
end

def start_game
  if @player.player_bank != 0 && @dealer.dealer_bank != 0
    puts 'Началась новая раздача'
    @player.cards_player.clear
    @player.points_player = 0
    @dealer.cards_dealer.clear
    @dealer.points_dealer = 0
    @cards = Cards.new
    @player.cards_player += @cards.two_random_cards
    puts "Ваши карты - #{@player.cards_player}, Ваши очки - #{@player.points_player += @cards.points_cards}, Ваш банк - #{@player.player_bank}$"
    @dealer.cards_dealer += @cards.two_random_cards
    @dealer.points_dealer += @cards.points_cards
    puts "Диллера карты - **, Диллера банк - #{@dealer.dealer_bank}$"
    move
  else
    puts 'Игра окончена'
    puts 'Вы проиграли' if @player.player_bank.zero?
    puts 'Вы выйграли' if @dealer.dealer_bank.zero?
    new_game
  end
end

def move
  loop do
    puts "Ваш ход, что хотите выбрать
  1 - Пропустить
  2 - Добавить карту
  3 - Открыть карты
  4 - Завершить игру"
    choice_player = gets.chomp.to_i
    case choice_player
    when 1
      @dealer.dealer_game(@cards)
      open_cards if @player.cards_player.count == 3
    when 2
      @player.player_game(@cards)
      open_cards if @dealer.cards_dealer.count == 3
      break if @dealer.cards_dealer.count == 3
    when 3
      open_cards
      break
    when 4

      exit
    end
  end
end

def open_cards
  puts 'Открываем карты'
  puts "Ваши карты: #{@player.cards_player}, Ваши очки: #{@player.points_player} "
  puts "Карты диллера: #{@dealer.cards_dealer}, Очки диллера: #{@dealer.points_dealer}"
  winner
end

def winner
  if @player.points_player > @dealer.points_dealer && @player.points_player <= 21 || @player.points_player <= 21 && @dealer.points_dealer > 21
    puts "Вы выйграли раздачу, Ваш банк #{@player.player_bank += @rate}$, Диллера банк #{@dealer.dealer_bank -= @rate}$"
  elsif @player.points_player < @dealer.points_dealer || @player.points_player > 21
    puts "Вы проиграли раздачу, Ваш банк #{@player.player_bank -= @rate}$, Диллера банк #{@dealer.dealer_bank += @rate}$"
  else
    @player.points_player == @dealer.points_dealer && @player.points_player <= 21
    puts "Ничья, Ваш банк #{@player.player_bank}$, Диллера банк #{@dealer.dealer_bank}$"
  end
  start_game
end

def new_game
  puts "Хотите сыграть еще раз?
  1 - да
  2 - нет"
  player_answer = gets.chomp.to_i
  if player_answer == 1
    @player = Player.new
    @dealer = Dealer.new
    puts "Началась новая игра. Ставка - #{@rate}"
    start_game
  else
    player_answer == 2
    exit
  end
end

game
