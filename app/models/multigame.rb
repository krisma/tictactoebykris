class Multigame < ActiveRecord::Base
	def heading
	cur = self.status[self.turn * 9, 9]
      if self.turn % 2 == 0
        player = self.player2
      else
        player = self.player1
      end
      if check_win(cur)
        return "Winner: " + player
     
      #flash[:notice] = @singlegame.status
      elsif not cur.include? "0" 
        return "Draw"
      end 
      return "Tic-Tac-Toe"
    end

    def check_win(cur)
      if (cur =~ /A..A..A..|.A..A..A.|..A..A..A|B..B..B..|.B..B..B.|..B..B..B
        |AAA......|...AAA...|......AAA|BBB......|...BBB...|......BBB|A...A...A|B...B...B|..A.A.A..|..B.B.B../)
      return true
    else
      return false
    end
end
end
