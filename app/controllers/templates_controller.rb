class TemplatesController < ApplicationController
  load_and_authorize_resource

  def index
    @templates = Template.find(:all, :order => "created_at desc")
  end

  def show
  end

  def new
  end

  def create
    @template.user = current_user

    if @template.save
      redirect_to @template, notice: 'Template was successfully created.'
    else
      render "new"
    end
   end

  def destroy
    @template.destroy
    redirect_to templates_url
  end


  def vote
    value = params[:type] == "up" ? 1 : -1
    @template = Template.find(params[:id])
    @template.add_or_update_evaluation(:votes, value, current_user)
    redirect_to :back, notice: "Thank you for voting."
  end
end
