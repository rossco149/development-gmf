class SiteController < ApplicationController

  before_filter :active_page, :get_collections, :get_featured#, :display_quotes
  def index
      unless params[:missing].blank?
        missing = params[:missing][0].downcase
        if missing.include? 'gallery'
          redirect_to '/site/gallery'
          return
        elsif missing.include? 'advice'
          redirect_to '/site/advice'
          return
        elsif missing.include? 'contact'
          redirect_to '/site/contact'
          return
        end
        redirect_to '/'
      end
      @banners = Homebanner.on_site(true).limit(5)
  end


  def mark
  
  end

  def fireplace_image
    fireplace = Product.find(params[:id])
    image_data = params[:size] == "small" ? fireplace.small_image : fireplace.large_image

    send_data(image_data, :type => fireplace.image_type,
                      :stream => false,
                     :disposition => 'inline')
  end

  def gallery
    unless params[:type].blank?
      type = params[:type]
      @collection = Collection.find(type) rescue nil
      @featured = params[:featured].to_i unless params[:featured].blank?
      if @collection and @collection.show_on_site and @collection.children().on_site(true).length > 0
        render :template => "site/gallery_sub_level" and return
      elsif @collection and @collection.show_on_site and @collection.products.length > 0
          @products = Product.by_collection(@collection).paginate(:page => params[:page], :per_page => 12)

          render :template => "site/gallery_listing" and return
      end
    end
    
  end

  def gallery_show
    @product = Product.find(params[:id], :conditions=>["show_on_site=?",true]) rescue nil
  end

  #def gallery
  #  unless params[:type].blank?
  #    type = params[:type]
  #    material = Fireplace::MATERIALS[type]

  #    @fireplaces = Fireplace.by_material(material)
  #    @filter = material
  #    @featured = params[:featured].to_i unless params[:featured].blank?
  #    render :template => "site/gallery_listing" and return
  #  end
    
  #end

  #def clients
  #end

  #def whatpeoplesay
  #  @quotes = Quote.find(:all, :conditions => ["show_on_site = ?", true], :order=>"quote_type")
  #end

  def advice
  end

  def contact
    @show = params[:show]
    @product = Product.find(params[:product]) rescue nil
    @contact = Contact.new
    @contact.textcaptcha
    
    unless params[:contact].blank?

      @contact.attributes = params[:contact]
      @contact.created = DateTime.now
      if @contact.save
        @show = nil
        @contact = Contact.new
        flash[:notice] = "Thank you for your enquiry, we will repond to you as soon as possible"
      else
        @show = "form"
      end
    end
  end

  private

  def display_quotes
    @trade_quote = Quote.by_type("trade").first
    @private_quote = Quote.by_type("private").first
  end

  def active_page
    @active_path = params[:action]
    @page_title = params[:action]
    @page_title = "What People Say About us" if @page_title == "whatpeoplesay"
    @page_title = "home" if @page_title == "index"

    if @active_path == "gallery"
      page = Collection.find(params[:type]) rescue nil
      unless page.blank?
        @description = page.description
        @page_title = page.display_name
      end
    elsif @active_path == "gallery_show"
      page = Product.find(params[:id]) rescue nil
      unless page.blank?
        @description = page.description
        @page_title = page.name
      end
     end

    if @description.blank?
        @description = "George McAlpine has been a family business crafting and installing fireplaces for both builder and public alike. In this time we have established an excellent reputation for our high standard of workmanship."
    end
  end

  def get_collections
    @collections = Collection.masters.on_site(true).with_children().uniq
  end

  def get_featured
     @featured = Product.featured_by_amount(2)
  end
end
