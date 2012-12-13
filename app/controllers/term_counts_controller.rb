class TermCountsController < ApplicationController
  # GET /term_counts
  # GET /term_counts.json
  def index
    @term_counts = TermCount.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @term_counts }
    end
  end

  # GET /term_counts/1
  # GET /term_counts/1.json
  def show
    @term_count = TermCount.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @term_count }
    end
  end

  # GET /term_counts/new
  # GET /term_counts/new.json
  def new
    @term_count = TermCount.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @term_count }
    end
  end

  # GET /term_counts/1/edit
  def edit
    @term_count = TermCount.find(params[:id])
  end

  # POST /term_counts
  # POST /term_counts.json
  def create
    @term_count = TermCount.new(params[:term_count])

    respond_to do |format|
      if @term_count.save
        format.html { redirect_to @term_count, notice: 'Term count was successfully created.' }
        format.json { render json: @term_count, status: :created, location: @term_count }
      else
        format.html { render action: "new" }
        format.json { render json: @term_count.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /term_counts/1
  # PUT /term_counts/1.json
  def update
    @term_count = TermCount.find(params[:id])

    respond_to do |format|
      if @term_count.update_attributes(params[:term_count])
        format.html { redirect_to @term_count, notice: 'Term count was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @term_count.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /term_counts/1
  # DELETE /term_counts/1.json
  def destroy
    @term_count = TermCount.find(params[:id])
    @term_count.destroy

    respond_to do |format|
      format.html { redirect_to term_counts_url }
      format.json { head :no_content }
    end
  end
end
