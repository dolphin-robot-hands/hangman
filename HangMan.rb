
class HangMan
  def initialize(word)
    @word = word
    @board = ""
  end

  def generate_board
    @word.length.times {@board += '-'}
  end

  def correct_guess(guess, word)
    if word.index(guess)
      return true
    end
    return false
  end

  def victory(word, board)
    if board.index(word)
      return true
    end
    return false
  end

  def modify_board(guess, word, board)
    i = 0
    word.each_char do |e|
      if e == guess
        board[i] = e
      end
      i += 1
    end
    return board
  end

  def board
    return @board
  end
end
