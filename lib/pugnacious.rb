module Pugnacious
  class Player
    attr_accessor :pointer, :army
    
    def initialize()
      @pointer = Ray::Polygon.circle([200, 200], 10, Ray::Color.blue, 3, Ray::Color.blue)
      @pointer.filled   = false
    end
  end  
end