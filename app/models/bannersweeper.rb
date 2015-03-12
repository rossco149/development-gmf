class Bannersweeper < ActionController::Caching::Sweeper
  observe Homebanner # This sweeper is going to keep an eye on the Homebanner model

  # If our sweeper detects that a Homebanner was created call this
  def after_create(banner)
    expire_cache_for(banner)
  end

  # If our sweeper detects that a Homebanner was updated call this
  def after_update(banner)
    expire_cache_for(banner)
    print "banner sweeper!"
  end

  # If our sweeper detects that a Homebanner was deleted call this
  def after_destroy(banner)
    expire_cache_for(banner)
  end

  private
  def expire_cache_for(banner)
    # Expire the index page now that we added a new banner
    print "expire page..."
    expire_page(:controller => 'site', :action => 'index')
  end
end