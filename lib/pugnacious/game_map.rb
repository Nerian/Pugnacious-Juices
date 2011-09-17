module Pugnacious
  class GameMap    
    attr_accessor :map
    
    def initialize(number_of_lines, number_of_columns)                        
      generate_empty_map(number_of_lines, number_of_columns)      
    end                                                     
   
    def self.generate_empty_map(number_of_lines, number_of_columns)
      game_map = []
      (number_of_columns/MOLECULE_SIZE).times do |l|
        game_map << []
        (number_of_lines/MOLECULE_SIZE).times do |c|
          game_map[l][c] = :empty
        end
      end         
      game_map
    end 
    
  end
end