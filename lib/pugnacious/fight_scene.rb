module Pugnacious
  class FightScene < Ray::Scene
    scene_name :fight_scene

    def setup(number_of_molecules)
      @player1 = Player.new(
        color: Ray::Color.blue,
        position: [0, 0],
        control_keys: {:up => :up, :right => :right, :down => :down, :left => :left})

      @player2 = Player.new(
        color: Ray::Color.red,
        position: [0, 0],
        control_keys: {:up => :w, :right => :d, :down => :s, :left => :a})

      @player2.pointer.pos = [50, 300]
      @player1.pointer.pos = [450, 300]

      @game_map  = GameMap.generate_empty_map(MAP_SIZE, MAP_SIZE)
      @molecules = GameMap.generate_molecules(@game_map, @player1, @player2, number_of_molecules)                
      
      @player2_mark =  text("Player 2: #{@player2_molecules}", 
        :at => [180, 10], 
        :size => 14,
        :color => @player2.color)      
      @player1_mark =  text("Player 1: #{@player1_molecules}", 
        :at => [250, 10], 
        :size => 14, 
        :color => @player1.color)
      
      @players = [@player1, @player2]
    end

    def register
      always do
        @players.each do |player|
          player.control_keys.values.each do |direction|
            if holding? direction then player.move direction end
          end          
        end
        
        @player1_mark.string = @molecules.select {|m| m.player == @player1}.size.to_s
        @player2_mark.string = @molecules.select {|m| m.player == @player2}.size.to_s

        @molecules.each &:move        
        if @molecules.all?{|m| m.player == @player1} or @molecules.all?{|m| m.player == @player2}
          @winner = text("You are the winner!!", :at => [200, 200], :size => 30)
        end
      end
    end

    def render(window)
      @molecules.each { |molecule| window.draw molecule.body}
      @players.each { |player| window.draw player.pointer }
      window.draw @player1_mark
      window.draw @player2_mark
      window.draw(@winner) unless @winner.nil?
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