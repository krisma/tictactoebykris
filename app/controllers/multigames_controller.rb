class MultigamesController < ApplicationController
  before_action :set_multigame, only: [:show, :edit, :update, :destroy, :mmove, :add_player, :check_players]

  # GET /multigames
  # GET /multigames.json
  def index
    @multigames = Multigame.all
  end

  # GET /multigames/1
  # GET /multigames/1.json
  def show
  end

  # GET /multigames/new
  def new
    @multigame = Multigame.new
  end

  # GET /multigames/1/edit
  def edit
  end

  def mmove
    flash[:notice] = "aa"
    if insufficient_player
      flash[:notice] = "Players not ready!"
    end
    cur = @multigame.status[@multigame.turn * 9, 9]
    if not your_turn
      flash[:notice] = "Please wait for your opponent"
    elsif ok_to_move(cur)
        
        if @multigame.turn >= 9 or check_win(cur)
          flash[:notice] = "Game over"
          respond_to do |format|
            format.html { redirect_to @multigame }
          end
          return
        end
        if @multigame.turn % 2 == 0
          player = "A"
        else
          player = "B"
        end

        i = params[:cell_id].to_i
        if cur[i-1, 1].to_i == 0 
          cur[i-1, 1] = player
          @multigame.status += cur
          @multigame.turn += 1
          @multigame.save

          if check_win(cur)
            flash[:notice] = "Winner: Player " + player
            #flash[:notice] = @singlegame.status
          elsif not cur.include? "0" 
            flash[:notice] = "Draw"
          end
          if @multigame.id == @multigame.player1_id
            forward_id = @multigame.player2_id
          else
            forward_id = @multigame.player1_id
          end
          @forward = Multigame.find(forward_id)
          @forward.status += cur
          @forward.turn += 1
          @forward.save
        end
      else
        flash[:notice] = "Just refreshed, please try again!"
    end


    respond_to do |format|
      format.html { redirect_to @multigame }
    end  

  end

  def add_player
    if params[:multigame][:player1]
      @multigame.player1 = params[:multigame][:player1]
      @multigame.player1_id = @multigame.id

      @multigame2 = Multigame.new 
      @multigame2.status = "000000000"
      @multigame2.turn = 0
      @multigame2.player1 = @multigame.player1
      @multigame2.player1_id = @multigame.id
      @multigame2.save
      @multigame.player2_id = @multigame2.id

      @multigame.save
      @multigame2.player2_id = @multigame2.id
      @multigame2.save
    elsif params[:multigame][:player2]
      @origin = Multigame.find(@multigame.player1_id)
      @multigame.player2 = params[:multigame][:player2]
      @multigame.player2_id = @multigame.id
      @multigame.save
      @origin.player2 = @multigame.player2
      @origin.save
    end
    respond_to do |format|
      format.html { redirect_to @multigame }
    end
  end

  # POST /multigames
  # POST /multigames.json
  def create
    @multigame = Multigame.new(multigame_params)

    respond_to do |format|
      if @multigame.save
        format.html { redirect_to @multigame, notice: 'Multigame was successfully created.' }
        format.json { render :show, status: :created, location: @multigame }
      else
        format.html { render :new }
        format.json { render json: @multigame.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /multigames/1
  # PATCH/PUT /multigames/1.json
  def update
    respond_to do |format|
      if @multigame.update(multigame_params)
        format.html { redirect_to @multigame, notice: 'Multigame was successfully updated.' }
        format.json { render :show, status: :ok, location: @multigame }
      else
        format.html { render :edit }
        format.json { render json: @multigame.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /multigames/1
  # DELETE /multigames/1.json
  def destroy
    @multigame.destroy
    respond_to do |format|
      format.html { redirect_to multigames_url, notice: 'Multigame was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_multigame
      @multigame = Multigame.find(params[:id])
    end

    def insufficient_player
      return @multigame.player1.nil? | @multigame.player2.nil?
    end

    def your_turn
      if @multigame.turn % 2 == 0
        if @multigame.id == @multigame.player1_id
          return true
        end
      else
        if @multigame.id == @multigame.player2_id
          return true
        end
      end
      return false
    end
    def ok_to_move(cur)
      return cur[params[:cell_id].to_i-1]=="0"
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def multigame_params
      params.require(:multigame).permit(:status, :turn, :player1, :player2)
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
