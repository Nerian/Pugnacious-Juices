module Pugnacious
  class FightScene < Ray::Scene
    scene_name :fight_scene

    def setup
      @gc_counter = 0
      #self.frames_per_second = 5
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

      @game_map = GameMap.generate_empty_map(MAP_SIZE, MAP_SIZE)

      @molecules = []

      @game_map.size.times do |i|
        @molecules << Molecule.new(
          :player    => @player1, 
          :rival     => @player2,
          :molecules => @molecules,
          :pos       => [i,10], 
          :map       => @game_map)
        @molecules << Molecule.new(
          :player    => @player1, 
          :rival     => @player2, 
          :molecules => @molecules,
          :pos       => [i,11], 
          :map       => @game_map)

        @molecules << Molecule.new(
          :player    => @player2, 
          :rival     => @player1, 
          :molecules => @molecules,
          :pos       => [i,72], 
          :map       => @game_map)
        @molecules << Molecule.new(
          :player    => @player2, 
          :rival     => @player1, 
          :molecules => @molecules,
          :pos       => [i,75], 
          :map       => @game_map)
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
        
        @molecules.each &:move
      end
    end

    def render(window)
      @molecules.each { |molecule| window.draw molecule.body}
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