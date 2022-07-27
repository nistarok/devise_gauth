# Devise Google Authenticator

This is a (devise)[https://github.com/plataformatec/devise] extension to allow your app to utilise (Google Authenticator)[http://code.google.com/p/google-authenticator/] for Time-based One Time Passwords (TOTP).

The current version of this gem support Rails 4.

## Installation

Add the gem to your Gemfile (don't forget devise too):

```ruby
gem 'devise'
gem 'devise_google_authenticator', '0.3.16'
```

Don't forget to "bundle install"

### Devise Installation (In case you haven't done it)

Before you can setup Devise Google Authenticator you need to setup Devise first, you need to do the following (but refer to https://github.com/plataformatec/devise for more information)

Install Devise:

```bash
rails g devise:install
```

Setup the User or Admin model

```bash
rails g devise MODEL
```

Configure your app for authorisation, edit your Controller and add this before_filter:

```ruby
before_action :authenticate_user!
```

Make sure your "root" route is configured in config/routes.rb

### Automatic Installation (Lets assume this is a bare bones app)

Run the following generator to add the necessary configuration options to Devise's config file:

```bash
rails g devise_google_authenticator:install
```

After you've created your Devise user models (which is usually done with a "rails g devise MODEL"), set up your Google Authenticator additions:

```bash
rails g devise_google_authenticator MODEL
```

Don't forget to migrate if you're NOT using Mongoid as your database ORM, Mongoid installations will have appropriate fields added to the model after the command above:

```bash
rake db:migrate
```

### Installation With Existing Users

After the above steps have been performed, you'll need to generate secrets for each user:

```ruby
 User.where(:gauth_secret => nil).find_each do |user|
  user.send(:assign_auth_secret)
  user.save!
 end
```

By default, users won't need to perform two-factor authentication (gauth_enabled='f'). By visiting /MODEL/displayqr (eg: /users/displayqr)
and submitting the form, two-factor authentication will then be turned on (gauth_enabled=1) and required for subsequent logins.

## Configuration Options

The install generator adds some options to the end of your Devise config file (config/initializers/devise.rb)

* `config.ga_timeout` - how long should the user be able to authenticate with their Google Authenticator token
* `config.ga_timedrift` - a multiplier which provides for drift between a user's clock (and therefore their OTP) and the system clock. This should be fine at 3.
* `config.ga_remembertime` - how long to remember the token for before requiring another. By default this is 1 month. To disable this setting change it to nil.
* `config.ga_appname` - If you want to set a custom application name instead of using the name of the Rails app.
* `config.ga_bypass_signup` - If you don't want to immediately forward newly registered or signed-up users to the Display QR page. If this is enabled, users will have to visit the /displayqr page to enable Google Authenticator.

## Custom Views

If you want to customise your views (which you likely will want to, as they're pretty ugly right now), you can use the generator:

```bash
rails g devise_google_authenticator:views
```

## Usage

With this extension enabled, the following is expected behaviour:

* When a user registers, they are forwarded onto the Display QR page (unless ga_bypass_signup is set to true). This allows them to add their new "token" to their mobile device, and enable, or disable, the functionality. To enable/disable the functionality, the user has to enter the current token.
* If users can't self-register, they're still able to visit this page by visiting /MODEL/displayqr (eg: /users/displayqr).
* If the function is enabled (for that user), when they sign in, they'll be prompted for their password (as per normal), but then redirected into the Check QR page. They have to enter their token (from their device) to then successfully authenticate.
* If configured (by default to 1 month), the user will only be prompted for the token every 1 month.

## I18n

The install generator also installs an english copy of a Devise Google Authenticator i18n file. This can be modified (or used to create other language versions) and is located at: config/locales/devise.google_authenticator.en.yml

## Testing

The minimal supported versions of Ruby/Rails/Devise is of this fork :
 * Ruby 2.2
 * Rails 4
 * Devise 3.5.10

## Thanks (and unknown contributors)

This extension would not exist without the following other projects and associated authors (Whom I have turned to for inspiration and definitely have helped contributing by providing awesome Devise extensions. A lot of this code has been refactored from various sources, in particular these - in particular Sergio and Devise_invitable for his excellent unit test code):

* Devise (José Valim, Carlos Antônio da Silva, Rodrigo Flores) https://github.com/plataformatec/devise
* Devise_invitable (Sergio Cambra) https://github.com/scambra/devise_invitable
* Devise_openid_authenticatable (Nat Budin) https://github.com/nbudin/devise_openid_authenticatable
* Devise_security_extension (Team Phatworx, Marco Scholl, Alexander Dreher) https://github.com/phatworx/devise_security_extension
* Ronald Arias https://github.com/ronald05arias
* Sunny Ng https://github.com/blahblahblah-
* Michael Guymon https://github.com/mguymon
* Mikkel Garcia https://github.com/mikkel
* Ricky Reusser https://github.com/rreusser
* Felipe Lima https://github.com/felipecsl
* Sylvain Utard https://github.com/redox


## Contributing to devise_google_authenticator
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2014 Christian Frichot. See LICENSE.txt for
further details.
