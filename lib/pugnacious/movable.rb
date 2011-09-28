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
      directions << DIRECTIONS.keys[index]
      directions << DIRECTIONS.keys[(index - 1)]            
      if (index + 1) > 7
        directions << DIRECTIONS.keys[(index - 7)]
      else
        directions << DIRECTIONS.keys[index + 1]
      end
      directions << DIRECTIONS.keys[(index - 2)]
      if (index + 2) > 7
        directions << DIRECTIONS.keys[(index - 7)]
      else
        directions << DIRECTIONS.keys[index + 2]
      end
      directions
    end

    def check_tile(direction)
      xw, yw = DIRECTIONS[direction]

      x = xw + @position[0]
      y = yw + @position[1]

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
      if pointer_at_south then return :south end
      if pointer_at_north then return :north end
      if pointer_at_east then return :east end
      if pointer_at_west then return :west end
      if pointer_at_south_east then return :south_east end
      if pointer_at_north_east then return :north_east end
      if pointer_at_south_west then return :south_west end
      if pointer_at_north_west then return :north_west end
      if here then return :here end
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