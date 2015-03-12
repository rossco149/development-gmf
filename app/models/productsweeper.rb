class Productsweeper < ActionController::Caching::Sweeper
  observe Product # This sweeper is going to keep an eye on the Homeproduct model

  # If our sweeper detects that a product was created call this
  def after_create(product)
    expire_cache_for(product)
  end

  # If our sweeper detects that a product was updated call this
  def after_update(product)
    expire_cache_for(product)
    print "product sweeper!"
  end

  # If our sweeper detects that a product was deleted call this
  def after_destroy(product)
    expire_cache_for(product)
  end

  private
  def expire_cache_for(product)
    # Expire the index page now that we added a new product
    product.collections.each do |cl|
      expire_page(:controller => 'site', :action => 'gallery', :type=>cl.id)
    end
    expire_page(:controller => 'site', :action => 'gallery')
    expire_page(:controller => 'site', :action => 'gallery_show', :id=>product.id)

  end
end