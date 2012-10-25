class RadlibsController < ApplicationController
  load_and_authorize_resource

  def index
    @radlibs = Radlib.all
  end

  def show
    @radlib = Radlib.find(params[:id])
  end

  def new
    @radlib.template = Template.find params[:template_id]
  end

  def create
    @radlib.user = current_user

    if @radlib.save
      redirect_to template_path(@radlib.template), notice: 'Radlib was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    if @radlib.update_attributes(params[:radlib])
      redirect_to @radlib, notice: 'Radlib was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @radlib.destroy
    redirect_to radlibs_url
  end

  def vote
  	value = params[:type] == "up" ? 1 : -1
    @radlib.add_or_update_evaluation(:votes, value, current_user)
    redirect_to :back, notice: "Thank you for voting."
  end
end
