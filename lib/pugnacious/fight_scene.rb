module Pugnacious
  class FightScene < Ray::Scene
    scene_name :fight_scene

    def setup
      @player1 = Player.new()

      @player2 = Player.new(
        color: Ray::Color.red, 
        position: [300, 300], 
        control_keys: [:w, :d, :s, :a])   

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