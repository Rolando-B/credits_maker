class StreamersController < ApplicationController
  def new
    @streamer = Streamer.new
  end

  def index
    @streamers = Streamer.all
  end

  def credits
    @streamers = Streamer.all
    respond_to do |format|
      format.html
      format.json { render :json => @streamers }
    end
  end

  def create
    @streamer = Streamer.new(streamer_params)
    if @streamer.save
      flash[:success] = "Successfully added !"
      redirect_to :action => 'new'
    else
      render :action => 'new'
    end
  end

  def createJson
    @streamer = Streamer.new(streamer_params)
    respond_to do |format|
      format.json do
        if @streamer.save
          render :json => @streamer
        else
          render :json => { :errors => @streamer.errors.messages }, :status => 422
        end
      end
    end
  end

  def updateJson
    @streamer = Streamer.find(params[:id])
    respond_to do |format|
      format.json do
        if @streamer.update(streamer_params)
          render :json => @streamer
        else
          render :json => { :errors => @streamer.errors.messages }, :status => 422
        end
      end
    end
  end

  def destroyJson
    Streamer.find(params[:id]).destroy
    respond_to do |format|
      format.json { render :json => {}, :status => :no_content }
    end
  end

  def destroy
    Streamer.find(params[:id]).destroy
    flash[:success] = "Streamer deleted"
    redirect_to streamers_url
  end

  def show
    @streamer = Streamer.find(params[:id])
  end

  def edit
    @streamer = Streamer.find(params[:id])
  end

  def update
    @streamer = Streamer.find(params[:id])
    if @streamer.update_attributes(streamer_params)
      flash[:success] = "Streamer updated"
      redirect_to @streamer
    else
      render 'edit'
    end
  end

  private

    def streamer_params
      params.require(:streamer).permit(:name, :twitch, :youtube)
    end
end
