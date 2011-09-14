module Pugnacious
  class FightScene < Ray::Scene
    scene_name :fight_scene

    def setup
      @player1 = Player.new(
        color: Ray::Color.blue, 
        position: [200, 200], 
        control_keys: [:up, :right, :down, :left])

      @player2 = Player.new(
        color: Ray::Color.red, 
        position: [300, 300], 
        control_keys: [:w, :d, :s, :a])

      @molecules = []
      @molecules << Molecule.new(:player => @player1)              

      @players = [@player1, @player2]
    end

    def register
      always do      
        @players.each do |player| 
          player.control_keys.each do |direction|
            if holding? direction then player.move direction end                  
          end
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