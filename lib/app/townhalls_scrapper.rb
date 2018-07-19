require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'


class Scrapper
	attr_accessor :townhalls_emails, :townhalls_names


	def initialize
		#@townhalls_names = townhalls_names
		#@townhalls_emails = townhalls_emails
		@url_townhalls = []
		@townhalls_names = []
		@townhalls_emails = []
		@@townhalls_names_emails = []
	end

	def get_the_email_of_a_townhal_from_its_webpage                                                             # Récupère l'adresse e-mail d'une mairie sur sa homepage
	    Nokogiri::HTML(open(@url_townhall_temp)).css('section[2] tr[4] td[2]').text
	end

	def get_all_the_urls_of(url_townhall_wanted, department)


	    Nokogiri::HTML(open("http://annuaire-des-mairies.com/#{url_townhall_wanted}")).css('.lientxt').each do |town|    # Récupère les noms et les adresses url des mairies et les stocke dans des arrays
	        @url_townhalls << "http://annuaire-des-mairies.com/#{department}/#{town.text.downcase.gsub(" ","-")}.html"
	        @townhalls_names << town.text.downcase.gsub(" ","-")
	    end

	    @url_townhalls.each do |url_townhall|
	        @url_townhall_temp = url_townhall
	        @townhalls_emails << get_the_email_of_a_townhal_from_its_webpage                                       # Récupère les adresses e-mail des mairies et les stocke dans un arrray
	    end

	    @townhalls_names.each_with_index do |townhall_name, i|
	        hash_temp = {}
	        hash_temp["name"] = @townhalls_names[i]
	        hash_temp["email"] = @townhalls_emails[i]
	        @@townhalls_names_emails << hash_temp                                                                   # Combine les arrays des noms de mairies et leurs e-mails en un hash
	    end

	    return p @@townhalls_names_emails

	end

def perform_all_url
	 get_all_the_urls_of("haute-vienne.html","87")
	 get_all_the_urls_of("var.html","83")
	 get_all_the_urls_of("allier.html","03")
end

def create_json_file(array_to_convert)
	File.open("../../db/emails.json", "w") do |f|
		f.write(array_to_convert)
	end
end

def perform
	create_json_file(perform_all_url)
end

end
Scrapper.new.perform
