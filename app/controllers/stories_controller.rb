class StoriesController < ApplicationController
  load_and_authorize_resource

  def index
    @stories = Story.all
  end

  def show
    @story = Story.find(params[:id])
  end

  def new
    @story.radlib = Radlib.find params[:radlib_id]
  end

  def create
    @story.user = current_user

    if @story.save
      redirect_to radlib_path(@story.radlib), notice: 'Story was successfully created.'
    else
      render :new
    end
  end

  def update
    if @story.update_attributes(params[:story])
      redirect_to @story, notice: 'Story was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @story.destroy
    redirect_to stories_url
  end

  def vote
  	value = params[:type] == "up" ? 1 : -1
    @story.add_or_update_evaluation(:votes, value, current_user)
    redirect_to :back, notice: "Thank you for voting."
  end
end
