
require '../app/townhalls_follower'
require '../app/townhalls_handles_getter'
require '../app/townhalls_mailer'
require '../app/townhalls_scrapper'
require 'index'


class Done

  def scrapper_done
    puts "==========================================================================="
    puts "All good ! Vous venez de récupérer toutes les adresses mails des mairies de
    la Haute-Vienne, du Var et de l'Allier !"
    puts "Tout est dans un beau fichier nommé townhalls_names_emails_listing !"
    View.new.perform
  end

  def mailer_done
    puts "==========================================================================="
    puts "Cela ne se voit pas.. mais vous venez d'envoyer plein d'emails, cher petit hacker en devenir !"
    View.new.perform
  end

  def handles_done
    puts "==========================================================================="
    puts "C'est bon, vous venez de récupérer tous les handles des mairies"
    View.new.perform
  end

  def followers_done
    puts "==========================================================================="
    puts "Le compte THP Nice vient de follower toutes les mairies !"
    View.new.perform
  end

  def open_csv_done
    puts "==========================================================================="
    puts "J'espère que le CSV vous a bien servi !"
    View.new.perform
  end

  def goodbye
    puts "==========================================================================="
    puts "Merci d'avoir utilisé notre application de hacker !"
    puts "Les moussaillons de Nice :)"
    exit
  end


end
