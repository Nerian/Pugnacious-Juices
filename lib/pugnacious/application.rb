module Pugnacious
  MAP_SIZE = 500
  MOLECULE_SIZE = 3

  class Application
    def self.run
      Ray.game "Pugnacious Juices", :size => [MAP_SIZE, MAP_SIZE] do
        register { add_hook :quit, method(:exit!) }

        FightScene.bind(self)
        scenes << :fight_scene
      end
    end
  end
end



