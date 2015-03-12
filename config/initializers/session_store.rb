# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_mcalpine_session',
  :secret      => '26d790ee07f3533f627d82bb95a196f8742add29ef3071e9b1eca014017acfffddad2444c8ac72ccc7821117979c7234a237c14b7e4a8789c42610c33563d1d1'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
