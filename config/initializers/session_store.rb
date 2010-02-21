# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_Holiday_session',
  :secret      => '9208d04c226c959b69124013da14c4589c2d4e3cc0fe5f1d547c5e3043cec2741efe4401dca86a1a7e943f501e19350b65e10017e290a61b99fd938875edd970'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
