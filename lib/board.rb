require_relative 'board_case'
require_relative 'show'

require 'pry'
require 'colorize'

class Board
  attr_accessor :board, :count_turn, :pos
  def initialize
    @board = []
    @count_turn = 0
    9.times do |i|
      @board << BoardCase.new(i)
    end
  end

  # Cette function gere le tour des deux jouer
  def play_turn(who)
    @count_turn += 1
    print "Joueur #{who.name} c'est votre tour\n>"
    if self.victory?[0] == true
      if who.value == "X"
        i = position(gets.chomp)
        (@board[i].status == " ")? 
        (@board[i].status = "X"): 
        (puts "vous ne pouvez pas placer ici\nVous passez votre tours".colorize(:red))
        sleep 1
        who = 2
      else
        who = 1 
        i =  position(gets.chomp)
        (@board[i].status == " ")? 
        (@board[i].status = "O"): 
        (puts "vous ne pouvez pas placer ici\nVous passez votre tours".colorize(:red))
        sleep 1
      end
    else
      nil
    end
  end

  # Cette function sers a convertir les position
  def position(pos)
    (pos[1].to_i > 3)?(return 0):nil
    if pos[0] == "A"
      return 0 + pos[1].to_i - 1
    elsif pos[0] == "B"
      return 3 + pos[1].to_i - 1
    elsif pos[0] == "C"
      return 6 + pos[1].to_i - 1
    elsif pos.size > 2
      return 0
    else
      return 0    
    end
  end

   # Cette function determine si les condition de victoire on estait atteind
  def victory?
    i = 0
    c = 0
    nul = ""
    ret = true
    ret2 = true
    
    while c < 3
      str = ""
      @board.values_at(0 + c, 3 + c, 6 + c).each { |w|  str.concat(w.status)}
      (str == "XXX" || str == "OOO")? (ret2 = false) : (ret2 = true)
      c += 1
      (ret2 == false)? (c = 3):nil
    end
    if @board.values_at(0, 1, 2).to_s.count("X") == 3
      return [false, "X"]
    end
    if @board.values_at(0, 1, 2).to_s.count("O") == 3
      return [false, "O"]
    end
    if @board.values_at(3, 4, 5).to_s.count("X") == 3
      return [false, "X"]
    end
    if @board.values_at(3, 4, 5).to_s.count("O") == 3
      return [false, "O"]
    end
    if @board.values_at(6, 7, 8).to_s.count("X") == 3
      return [false, "X"]
    end
    if @board.values_at(6, 7, 8).to_s.count("O") == 3
      return [false, "O"]
    end
    if @board.values_at(0, 4, 8).to_s.count("X") == 3
      ret = false
      str = "X"
    end
    if @board.values_at(0, 4, 8).to_s.count("O") == 3
      ret = false
      str = "O"
    end
    if @board.values_at(2, 4, 6).to_s.count("X") == 3
      ret = false
      str = "X"
    end
    if @board.values_at(2, 4, 6).to_s.count("O") == 3
      ret = false
      str = "O"
    end
    @board.each{ |c| nul.concat(c.status) }
    if nul.count(" ") == 0
      ret = false
      str = "nul"
    end
    (ret == false || ret2 == false )? 
    (return [false, str[0]]): 
    (return [true, "nil"])
  end
end
