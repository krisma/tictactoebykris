class SinglegamesController < ApplicationController
  before_action :set_singlegame, only: [:show, :edit, :update, :destroy, :move]

  # GET /singlegames
  # GET /singlegames.json
  def index
    @singlegames = Singlegame.all
  end

  # GET /singlegames/1
  # GET /singlegames/1.json
  def show
  end

  # GET /singlegames/new
  def new
    @singlegame = Singlegame.new
  end

  # GET /singlegames/1/edit
  def edit
  end

  # POST /singlegames
  # POST /singlegames.json
  def create
    @singlegame = Singlegame.new(singlegame_params)
    respond_to do |format|
      if @singlegame.save
        format.html { redirect_to @singlegame, notice: 'Singlegame was successfully created.' }
        format.json { render :show, status: :created, location: @singlegame }
      else
        format.html { render :new }
        format.json { render json: @singlegame.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /singlegames/1
  # PATCH/PUT /singlegames/1.json
  def update
    respond_to do |format|
      if @singlegame.update(singlegame_params)
        format.html { redirect_to @singlegame, notice: 'Singlegame was successfully updated.' }
        format.json { render :show, status: :ok, location: @singlegame }
      else
        format.html { render :edit }
        format.json { render json: @singlegame.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /singlegames/1
  # DELETE /singlegames/1.json
  def destroy
    @singlegame.destroy
    respond_to do |format|
      format.html { redirect_to singlegames_url, notice: 'Singlegame was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def move
    cur = @singlegame.status[@singlegame.turn * 9, 9]
    if @singlegame.turn >= 9 or check_win(cur)
      flash[:notice] = "Game over"
      respond_to do |format|
        format.html { redirect_to @singlegame }
      end
      return
    end
    if @singlegame.turn % 2 == 0
      player = "A" 

    else
      player = "B"
    end
    
    i = params[:cell_id].to_i
    if cur[i-1, 1].to_i == 0 
      cur[i-1, 1] = player
      @singlegame.status += cur
      @singlegame.turn += 1
      @singlegame.save

      if check_win(cur)
        flash[:notice] = "Winner: Player " + player
      #flash[:notice] = @singlegame.status
    else if not cur.include? "0" 
      flash[:notice] = "Draw"
    end 

  end
end
respond_to do |format|
  format.html { redirect_to @singlegame }
end
end

private
    # Use callbacks to share common setup or constraints between actions.
    def set_singlegame
      @singlegame = Singlegame.find(params[:id])
    end

    def check_win(cur)
      if (cur =~ /A..A..A..|.A..A..A.|..A..A..A|B..B..B..|.B..B..B.|..B..B..B
        |AAA......|...AAA...|......AAA|BBB......|...BBB...|......BBB|A...A...A|B...B...B|..A.A.A..|..B.B.B../)
      return true
    else
      return false
    end
  end

    # Never trust parameters from the scary internet, only allow the white list through.
    def singlegame_params
      params.require(:singlegame).permit(:status, :turn)
    end
  end
