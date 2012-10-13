class TemplatesController < ApplicationController
  # GET /templates
  # GET /templates.json
  def index
    @templates = Template.all

  end

  # GET /templates/1
  # GET /templates/1.json
  def show
    @template = Template.find(params[:id])


  end

  # GET /templates/new
  # GET /templates/new.json
  def new
  if user_signed_in?
    @template = Template.new
  else
  redirect_to templates_path
  end

  end

  # GET /templates/1/edit
  def edit
    @template = Template.find(params[:id])
  end

  # POST /templates
  # POST /templates.json
  def create
    @template = Template.new(params[:template])

      if @template.save
         redirect_to @template, notice: 'Template was successfully created.'
      else
        render "new"
      end
   end


  # PUT /templates/1
  # PUT /templates/1.json
  def update
    @template = Template.find(params[:id])

   
      if @template.update_attributes(params[:template])
        redirect_to @template, notice: 'Template was successfully updated.' 
       
      else
        render "edit" 
     
      end
    end

  # DELETE /templates/1
  # DELETE /templates/1.json
  def destroy
    @template = Template.find(params[:id])
    @template.destroy

	redirect_to templates_url
    end

  
  def vote
  	value = params[:type] == "up" ? 1 : -1
  	@template = Template.find(params[:id])
    @template.add_evaluation(:votes, :value, current_user)
 
      redirect_to :back, notice: "Thank you for voting."
  end
end
