require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'



class Scrapper
	attr_accessor :townhalls_emails, :townhalls_names


	def initialize
		@url_townhalls = []
		@townhalls_names = []
		@townhalls_emails = []
		@townhalls_department = []
		@@townhalls_names_emails = []

	end

	def get_the_email_of_a_townhal_from_its_webpage 
	    Nokogiri::HTML(open(@url_townhall_temp)).css('section[2] tr[4] td[2]').text
	end
	# Récupère l'adresse e-mail d'une mairie sur sa homepage

	def get_all_the_urls_of(url_townhall_wanted, department)


	    Nokogiri::HTML(open("http://annuaire-des-mairies.com/#{url_townhall_wanted}")).css('.lientxt').each do |town|    
	        @url_townhalls << "http://annuaire-des-mairies.com/#{department}/#{town.text.downcase.gsub(" ","-")}.html"
	        @townhalls_names << town.text.downcase.gsub(" ","-")
					@townhalls_department << department
	    end
	    # Récupère les noms et les adresses url des mairies et les stocke dans des arrays

	    @url_townhalls.each do |url_townhall|
	        @url_townhall_temp = url_townhall
	        @townhalls_emails << get_the_email_of_a_townhal_from_its_webpage
	    end
	    # Récupère les adresses e-mail des mairies et les stocke dans un arrray

	    @townhalls_names.each_with_index do |townhall_name, i|
	        hash_temp = {}
	        hash_temp["name"] = @townhalls_names[i]
	        hash_temp["email"] = @townhalls_emails[i]
					hash_temp["department"] = @townhalls_department[i]
	        @@townhalls_names_emails << hash_temp 
	    end
	     # Combine les arrays des noms de mairies et leurs e-mails en un hash

	    return p @@townhalls_names_emails

	end

	def perform_all_url
		 get_all_the_urls_of("haute-vienne.html","87")
		 get_all_the_urls_of("var.html","83")
		 get_all_the_urls_of("allier.html","03")
	end

	def create_csv(array_to_push)
			CSV.open("./db/townhalls_names_emails_listing.csv", "wb") do |csv_file|
				csv_file << array_to_push.first.keys
				array_to_push.each do |the_hash|
					csv_file << the_hash.values
				end
		end
	end

	def perform
		create_csv(perform_all_url)
	end

end

