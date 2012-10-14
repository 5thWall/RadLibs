class TemplatesController < ApplicationController

  def index
    @templates = Template.find(:all, :order => "created_at desc")
  end

  def show
    @template = Template.find(params[:id])
  end

  def new
    if user_signed_in?
      @template = Template.new
    else
      redirect_to templates_path
    end
  end

  def create
  	@user = current_user
    @template = Template.new(params[:template])

      if @template.save
      @user.templates << @template
         redirect_to @template, notice: 'Template was successfully created.'
      else
        render "new"
      end
   end

  def destroy
    @template = Template.find(params[:id])
    @template.destroy
  	redirect_to templates_url
  end


  def vote
  	value = params[:type] == "up" ? 1 : -1
  	@template = Template.find(params[:id])
    @template.add_evaluation(:votes, value, current_user)
    redirect_to :back, notice: "Thank you for voting."
  end
end
