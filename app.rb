require 'bundler'
Bundler.require

$.unshift File.expand_path("./../lib/views", __FILE__)
require 'index'

# Classe mere qui va chercher le View
# qui commande toutes les opérations
# sur le terminal
View.new.perform
