module Pugnacious
  class GameMap

    def self.generate_empty_map(number_of_lines, number_of_columns)
      game_map = []
      (number_of_columns/MOLECULE_SIZE).times do |l|
        game_map << []
        (number_of_lines/MOLECULE_SIZE).times do |c|
          game_map[l][c] = [l, c]
        end
      end
      game_map
    end

    def self.generate_molecules(map, player1, player2, number)
      molecules = []

      positions = map.flatten(1).sample(number)

      positions[0..(number/2)].each do |p|
        molecules << Molecule.new(
          :player    => player1,
          :rival     => player2,
          :molecules => molecules,
          :pos       => p,
          :map       => map)
      end 

      positions[(number/2)..number].each do |p|
        molecules << Molecule.new(
          :player    => player2,
          :rival     => player1,
          :molecules => molecules,
          :pos       => p,
          :map       => map)
      end
      
      map.each do |l|
        l.each_with_index do |c, index| 
          if c.kind_of?(Array)
            l[index] = :empty
          end
        end
      end

      molecules
    end
  end
end