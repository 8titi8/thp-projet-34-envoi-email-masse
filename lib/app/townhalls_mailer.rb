#Ce programme permet de récupérer de la data et de faire un envoi de
#mails en masse grace à google
require 'gmail'   # on va chercher la gem gmail qui va nous permettre de transmettre nos messages
require 'dotenv'  # permet de se servir du .env qui contient le password
require 'mail'    # permet de mettre en format html  le message envoyé
require 'json'    # va nous permettre de récup et utiliser le fichier json
require 'csv'
Dotenv.load

class Mailer
  attr_accessor :email, :session_gmail
    # def qui va lancer gmail lorsque l'on va lancer la classe
    def initialize
    # On initialise la session gmail pour la connexion et envoi des emails
    # On déclare nos 2 variables d'instance qui vont nous servir plus tard
    @@session_gmail = Gmail.connect("thp.nice@gmail.com", ENV['PASSWORD'])
    @@email = email
    end
    # def qui va permettre de récupérer les fichiers JSON et transformer la donner de sorte
    # à n'utiliser que les emails

    #def qui sert à envoyer les emails aux mairies via le compte gmail de THP Nice et
    #qui indique qu'il nous faut trouver un mail et un nom de mairie
    def send_message_to(city_name, email)
        @@session_gmail #définie ci-dessus, elle permet de se connecter à notre compte gmail
        @@email = @@session_gmail.deliver do
        to "#{email}" #l'instance email que nous allons chercher plus bas avec le fichier des mairies
        subject "Un message de THP Nice pour vous"

        html_part do
        content_type 'text/html; charset=UTF-8'
        body "<font color='blue'><p>Bonjour,<br />

        <p>Je m'appelle Thomas, je suis élève à <em>The Hacking Project</em>, une formation au code gratuite,
        sans locaux, sans sélection, sans restriction géographique. La pédagogie de nore école est
        celle du peer-learning, où nous travaillons par petits groupes sur des projets concrets qui
        font apprendre le code. Le projet du jour est d'envoyer (avec du codage) des emails aux mairies
        pour qu'ils nous aident à faire de The Hacking Project un nouveau format d'éducation pour tous.</p>

        <p>Déjà 500 personnes sont passées par The Hacking Project. Est-ce que la mairie de #{city_name}
        veut changer le monde avec nous ?</p>

        <p>Charles, co-fondateur de The Hacking Project pourra répondre à toutes vos questions.
        Vous pouvez le joindre au 06.95.46.60.80.</p>
        <p>Nous vous remercions pour l'intérêt que vous porterez à ce message.</p>

        <p>Bien à vous,</p><br />

        <p>L'équipe THP de Nice.</p></font>"
      end
      add_file "thp-logo.png" # et on ajoute une petite photo THP, c'est la classe!
        end
    end
    #méthode qui permet d'aller récupérer notre fichier csv des mairies, et spliter
    #les infos dont nous avons besoin pour la méthode send_message
    def get_email_from_csv
        CSV.foreach("../../db/townhalls_names_emails_listing.csv") do |row|
           send_message_to(row[0], row[1])
            end
    end

    def perform
        get_email_from_csv
    end

end

