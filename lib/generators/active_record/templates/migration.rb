# frozen_string_literal: true

class DeviseGauthAddTo<%= table_name.camelize %> < ActiveRecord::Migration
  def self.up
    change_table :<%= table_name %> do |t|
      t.string  :gauth_secret
      t.string  :gauth_enabled, default: <%= Rails.version >= '5.2' ? '0' : 'f' %>
      t.string  :gauth_tmp
      t.datetime  :gauth_tmp_datetime
    end

  end
  
  def self.down
    change_table :<%= table_name %> do |t|
      t.remove :gauth_secret, :gauth_enabled, :gauth_tmp, :gauth_tmp_datetime
    end
  end
end
