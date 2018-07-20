require 'townhalls_scrapper'
require 'townhalls_mailer'
require 'townhalls_handles_getter'
require 'townhalls_follower'

class View

  def initialize
    puts "==========================================================================="
    puts "   Bienvenue sur notre application. Nous vous proposons diverses
    solutions pour faire connaitre THP aux communes des départements
    de Haute-Vienne (87), du Var (83) et de l'Allier (03)"
    puts " "

  end

  def perform
    puts "==========================================================================="
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
    choice = gets.chomp.to_i

    until (1..6).include?(choice)
      puts "Game over, veuillez faire un choix entre 1 et 6 !"
      choice = gets.chomp.to_i
    end

    if choice == 1
    fname = "../../db/townhalls_names_emails_listing.csv"
    somefile = File.open(fname,"w")
    somefile.close
      Done.new.open_csv_done

    elsif choice == 2
      Scrapper.new.perform
      Done.new.scrapper_done

    elsif choice == 3
      Mailer.new.perform
      Done.new.mailer_done

    elsif choice == 4
     Handles.new.search_handle
      Done.new.handles_done
      elsif choice == 5
      Follower.new.follow_each_townhall
      Done.new.followers_done

    else choice == 6
      Done.new.goodbye
    end

  end


end

View.new.perform