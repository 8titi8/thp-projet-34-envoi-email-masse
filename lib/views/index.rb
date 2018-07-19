require '../app/townhalls_follower'
require '../app/townhalls_handles_getter'
require '../app/townhalls_mailer'
require '../app/townhalls_scrapper'


class View

def initialize
  puts "   Bienvenue sur notre application. Nous vous proposons diverses
  solutions pour faire connaitre THP aux communes des départements
  de Haute-Vienne (87), du Var (83) et de l'Allier (03)"
  puts " "
  puts "   Merci de nous indiquer le choix que vous souhaitez faire en
  indiquant le numéro correspondant dans la liste suivante:"
  puts ""
  puts " 1 - Voir le fichier CSV des mairies correspondantes"
  puts " 2 - Scrapper les sites des mairies"
  puts " 3 - Envoyer des emails à ces mairies"
  puts " 4 - Récupérer leurs handles twitter"
  puts " 5 - Follow ces mairies sur twitter"
  puts " 6 - Quitter l'application"
  p " > "

end

def ask_what_to_do
  choice = gets.chomp.to_i
  if choice == 1


  fname = "../../db/townhalls_names_emails_listing.csv"
  somefile = File.open(fname,"w")
  somefile.close

  elsif choice == 2
    Scrapper.new.perform

  elsif choice == 3
    Mailer.new.perform

  elsif choice == 4
    Handles.new.search_handle

  elsif choice == 5
    Follower.new.follow_each_townhall

  else choice == 6
    exit
  end

end
end
View.new
