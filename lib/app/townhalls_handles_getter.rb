require 'watir'
# Appelle la gem dotenv
require 'dotenv'
# Ceci appelle le fichier .env grâce à la gem dotenv, et enregistre toutes les données enregistrées dans une hash ENV
Dotenv.load


	def twitter_log_in
		browser_log_in = Watir::Browser.new
		browser_log_in.goto 'https://twitter.com/login?lang=en'

		email_user = browser_log_in.text_field(class: "js-username-field")
		# position du champ email à remplir dans la page
		email_user.set("thp.nice@gmail.com")
		# email de l'utilisateur

		password_user = browser_log_in.text_field(class: "js-password-field")
		# position du champ password à remplir dans la page
		password_user.set(ENV["THP_TWITTER_PASSWORD"])

		submit_button = browser_log_in.button(type: "submit") 
		# localiser le bouton
		submit_button.click
		# cliquer sur le bouton
		
		browser.driver.manage.timeouts.implicit_wait = 3
		#permet d'attendre que la page se charge
	end

	def search_handles
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

	end

twitter_log_in
p "Méfait accompli, fermeture du browser"
browser.close