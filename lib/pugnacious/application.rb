module Pugnacious
  MAP_SIZE = 500
  MOLECULE_SIZE = 3

  class Application         
    attr_accessor :number_of_molecules
    def self.run(argv)            
      Ray.game "Pugnacious Juices", :size => [MAP_SIZE, MAP_SIZE] do
        register { add_hook :quit, method(:exit!) }
        
        number_of_molecules = argv[0].to_i | 250

        FightScene.bind(self)
        push_scene(:fight_scene, number_of_molecules)
      end
    end
  end
end



