# frozen_string_literal: true

require 'active_record/connection_adapters/abstract/schema_definitions'
require 'active_support/core_ext/integer'
require 'active_support/core_ext/string'
require 'active_support/ordered_hash'
require 'active_support/concern'
require 'devise'

module Devise # :nodoc:
  mattr_accessor :ga_timeout
  @@ga_timeout = 3.minutes

  mattr_accessor :ga_timedrift
  @@ga_timedrift = 3

  mattr_accessor :ga_remembertime
  @@ga_remembertime = 1.month

  mattr_accessor :ga_appname
  @@ga_appname = if Rails.version < '6'
                   Rails.application.class.parent_name
                 else
                   Rails.application.class.module_parent_name
                 end

  mattr_accessor :ga_bypass_signup
  @@ga_bypass_signup = false
end

module DeviseGauth
  autoload :Schema, 'devise_gauth/schema'
  autoload :Patches, 'devise_gauth/patches'
end

require 'devise_gauth/routes'
require 'devise_gauth/rails'
require 'devise_gauth/orm/active_record'
require 'devise_gauth/controllers/helpers'
require 'devise_gauth/views/helpers'
ActionView::Base.send :include, DeviseGauth::Views::Helpers

Devise.add_module :google_authenticatable, controller: :google_authenticatable,
                                           model: 'devise_gauth/models/google_authenticatable',
                                           route: :displayqr
