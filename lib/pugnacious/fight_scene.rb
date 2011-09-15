module Pugnacious
  class FightScene < Ray::Scene
    scene_name :fight_scene

    def setup
      @player1 = Player.new(
        color: Ray::Color.blue, 
        position: [0, 0], 
        control_keys: [:up, :right, :down, :left])

      @player2 = Player.new(
        color: Ray::Color.red, 
        position: [0, 0], 
        control_keys: [:w, :d, :s, :a])
        
      @player2.pointer.pos = [300, 300]
      @player1.pointer.pos = [400, 300]

      @molecules = []                                                                         
      
      30.times do |i|
        @molecules << Molecule.new(:player => @player1, :molecules => @molecules, :pos => [5+10*i,5])      
        @molecules << Molecule.new(:player => @player2, :molecules => @molecules, :pos => [100+10*i,10]) 
      end
      
      @players = [@player1, @player2]
    end

    def register
      always do                                                    
        @players.each do |player| 
          player.control_keys.each do |direction|
            if holding? direction then player.move direction end                  
          end
        end 
        
        @molecules.each do |molecule|
          molecule.move()
        end
        
      end
    end

    def render(window)
      @players.each { |player| window.draw player.pointer } 
      @molecules.each { |molecule| window.draw molecule.body}
    end

    def clean_up
      @players.each do |player|
        player = nil
      end

      @players = nil

      Ray::ImageSet.clear
    end
  end
end