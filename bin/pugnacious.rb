require 'ray'
require_relative '../lib/pugnacious'
include Pugnacious

Ray.game "Pugnacious Juices", :size => [800, 600] do
  frames_per_second = 16   
  register { add_hook :quit, method(:exit!) }    

  scene :fight do                                                          
    @player1 = Player.new()
    
    @player2 = Player.new(
      color: Ray::Color.red, 
      position: [300, 300], 
      control_keys: [:w, :d, :s, :a])   
      
    @players = [@player1, @player2]  
    
    always do      
      @players.each do |player| 
        player.control_keys.each do |direction|
          if holding? direction then player.move direction end          
        end        
      end                   
    end
    
    render do |win|    
      @players.each { |player| win.draw player.pointer }      
    end
  end     

  scenes << :fight

end