class ToppingsController < ApplicationController
  before_filter :require_user
  # GET /toppings
  # GET /toppings.xml
  def index
    @pizza = Pizza.find(params[:pizza_id])
    @toppings = @pizza.toppings

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @toppings }
    end
  end

  # GET /toppings/1
  # GET /toppings/1.xml
  def show
    @topping = Topping.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @topping }
    end
  end

  # GET /toppings/new
  # GET /toppings/new.xml
  def new
    @topping = Topping.new
    @pizza = Pizza.find(params[:pizza_id])

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @topping }
    end
  end

  # GET /toppings/1/edit
  def edit
    @topping = Topping.find(params[:id])
  end

  # POST /toppings
  # POST /toppings.xml
  def create
    @topping = Topping.new(params[:topping])
    @topping.pizza_id = params[:pizza_id]

    respond_to do |format|
      if @topping.save
        flash[:notice] = 'Topping was successfully created.'
        format.html { redirect_to(pizza_path(params[:pizza_id])) }
        format.xml  { render :xml => @topping, :status => :created, :location => @topping }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @topping.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /toppings/1
  # PUT /toppings/1.xml
  def update
    @topping = Topping.find(params[:id])

    respond_to do |format|
      if @topping.update_attributes(params[:topping])
        flash[:notice] = 'Topping was successfully updated.'
        format.html { redirect_to(@topping) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @topping.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /toppings/1
  # DELETE /toppings/1.xml
  def destroy
    @topping = Topping.find(params[:id])
    @topping.destroy

    respond_to do |format|
      flash[:notice] = 'Topping removed from the pizza.'
      format.html { redirect_to(pizza_toppings_url(Pizza.find(params[:pizza_id]))) }
      format.xml  { head :ok }
    end
  end
end
