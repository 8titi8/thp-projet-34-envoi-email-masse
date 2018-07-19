 # ligne très importante qui appelle la gem. Sans elle, le programme ne saura pas appeler Twitter
require 'twitter'

# Appelle la gem dotenv
require 'dotenv'

require 'pry'

# Ceci appelle le fichier .env grâce à la gem dotenv, et enregistre toutes les données enregistrées dans une hash ENV
Dotenv.load

# quelques lignes qui enregistrent les clés d'APIs
client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV["TWITTER_API_KEY"]
  config.consumer_secret     = ENV["TWITTER_API_SECRET"]
  config.access_token        = ENV["TWITTER_USER_TOKEN"]
  config.access_token_secret = ENV["TWITTER_USER_TOKEN_SECRET"]
end

require 'watir'

browser = Watir::Browser.new #(:firefox)
browser.goto 'https://twitter.com'

search_bar = browser.text_field(class: "search-input")
# position de la barre de recherche dans la page
search_bar.set("mairie #{townhall_name}")
# ce que l'on veut y écrire

search_bar.send_keys(:enter)
# comme si on appuyait sur entrée pour valider la recherche

browser.driver.manage.timeouts.implicit_wait = 3
#permet d'attendre que la page se charge

browser.div(class: "stream").span(class: "username").text
# affiche le handle du 1er tweet

p "Méfait accompli, fermeture du browser"
browser.close