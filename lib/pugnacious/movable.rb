module Pugnacious
  module Movable

    DIRECTIONS = {:north => [0, -1] ,
      :north_east => [1, -1],
      :east => [1, 0],
      :south_east => [1, 1],
      :south => [0, 1],
      :south_west => [-1, 1],
      :west => [-1, 0],
      :north_west => [-1, -1]}

    def move
      unless pointer_direction() == :here 
        posible_directions = posible_directions(pointer_direction())
      
        posible_directions.each do |direction|
          case check_tile(direction)
            when :empty
              move!(direction)
              return
            when :enemy
              fight(direction)
              return
          end
        end 
      end
    end
    
    def fight(direction)
      xw, yw = DIRECTIONS[direction]

      x = xw + @position[0]
      y = yw + @position[1]

      tile = @game_map[x][y]
      
      tile.receive_damage      
    end

    def posible_directions(direction)
      directions = []
      index = DIRECTIONS.keys.find_index(direction)
      indexes = []
                   
      # The order is important. 
      indexes << index
      indexes << index - 1
      indexes << index + 1
      indexes << index - 2
      indexes << index + 2
      
      directions = indexes.map do |i|
        if i>7  
          DIRECTIONS.keys[i-7]          
        else
          DIRECTIONS.keys[i]
        end
      end

      directions
    end

    def check_tile(direction)
      xw, yw = DIRECTIONS[direction]
      
      x = xw + @position[0]
      y = yw + @position[1]
      
      unless @game_map[x].nil? or @game_map[x][y].nil?
        tile = @game_map[x][y]

        if tile == :empty
          return :empty
        elsif tile.class == Molecule
          if tile.player != self.player
            return :enemy
          else
            return :friend
          end 
        end      
      end
    end

    def move!(direction)
      xw, yw =  DIRECTIONS[direction]

      x = xw + @position[0]
      y = yw + @position[1]

      @game_map[@position[0]][@position[1]] = :empty
      @game_map[x][y] = self

      body.pos = [x * MOLECULE_SIZE, y * MOLECULE_SIZE]
      @position = [x, y]
    end

    def pointer_direction()
      case
        when pointer_at_south
          :south
        when pointer_at_north 
          :north
        when pointer_at_east 
          :east
        when pointer_at_west 
          :west
        when pointer_at_south_east
          :south_east
        when pointer_at_north_east 
          :north_east
        when pointer_at_south_west
          :south_west
        when pointer_at_north_west
          :north_west
        when here
          :here
      end
    end

    def pointer_at_south()
      @pointer.x == body.x and @pointer.y > body.y
    end

    def pointer_at_north()
      @pointer.x == body.x and @pointer.y < body.y
    end

    def pointer_at_east()
      @pointer.x > body.x and @pointer.y == body.y
    end

    def pointer_at_west()
      @pointer.x < body.x and @pointer.y == body.y
    end

    def pointer_at_south_east()
      @pointer.x > body.x and @pointer.y > body.y
    end

    def pointer_at_north_east()
      @pointer.x > body.x and @pointer.y < body.y
    end

    def pointer_at_south_west()
      @pointer.x < body.x and @pointer.y > body.y
    end

    def pointer_at_north_west()
      @pointer.x < body.x and @pointer.y < body.y
    end

    def here()
      @pointer.x == body.x and @pointer.y == body.y
    end
  end
end