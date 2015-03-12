ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.


  map.gallery "site/gallery", :controller => "site", :action=>"gallery"
  map.gallery_show "site/gallery_item/:id", :controller => "site", :action=>"gallery_show"
  map.gallery_type "site/gallery/:type", :controller => "site", :action=>"gallery"
  map.gallery_type_featured "site/gallery/:type/:featured", :controller => "site", :action=>"gallery"
  map.clients "site/clients", :controller => "site", :action=>"clients"
  map.advice "site/advice", :controller => "site", :action=>"advice"
  map.what_people_say "site/what_people_say", :controller => "site", :action=>"whatpeoplesay"
  map.contact "site/contact", :controller => "site", :action=>"contact"
  map.contact_product "site/contact/:product", :controller => "site", :action=>"contact"

  map.fireplace_image "images/:id/:size/image.gif", :controller => "site", :action => "fireplace_image"

  #admin sections-----------------
  map.admin_login "admin", :controller => "admin", :action=>"login"
  map.admin_login "admin/login", :controller => "admin", :action=>"login"
  map.admin_logout "admin/logout", :controller => "admin", :action=>"logout"
  map.admin_overview "admin/overview", :controller => "admin", :action=>"overview"
  map.admin_banner "admin/banners", :controller => "admin", :action=>"banners"

  #banners
  map.admin_edit_banner "admin/edit_banner/:id/", :controller => "admin", :action=>"edit_banner"
  map.admin_delete_banner "admin/delete_banner/:id", :controller => "admin", :action=>"delete_banner"
  map.admin_update_banner '/banner/save', :controller => "admin", :action => "update_banner", :conditions => {:method => :post}


  #collections
  map.admin_edit_collection "admin/edit_collection/:id/", :controller => "admin", :action=>"edit_collection"
  map.admin_delete_collection "admin/delete_collection/:id", :controller => "admin", :action=>"delete_collection"
  map.admin_create_child_category "admin/edit_collection/:id/create_sub", :create_child=>true, :controller => "admin", :action=>"edit_collection"
  map.admin_update_collection '/collection/save', :controller => "admin", :action => "update_collection", :conditions => {:method => :post}
  map.admin_update_order '/collection/order/:id/:move', :controller => "admin", :action => "reorder_collection"

  #fireplaces/products
  map.admin_products "admin/products", :controller => "admin", :action=>"products"
  map.admin_edit_fireplace "admin/edit_fireplace", :controller => "admin", :action=>"edit_fireplace"
  map.admin_delete_fireplace "admin/delete_fireplace/:id", :controller => "admin", :action=>"delete_fireplace"
  map.admin_update_fireplace '/fireplace/save', :controller => "admin", :action => "update_fireplace", :conditions => {:method => :post}

  #enquiries
  map.admin_enquiries "admin/enquiries", :controller => "admin", :action=>"enquiries"
  map.admin_enquiries_show "admin/enquiries/:id", :controller => "admin", :action=>"enquiries"
  map.admin_delete_enquiry "admin/delete_enquiry/:id", :controller => "admin", :action=>"delete_enquiry"

  #quotes - not currently used
  map.admin_quotes "admin/quotes", :controller => "admin", :action=>"quotes"
  map.admin_edit_quote "admin/edit_quote", :controller => "admin", :action=>"edit_quote"
  map.admin_delete_quote "admin/delete_quote/:id", :controller => "admin", :action=>"delete_quote"
  map.admin_update_quote '/quote/save', :controller => "admin", :action => "update_quote", :conditions => {:method => :post}

  map.admin_password_reset '/password_reset', :controller => "admin", :action => "reset_password", :conditions => {:method => :post}


  map.mark '/mark', :controller => 'site', :action=>'mark'

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'

  map.root :controller => "site", :only => :index

  map.missing "*missing", :controller => 'site', :action=>'index'

end
