require 'csv'
require 'dotenv'
Dotenv.load
require_relative 'townhalls_scrapper'
require 'twitter'
require 'pry'


class Handles
	attr_accessor :townhalls_handles

	def initialize
		@townhalls_handles = []	

############################# LOG IN TWITTER ############################# 

		@client = Twitter::REST::Client.new do |config|
				config.consumer_key        = ENV["TWITTER_API_KEY"]
				config.consumer_secret     = ENV["TWITTER_API_SECRET"]
				config.access_token        = ENV["TWITTER_USER_TOKEN"]
				config.access_token_secret = ENV["TWITTER_USER_TOKEN_SECRET"]
			end

	end

######################## RECHERCHE HANDLE TWITTER ######################## 
	def search_handles

		CSV.foreach("../../db/townhalls_names_emails_listing.csv") do |row|
		#lit le fichier CSV ligne par ligne et pour chaque fait :
			begin
				@client.search("mairie #{row[0]}").take(1).collect do |tweet|
				# rechercher les tweets contenant mairie de XX 
			  		@townhalls_handles << tweet.user.screen_name
			  		# ajouter les handles au tableau
				end
			rescue StandardError => e
			#permet de ne pas arreter le programme si Twitter bloque l'accès (cause des quotas)
				puts "Mince ! Il y a eu un problème avec Twitter.. ils nous ont bloqué l'accès ! Quand trop de hack tue le hack ! ;)"
				return @townhalls_handles
				add_handle_to_csv
				# appelle la méthode en cas d'erreur et retourne le tableau en l'état
			end 
		end
		return @townhalls_handles 
	end

	def add_handle_to_csv
	# ajoute les handles dans le tableau contenant les noms et emails
		i = 0
		while i < @townhalls_handles.size
			@@townhalls_names_emails.collect do |k, v|
				k['handle'] = @townhalls_handles[i]
				i += 1
			end 
		end
    
		CSV.open("../../db/townhalls_names_emails_listing.csv", "wb") do |csv_file|
		# réécrit sur le fichier .csv
			csv_file << @@townhalls_names_emails.first.keys
			@@townhalls_names_emails.each do |the_hash|
				csv_file << the_hash.values
			end
	end
		
	end

	def perform
		search_handles
		add_handle_to_csv
	end

end

Handles.new.perform