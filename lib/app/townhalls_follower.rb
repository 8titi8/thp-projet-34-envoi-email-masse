require 'csv'
require 'dotenv'
require 'pry'
require 'twitter'




# Ceci appelle le fichier .env grâce à la gem dotenv, et enregistre toutes les données enregistrées dans une hash ENV
Dotenv.load

class Follower

	def initialize
		# quelques lignes qui enregistrent les clés d'APIs
		@client = Twitter::REST::Client.new do |config|
		  config.consumer_key        = ENV["TWITTER_API_KEY"]
		  config.consumer_secret     = ENV["TWITTER_API_SECRET"]
		  config.access_token        = ENV["TWITTER_USER_TOKEN"]
		  config.access_token_secret = ENV["TWITTER_USER_TOKEN_SECRET"]
		end
	end
	
	def follow_each_townhall
		CSV.foreach("../../db/townhalls_names_emails_listing.csv") do |row|
				@client.follow("#{row[3].delete_prefix("@")}")
		end
	end

end

Follower.new.follow_each_townhall