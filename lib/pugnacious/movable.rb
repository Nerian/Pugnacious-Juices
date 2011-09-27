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
      try_to_go(where_is_the_pointer?) unless where_is_the_pointer? == :here
    end

    def try_to_go(direction)
      directions = DIRECTIONS.keys
      intention_index = directions.find_index(direction)
      directions.push(:north)

      if can_i_move_there?(direction)
        move_there(direction)
      elsif can_i_move_there?(directions[intention_index+1])
        move_there(directions[intention_index+1])
      elsif can_i_move_there?(directions[intention_index-1])
        move_there(directions[intention_index-1])
      end
    end

    def can_i_move_there?(direction)
      xw, yw = DIRECTIONS[direction]

      x = xw + @position[0]
      y = yw + @position[1]

      if @game_map[x][y] == :empty
        return true
      elsif @game_map[x][y].class == Molecule
        if @game_map[x][y].player != self.player
          @game_map[x][y].receive_damage()
        end
        return false
      else
        return false
      end
    end

    def move_there(direction)
      xw, yw =  DIRECTIONS[direction]

      x = xw + @position[0]
      y = yw + @position[1]

      @game_map[@position[0]][@position[1]] = :empty
      @game_map[x][y] = self

      body.pos = [x * MOLECULE_SIZE, y * MOLECULE_SIZE]
      @position = [x, y]
    end

    def where_is_the_pointer?
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

    def pointer_at_south
      @pointer.x == body.x and @pointer.y > body.y
    end

    def pointer_at_north
      @pointer.x == body.x and @pointer.y < body.y
    end

    def pointer_at_east
      @pointer.x > body.x and @pointer.y == body.y
    end

    def pointer_at_west
      @pointer.x < body.x and @pointer.y == body.y
    end

    def pointer_at_south_east
      @pointer.x > body.x and @pointer.y > body.y
    end

    def pointer_at_north_east
      @pointer.x > body.x and @pointer.y < body.y
    end

    def pointer_at_south_west
      @pointer.x < body.x and @pointer.y > body.y
    end

    def pointer_at_north_west
      @pointer.x < body.x and @pointer.y < body.y
    end

    def here
      @pointer.x == body.x and @pointer.y == body.y
    end
  end
end