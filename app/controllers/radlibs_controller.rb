class RadlibsController < ApplicationController
  load_and_authorize_resource

  def index
    @radlibs = Radlib.all
  end

  def show
  end

  def new
  end

  def create
    @radlib.user = current_user

    if @radlib.save
      redirect_to @radlib, notice: 'Radlib was successfully created.'
    else
      render "new"
    end
   end

  def destroy
    @radlib.destroy
    redirect_to radlibs_url
  end


  def vote
    value = params[:type] == "up" ? 1 : -1
    @radlib = Radlib.find(params[:id])
    @radlib.add_or_update_evaluation(:votes, value, current_user)
    redirect_to :back, notice: "Thank you for voting."
  end
end
