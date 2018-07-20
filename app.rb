require 'bundler'
Bundler.require

$.unshift File.expand_path("./../lib/views", __FILE__)
require 'index'