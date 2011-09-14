require 'ray'
require_relative '../lib/pugnacious'
include Pugnacious

Ray.game "Pugnacious Juices", :size => [800, 600] do
  frames_per_second = 16   
  register { add_hook :quit, method(:exit!) }    

  scene :fight do                                                          
    @player1 = Player.new
    @player2 = Player.new([300, 300], [:w, :d, :s, :a])
    @players = [@player1, @player2]  
    
    always do           
      @player1.control_keys.each do |direction|
        if holding? direction
          @player1.move direction
        end
      end
      
      @player2.control_keys.each do |direction|
        if holding? direction
          @player2.move direction
        end
      end            
    end
    
    render do |win| 
      @players.each do |player|
        win.draw player.pointer
      end     
    end
  end     

  scenes << :fight

end