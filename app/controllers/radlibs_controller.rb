class RadlibsController < ApplicationController
  # GET /radlibs
  # GET /radlibs.json
  def index
    @radlibs = Radlib.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @radlibs }
    end
  end

  # GET /radlibs/1
  # GET /radlibs/1.json
  def show
    @radlib = Radlib.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @radlib }
    end
  end

  # GET /radlibs/new
  # GET /radlibs/new.json
  def new
    @radlib = Radlib.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @radlib }
    end
  end

  # GET /radlibs/1/edit
  def edit
    @radlib = Radlib.find(params[:id])
  end

  # POST /radlibs
  # POST /radlibs.json
  def create
    @radlib = Radlib.new(params[:radlib])

    respond_to do |format|
      if @radlib.save
        format.html { redirect_to @radlib, notice: 'Radlib was successfully created.' }
        format.json { render json: @radlib, status: :created, location: @radlib }
      else
        format.html { render action: "new" }
        format.json { render json: @radlib.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /radlibs/1
  # PUT /radlibs/1.json
  def update
    @radlib = Radlib.find(params[:id])

    respond_to do |format|
      if @radlib.update_attributes(params[:radlib])
        format.html { redirect_to @radlib, notice: 'Radlib was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @radlib.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /radlibs/1
  # DELETE /radlibs/1.json
  def destroy
    @radlib = Radlib.find(params[:id])
    @radlib.destroy

    respond_to do |format|
      format.html { redirect_to radlibs_url }
      format.json { head :no_content }
    end
  end
end
