<h1>The Hacking Project - Semaine 3 - Jeudi</h1>

<h2>Projet : Envoi d'emails en masse</h2>

<p>Pour lancer le programme écrire dans son terminal : ruby app.rb</p>

<ul>Edité par :
	<li><strong>Gaëlle Gorgori</strong> : 06 62 31 97 81</li>
	<li><strong>Thomas Fernandez</strong> : 06 58 88 68 09</li>
	<li><strong>Mathilde Ray</strong> : 06 25 98 18 85</li>
</ul>

<h2>Le commencement</h2>

<p>L'équipe de Nice vous présente son formidable travail. Le but de ce dernier, faire un scrapp des mails des communes de plusieurs départements et envoyer un mail à chacune des communes. Ouloulou, beaucoup de mails afin de présenter notre superbe formation. </p>

<h2>Le kikafékoi</h2>

<ul>
<li><strong>Thomas le magnifique pour la réalisation du scrappeur #akajesuisunrappeur</strong></li>
<li><strong>Gaëlle alias Poker Face pour l'envoi des mails</strong></li>
<li><strong>Mathilde ou TiTi pour la partie Tweet</strong></li>
</ul>

<h2>Didier!!! Comment ça marche ce truc ?</h2>

<p>Tout d'abord, tu BUNDLE dans le building afin d'appeler les potos, les Gems #ohyeah </p>

	$ bundle install

<p>La fine équipe des Gems</p> 

	gmail
	json
	nokogeri
	pry
	dotenv
	twitter
	watir

<h2>Maryse, apporte moi donc le saucison et le tree !</h2>


	├── Gemfile
	├── Gemfile.lock
	├── README.md
	├── app.rb
	├── db
	│   ├── emails.json
	│   └── townhalls_names_emails_listing.csv
	└── lib
    	├── app
    	│   ├── thp-logo.png
		│   ├── townhalls_adder_to_db.rb
   		│   ├── townhalls_follower.rb
    	│   ├── townhalls_handles_getter.rb
    	│   ├── townhalls_mailer.rb
    	│   └── townhalls_scrapper.rb
    	└── views
        		├── done.rb
        		└── index.rb

<h2>Un peu de sérieux</h2>

	$ ruby app.rb

<ul>
<li>env : pour stocker nos identités</li> 	
<li>townhalls_scrapper : pour la réalisation du scrapping</li>  
<li>townhalls_mailer.rb : pour envoyer les mails aux communes</li> 
<li>townhalls_handles_getter.rb : pour la partie twitter</li> 
 </ul>   	

<h2>Les résultats</h2>

607 mails envoyés 
