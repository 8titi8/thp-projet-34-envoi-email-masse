require 'lib/app/views/index'

# Classe mere qui va chercher le View
# qui commande toutes les opérations
# sur le terminal

class Begin

  def initialize

  View.new.perform

  end

end

