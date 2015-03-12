Rails.application.routes.draw do
  
  get "site/gallery" => "site#gallery"
  get "site/gallery_item/:id" => "site#gallery_show"
  get "site/gallery/:type" => "site#gallery"
  get "site/gallery/:type/:featured" => "site#gallery"
  get "site/clients" => "site#clients"
  get "site/advice" => "site#advice"
  get "site/what_people_say" => "site#whatpeoplesay"
  get "site/contact" => "site#contact"
  post "site/contact" => "site#contact"
  get "site/contact/:product" => "site#contact"
  post "site/contact/:product" => "site#contact"

  get "images/:id/:size/image.gif" => "site#fireplace_image"

  #admin sections-----------------
  get "admin" => "admin#login"
  get "admin/login" => "admin#login"
  post "admin/login" => "admin#login"
  get "admin/logout" => "admin#logout"
  get "admin/overview" => "admin#overview"
  get "admin/banners" => "admin#banners"

  #banners
  get "admin/edit_banner/:id/" => "admin#edit_banner"
  get "admin/edit_banner/" => "admin#edit_banner"
  get "admin/delete_banner/:id" => "admin#delete_banner"
  post "/banner/save" => "admin#update_banner"

  #collections
  get "admin/edit_collection" => "admin#edit_collection"
  get "admin/edit_collection/:id" => "admin#edit_collection"
  get "admin/delete_collection/:id" => "admin#delete_collection"
  get "admin/edit_collection/:id/create_sub/:create_child" => "admin#edit_collection" #:create_child=>true => 
  post "/collection/save" => "admin#update_collection", :conditions => {:method => :post}
  get "/collection/order/:id/:move" => "admin#reorder_collection"

  #fireplaces/products
  get "admin/products" => "admin#products"
  get "admin/edit_fireplace" => "admin#edit_fireplace"
  get "admin/delete_fireplace/:id" => "admin#delete_fireplace"
  post '/fireplace/save' => "admin#update_fireplace"

  #enquiries
  get "admin/enquiries" => "admin#enquiries"
  get "admin/enquiries/:id" => "admin#enquiries"
  get "admin/delete_enquiry/:id" => "admin#delete_enquiry"

  #quotes - not currently used
  get "admin/quotes" => "admin#quotes"
  get "admin/edit_quote" => "admin#edit_quote"
  get "admin/delete_quote/:id" => "admin#delete_quote"
  post '/quote/save' => "admin#update_quote"

  post '/password_reset' => "admin#reset_password"

  #map.connect ':controller/:action/:id'
  #map.connect ':controller/:action/:id.:format'

  get "site" => "site#index"
  get "/" => "site#index"

  get "*missing" => 'site#index'

end
