require 'watir'
# Appelle la gem dotenv
require 'dotenv'
# Ceci appelle le fichier .env grâce à la gem dotenv, et enregistre toutes les données enregistrées dans une hash ENV
Dotenv.load

require 'json'

class Handles

	def search_handle(townhall_name)
		townhall_name = "la colle sur loup"
		browser = Watir::Browser.new
		browser.goto 'https://twitter.com/login?lang=en'

		email_user = browser.text_field(class: "js-username-field")
		# position du champ email à remplir dans la page
		email_user.set("thp.nice@gmail.com")
		# email de l'utilisateur

		password_user = browser.text_field(class: "js-password-field")
		# position du champ password à remplir dans la page
		password_user.set(ENV["THP_TWITTER_PASSWORD"])

		browser.send_keys(:enter)

		browser.driver.manage.timeouts.implicit_wait = 3
		#permet d'attendre que la page se charge

		search_bar = browser.text_field(class: "search-input")
		# position de la barre de recherche dans la page
		search_bar.set("mairie #{townhall_name}")
		# ce que l'on veut y écrire

		search_bar.send_keys(:enter)
		# comme si on appuyait sur entrée pour valider la recherche

		browser.driver.manage.timeouts.implicit_wait = 20
		#permet d'attendre que la page se charge

		@townhall_handle = browser.div(class: "stream").span(class: "username").text
		# affiche le handle du 1er tweet
		return @townhall_handle
	end

p "Méfait accompli, fermeture du browser"

	#browser.close
end

Handles.new.search_handle