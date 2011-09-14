module Pugnacious
  class Player
    attr_accessor :pointer, :army, :speed
    
    def initialize()
      @pointer = Ray::Polygon.circle([200, 200], 10, Ray::Color.blue, 3, Ray::Color.blue)
      @pointer.filled   = false 
      @speed = 4
    end              
    
    def move(direction)
      case direction  
        when :up
          pos = pointer.pos
          pointer.pos = [pos.x, (pos.y - speed)]
        when :right
          pos = pointer.pos
          pointer.pos = [(pos.x + speed), pos.y]
        when :down
          pos = pointer.pos
          pointer.pos = [pos.x, (pos.y + speed)]
        when :left
          pos = pointer.pos
          pointer.pos = [(pos.x - speed ), pos.y]
      end       
    end
  end  
end       