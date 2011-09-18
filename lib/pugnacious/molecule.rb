module Pugnacious
  class Molecule 
    include Pugnacious::Movable
    
    attr_accessor :player, :life, :body, :molecules, :pointer, :position, :game_map, :speed
        
    def initialize(options = {})
      @player = options[:player]
      @game_map = options[:map]                                               
      @position = options[:pos]
      @game_map[@position[0]][@position[1]] = self
      @life = 100                       
      @body = Ray::Polygon.rectangle([0, 0, MOLECULE_SIZE, MOLECULE_SIZE], @player.color)
      @body.pos = [@position[0] * MOLECULE_SIZE, @position[1] * MOLECULE_SIZE] || [0, 0]      
      @molecules = options[:molecules]
      @pointer = @player.pointer                                                           
      @speed = 1      
    end                                                                                         
  end
end