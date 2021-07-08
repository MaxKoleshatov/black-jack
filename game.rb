# frozen_string_literal: true

@cards_all = { "2+": 2, "2<3": 2, "2^": 2, "2<>": 2, "3+": 3, "3<3": 3, "3^": 3, "3<>": 3, "4+": 4, "4<3": 4, "4^": 4, "4<>": 4, "5+": 5, "5<3": 5, "5^": 5, "5<>": 5, "6+": 6, "6<3": 6, "6^": 6, "6<>": 6, "7+": 7, "7<3": 7, "7^": 7, "7<>": 7,
               "8+": 8, "8<3": 8, "8^": 8, "8<>": 8, "9+": 9, "9<3": 9, "9^": 9, "9<>": 9,
               "10+": 10, "10<3": 10, "10^": 10, "10<>": 10, "B+": 10, "B<3": 10, "B^": 10, " B<>": 10,
               "D+": 10, "D<3": 10, "D^": 10, "D<>": 10, "K+": 10, "K<3": 10, "K^": 10, "K<>": 10,
               "A+": 11, "A<3": 11, "A^": 11, "A<>": 11 }

def cards_player
  cards_player_arr = []
  @cards_all.each do |cards, _volume|
    cards_player_arr << cards
  end
  @cards_player = 2.times.map { cards_player_arr.sample.to_s }
end

def cards_dealer
  cards_dealer = []
  @cards_all.each do |cards, _volume|
    cards_dealer << cards
  end
  @cards_dealer = 2.times.map { cards_dealer.sample }
end

def points_player
  points_player = 0

  @cards_player.each do |card|
    points_player += @cards_all[card.to_s.to_sym]
    points_player -= 10 if points_player > 21 && @cards_player.join('').include?('A')
  end
  points_player
end

def points_dealer
  points_dealer = 0
  @cards_dealer.each do |card|
    points_dealer += @cards_all[card.to_s.to_sym]
  end
  points_dealer
end

# Добавить одну карту игроку
def add_card_player
  cards_player_arr = []
  @cards_all.each do |cards, _volume|
    cards_player_arr << cards
  end
  @cards_player_one = 1.times.map { cards_player_arr.sample.to_s }
end

# Добавить одну карту диллеру
def add_card_dealer
  cards_dealer_arr = []
  @cards_all.each do |cards, _volume|
    cards_dealer_arr << cards
  end
  @cards_dealer_one = 1.times.map { cards_dealer_arr.sample.to_s }
end

def dealer_game
  if points_dealer < 17
    if @cards_dealer.count != 3
      cards_new_dealer = []
      @cards_dealer.push(add_card_dealer.join).each do |card|
        cards_new_dealer << card
      end
      puts 'Диллер взял себе еще карту'
    else
      puts 'Диллер не может брать больше одной карты за раздачу'
    end
  elsif points_dealer >= 17
    puts 'Диллер не взял карту'
  end
end

def player_game
  if @cards_player.count != 3
    cards_new_player = []
    @cards_player.push(add_card_player.join).each { |card| cards_new_player << card }
    puts "Выпала карта: #{@cards_player_one}"
    puts "Ваши новые карты: #{cards_new_player}"
    puts "Ваши очки: #{points_player}"
    dealer_game
  else
    puts 'Вы не можете брать больше одной карты за раздачу'
  end
end

def open_cards
  puts "Ваши карты: #{cards_new_player ||= @cards_player}, Ваши очки: #{points_player} "
  puts "Карты диллера: #{cards_new_dealer ||= @cards_dealer}, Очки диллера: #{points_dealer}"
  winner
end

def winner
  if points_player > points_dealer && points_player <= 21 || points_player <= 21 && points_dealer > 21
    puts "#{@player_name}, Вы победили"
    puts "В вашем банке: #{@player_bank += 10}$, В банке диллера #{@dealer_bank -= 10}$"
  elsif points_player == points_dealer
    puts 'Ничья'
    puts "В вашем банке: #{@player_bank}$, В банке диллера #{@dealer_bank}$"
  else
    points_player < points_dealer || points_player > 21
    puts 'Вы проиграли раздачу'
    puts "В вашем банке: #{@player_bank -= 10}$, В банке диллера #{@dealer_bank += 10}$"
  end
end

def step_game
  @player_bank ||= 100
  @dealer_bank ||= 100

  loop do
    if @player_bank.zero? || @dealer_bank.zero?
      puts 'Вы проиграли игру' if @player_bank.zero?
      puts 'Вы выйграли игру' if @dealer_bank.zero?
      @player_bank = 100 && @dealer_bank = 100
      start_new_game
    else
      puts "Ставка 10$. В вашем банке: #{@player_bank - 10}$, В банке диллера #{@dealer_bank - 10}$"
      puts "Началась раздача. Ваши карты: #{cards_player},  Карты диллера **"
      cards_dealer
      puts "Ваши очки #{points_player}"
      points_dealer
    end
    choice_player = 0
    while choice_player != 3
      puts "Ваш ход, что хотите выбрать
        1 - Пропустить
        2 - Добавить карту
        3 - Открыть карты
        4 - Завершить игру"
      choice_player = gets.chomp.to_i
      case choice_player
      when 1
        dealer_game
      when 2
        player_game
        open_cards if @cards_dealer.count == 3
        break if @cards_dealer.count == 3
      when 3
        open_cards
      else
        choice_player == 4
        exit
      end
    end
  end
end

puts 'Здравствуйте! Как ваше имя?'
@player_name = gets.chomp

def start_game
  puts 'Началась новая игра!!!'
  step_game
  if @player_bank.zero? || @dealer_bank.zero?
    start_new_game
  else
    winner
  end
end

def start_new_game
  puts " Хотите сыграть еще раз?
    1 - Да
    2 - Нет"
  player_answer = gets.chomp.to_i
  if player_answer == 1
    start_game
  else
    exit
  end
end

def off_game
  puts 'Игра закончилась'
end

loop do
  puts "#{@player_name}, Желаете сыграть?
1 - Да
2 - Нет"

  player_answer = gets.chomp.to_i

  case player_answer
  when 1
    start_game
    break

  when 2
    off_game
    break

  else
    puts 'Неверный ввод'
  end
end
