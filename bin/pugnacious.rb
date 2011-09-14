require 'ray'
require_relative '../lib/pugnacious'

Ray.game "Pugnacious Juices", :size => [800, 600] do
  frames_per_second = 16   
  register { add_hook :quit, method(:exit!) }    

  scene :fight do                                                          
    @player1 = Pugnacious::Player.new
    
    render do |win|
      win.draw @player1.pointer
    end
  end     

  scenes << :fight

end