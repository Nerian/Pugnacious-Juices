module Pugnacious
  class Molecule
    include Pugnacious::Movable

    attr_accessor :player, :life, :body, :molecules, :pointer, :position, :game_map, :life, :rival

    MAX_LIFE     = 30

    def initialize(options = {})
      @player    = options[:player]
      @game_map  = options[:map]
      @position  = options[:pos]
      @game_map[@position[0]][@position[1]] = self
      @body = Ray::Polygon.rectangle([0, 0, MOLECULE_SIZE, MOLECULE_SIZE],
        Ray::Color.new(100, 100, 0) + @player.color)
      @body.pos  = [@position[0] * MOLECULE_SIZE, @position[1] * MOLECULE_SIZE] || [0, 0]
      @molecules = options[:molecules]
      @pointer   = @player.pointer
      @life      = MAX_LIFE
      @rival     = options[:rival]
    end

    def receive_damage()
      @life -=1
      if @life <= 0
        @player = @rival
        @body.color = Ray::Color.new(100, 100, 0) + @player.color
        @life = MAX_LIFE
        @pointer = @player.pointer
      end
    end
  end
end