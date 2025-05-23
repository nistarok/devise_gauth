# frozen_string_literal: true

module DeviseGauth
  module Generators
    class DeviseGauthGenerator < Rails::Generators::NamedBase
      namespace 'devise_gauth'

      desc 'Add :google_authenticatable directive in the given model, plus accessors. Also generate migration for ActiveRecord'

      def inject_devise_gauth_content
        path = File.join('app', 'models', "#{file_path}.rb")

        return unless File.exist?(path)

        inject_into_file(path, 'google_authenticatable, :', after: 'devise :')
        inject_into_file(path, 'gauth_enabled, :gauth_tmp, :gauth_tmp_datetime, :', after: 'attr_accessible :') if needs_attr_accessible?
        inject_into_class(path, class_name, "\tattr_accessor :gauth_token\n")
      end

      hook_for :orm

      private

      def needs_attr_accessible?
        rails_3? && !strong_parameters_enabled?
      end

      def rails_3?
        Rails::VERSION::MAJOR == 3
      end

      def strong_parameters_enabled?
        defined?(ActionController::StrongParameters)
      end
    end
  end
end
