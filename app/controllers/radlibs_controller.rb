class RadlibsController < ApplicationController
  # GET /radlibs
  # GET /radlibs.json
  def index
    @radlibs = Radlib.find(:all, :order => "created_at desc")
  end

  # GET /radlibs/1
  # GET /radlibs/1.json
  def show
    @radlib = Radlib.find(params[:id])
  end

  # GET /radlibs/new
  # GET /radlibs/new.json
  def new
    redirect_to root_url, alert: 'Please log in before doing that' unless current_user

    @template = Template.find params[:template_id]
    @radlib = @template.radlibs.build
  end

  # GET /radlibs/1/edit
  def edit
    redirect_to radlibs_path
  end

  # POST /radlibs
  # POST /radlibs.json
  def create
    redirect_to root_url, alert: "Please log in before doing that" unless current_user

    @radlib = Radlib.new(params[:radlib])

    if @radlib.save
    current_user.radlibs << @radlib
      redirect_to template_path(@radlib.template), notice: 'Radlib was successfully created.'
    else
      render action: "new"
    end
  end

  # PUT /radlibs/1
  # PUT /radlibs/1.json
  def update
    @radlib = Radlib.find(params[:id])

    if @radlib.update_attributes(params[:radlib])
      redirect_to @radlib, notice: 'Radlib was successfully updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /radlibs/1
  # DELETE /radlibs/1.json
  def destroy
    @radlib = Radlib.find(params[:id])
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
