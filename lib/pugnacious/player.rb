module Pugnacious
  class Player
    attr_accessor :pointer, :army, :speed, :control_keys, :color

    SPEED        = 10
    POINTER_SIZE = 10

    def initialize(options = {})
      @color          = options[:color] || Ray::Color.blue
      position        = options[:position] || [200, 200]

      @control_keys   = options[:control_keys]

      @pointer = Ray::Polygon.circle(position, POINTER_SIZE, @color , 3, @color)
      @pointer.filled = false
    end

    def move(direction)
      case direction
        when control_keys[:up]
          pointer.y -= SPEED unless (pointer.pos.y -= SPEED) < 0 + POINTER_SIZE
        when control_keys[:right]
          pointer.x += SPEED unless (pointer.pos.x += SPEED) > MAP_SIZE - POINTER_SIZE
        when control_keys[:down]
          pointer.y += SPEED unless (pointer.pos.y += SPEED) > MAP_SIZE - POINTER_SIZE
        when control_keys[:left]
          pointer.x -= SPEED unless (pointer.pos.x -= SPEED) < 0 + POINTER_SIZE
      end
    end
  end
end
