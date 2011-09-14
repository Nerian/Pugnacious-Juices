require 'ray'
require_relative '../lib/pugnacious'
include Pugnacious

Ray.game "Pugnacious Juices", :size => [800, 600] do
  frames_per_second = 16   
  register { add_hook :quit, method(:exit!) }    

  scene :fight do                                                          
    @player = Player.new
    
    always do   
      
      if holding? :up
        pos = @player.pointer.pos
        @player.pointer.pos = [pos.x, (pos.y - 4)]
      end 
      
      if holding? :right
        pos = @player.pointer.pos
        @player.pointer.pos = [(pos.x + 4), pos.y]
      end
      
      if holding? :down
        pos = @player.pointer.pos
        @player.pointer.pos = [pos.x, (pos.y + 4)]
      end
      
      if holding? :left
        pos = @player.pointer.pos
        @player.pointer.pos = [(pos.x - 4 ), pos.y]
      end  
    end
    
    render do |win|
      win.draw @player.pointer
    end
  end     

  scenes << :fight

end