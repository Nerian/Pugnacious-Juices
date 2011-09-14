module Pugnacious
  class Application
    def self.run 
      Ray.game "Pugnacious Juices", :size => [800, 600] do
        frames_per_second = 16   
        register { add_hook :quit, method(:exit!) }    

        FightScene.bind(self)
        scenes << :fight_scene
      end      
    end
  end  
end



