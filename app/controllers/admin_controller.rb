class AdminController < ApplicationController
  
  layout "admin"
  before_filter :authenticate, :except => "login"

  def reset_password
    if user = User.first
      user.password = Digest::MD5.hexdigest(params[:password])
      user.save
    end
    redirect_to admin_overview_path
  end

  def login
  @user = User.new
  if params[:user]
    username = params[:user][:username]
    password = params[:user][:password]
    @user = User.find_by_username_and_password(username, Digest::MD5.hexdigest(password))
    if @user.blank?
      flash[:error] = "No user can be found using this username and password!"
      redirect_to admin_login_path
    else
      session[:user_id] = @user.id
      redirect_to admin_overview_path
    end
  end
  
  end


  def logout
    @user = User.find(session[:user_id])
    @user.last_login = DateTime.now
    @user.save
    session[:user_id] = nil
    redirect_to admin_login_path

  end

  def overview
    @collections = Collection.masters
  end

  def reorder_collection
    collection = Collection.find(params[:id]) rescue nil
    unless collection.blank?
      move = params[:move]

      if move == "0"
        #get masters by nav order
        previous = Collection.masters.by_nav_order(collection.nav_order() -1).first
        unless collection.master_collection.blank?
          previous = Collection.by_nav_order(collection.nav_order() -1).by_master(collection.master_collection).first
        end

        unless previous.blank?
          
          previous.nav_order = collection.nav_order
          collection.nav_order = previous.nav_order() - 1
          previous.save
          collection.save
          
        end
      else
        next_col = Collection.masters.by_nav_order(collection.nav_order() +1).first
        unless collection.master_collection.blank?
          next_col = Collection.by_nav_order(collection.nav_order() +1).by_master(collection.master_collection).first
        end

        unless next_col.blank?
          next_col.nav_order = collection.nav_order
          collection.nav_order = next_col.nav_order() +1
          next_col.save
          collection.save
        end

      end
    end

    respond_to do |format|
      format.html { redirect_to(collection.ismaster? ? admin_overview_path : admin_edit_collection_path(collection.master_collection)) and return }
      format.js  { render :template => "admin/collection_listing" and return }
    end
  end

  def products
    if params[:filter].blank?
      @fireplaces = Product.all
    else
      fps = Product.all
      unless params[:filter] == "All"
        @collection = Collection.find(params[:filter])
        fps = Product.by_collection(@collection)
      end
      
      render :partial => "admin/fireplace_listing", :locals => {:fireplaces => fps} and return
    end
  end

  def banners
    @banners = Homebanner.all.order("show_on_site desc")
  end

  def edit_collection
    if params[:create_child]
      @master_collection = Collection.find(params[:id])
      @collection = Collection.new
    else
      @collection = Collection.find(params[:id]) rescue Collection.new

      if not @collection.master_collection.blank?
        @master_collection = Collection.find(@collection.master_collection)
      end
    end
  end

  def update_collection
    @error = true
    @collection = Collection.find(params[:collection_id]) rescue Collection.new
	masters = Collection.masters.length
	
    @collection.update_attributes(collection_params)
	
    if @collection.new_record? or @collection.nav_order.blank?
	  if @collection.master_collection.blank?
		
        @collection.nav_order = masters + 1
      else
        @collection.nav_order = Collection.by_master(Collection.find(@collection.master_collection)).length + 1
      end
    end
	
	if @collection.save
      @error = false
      flash[:notice] = @collection.name+" saved successfully"
      redirect_to admin_edit_collection_path(:id => @collection) and return
    else
      render :template => "admin/edit_collection" and return
    end
  end

  def delete_collection
    cl = Collection.find(params[:id]) rescue nil
    unless cl.blank?
      Collection.destroy(cl)
      Collection.destroy_all(:master_collection=>cl)
      flash[:notice] = "'"+cl.name+"' and any children have been deleted"
    end

    redirect_to admin_overview_path
  end

  def edit_banner
    @banner = Homebanner.find(params[:id]) rescue Homebanner.new
  end

  def delete_banner
    br = Homebanner.find(params[:id]) rescue nil
	
	unless br.blank?
      Homebanner.destroy(br)
      
	  flash[:notice] = br.name+" has been deleted"
    end

    redirect_to admin_banners_path
  end

  def update_banner
	puts "saving a banner"
    @error = true
	
    @banner = Homebanner.find(params[:banner_id]) rescue Homebanner.new(banner_params)
	
	unless @banner.id.blank?
		puts "updated attributes"
		@banner.update_attributes(banner_params)
	end
	
	begin
		if @banner.save
		  @error = false
		  flash[:notice] = @banner.name+" saved successfully"
		  puts "redirect to banners path"
		  redirect_to admin_banners_path and return
		else
		  render :template => "admin/edit_banner" and return
		end
	rescue Exception => e  
		render :template => "admin/edit_banner" and return
	end
  end

  def edit_fireplace
    @product = Product.find(params[:id]) rescue Product.new(:available_materials => [])
    get_collection_hash
  end

  def delete_fireplace
    pr = Product.find(params[:id]) rescue nil
    unless pr.blank?
      Product.destroy(pr)
      flash[:notice] = pr.name+" has been deleted"
    end

    redirect_to admin_products_path
  end

  def update_fireplace
    @error = true
    @product = Product.find(params[:product_id]) rescue Product.new(:available_materials => [])
	
	puts "try upload FP"
	puts params.inspect
	puts @product.inspect
    
	collections = []
    unless params[:product][:collections].blank?
      params[:product][:collections].each do |id|
        c = Collection.find(id) rescue nil
        collections << c unless c.blank?
      end
    end
	puts "Moving on..."
    params[:product][:collections] = collections
	puts "added collections"
	begin
		@product.update_attributes(product_params)
    rescue Exception => e
		puts "oops!"
		puts e.message
	end
	puts "attempting update?"
	@product.collections = collections
	puts "Saving fireplace "
    begin
		if @product.save
			puts "saved."
			@error = false
			flash[:notice] = @product.name+" saved successfully"
			redirect_to admin_products_path and return
		else
			get_collection_hash
			render :template => "admin/edit_fireplace" and return
		end
	rescue Exception =>e
		puts e.message
		render :template => "admin/edit_fireplace" and return
	end
  end


  #---------------- QUOTES
  def quotes

  end

  def edit_quote
    @quote = Quote.find(params[:id]) rescue Quote.new
  end

  def delete_quote
    q = Quote.find(params[:id]) rescue nil
    unless q.blank?
      Quote.destroy(q)
      flash[:notice] = "Quote has been deleted"
    end

    redirect_to admin_quotes_path
  end

  def update_quote
    @quote = Quote.find(params[:quote_id]) rescue Quote.new
    @quote.attributes = params[:quote]

    if @quote.save
      flash[:notice] = "quote saved successfully"
      redirect_to admin_quotes_path and return
    else
      @quote.errors.each do |e|
        puts e.inspect
      end
      render :template => "admin/edit_quote" and return
    end
  end

  #---------------------- enquiries
  def enquiries
	
    if params[:id]
      @contact = Contact.find(params[:id])
      if @contact
        @contact.viewed = true
        @contact.save
		render :template => "admin/enquiry_show" and return
      else
        flash[:notice] = "No enquiry found?"
      end
    else
      @new_enquiries = Contact.all.where("viewed = ?", false).order("created asc")
      @old_enquiries = Contact.all.where("viewed = ?", true).order("created desc")
    end
  end

  def delete_enquiry
    e = Contact.find(params[:id]) rescue nil
    
    unless e.blank?
      Contact.destroy(e)
      flash[:notice] = "Enquiry has been deleted"
    end

    redirect_to admin_enquiries_path
  end

  private
  def authenticate

    if session[:user_id].blank?
      redirect_to admin_login_path
    end

  end
  
  def banner_params
    params.require(:homebanner).permit(:name, :description, :show_on_site, :image)
  end
  
  def product_params
    params.require(:product).permit(:name, :description, :show_on_site, :available_materials, :featured, :collections, :image)
  end
  
  def collection_params
    params.require(:collection).permit(:master_collection, :name, :description, :show_on_site, :nav_order)
  end

  def get_collection_hash
    collections = Collection.masters
    @collection_hash = {}
    collections.each do |collection|
        if collection.ismaster?
          @collection_hash[collection] = collection.children
        end
    end
  end
end
