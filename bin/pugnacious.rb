require 'ray'
require_relative '../lib/pugnacious'
include Pugnacious

Ray.game "Pugnacious Juices", :size => [800, 600] do
  frames_per_second = 16   
  register { add_hook :quit, method(:exit!) }    

  scene :fight do                                                          
    @player = Player.new
    
    always do           
      [:up, :down, :right, :left].each do |direction|
        if holding? direction
          @player.move direction
        end
      end            
    end
    
    render do |win|
      win.draw @player.pointer
    end
  end     

  scenes << :fight

end