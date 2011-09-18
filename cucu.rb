diff --git a/lib/pugnacious/molecule.rb b/lib/pugnacious/molecule.rb
index a03698d..07e0040 100644
--- a/lib/pugnacious/molecule.rb
+++ b/lib/pugnacious/molecule.rb
@@ -1,18 +1,30 @@
 module Pugnacious
   class Molecule
-    attr_accessor :player, :life, :body, :molecules, :pointer
+    attr_accessor :player, :life, :body, :molecules, :pointer, :position, :game_map
         
     SIZE = 3
     SPEED = 4
-    POSSIBLE_MOVEMENTS = [:up, :up_right, :right, :down_right, :down, :down_left, :left, :up_left, :up, :up_right ]
+    DIRECTIONS = {:up => [0, -1] , 
+      :up_right => [1, -1], 
+      :right => [1, 0], 
+      :down_right => [1, 1], 
+      :down => [0, 1], 
+      :down_left => [-1, 1], 
+      :left => [-1, 0], 
+      :up_left => [-1, -1]}
+    
     
     def initialize(options = {})
       @player = options[:player]
+      @game_map = options[:map]                                               
+      @position = options[:pos]
+      @game_map[@position[0]][@position[1]] = self
       @life = 100                       
       @body = Ray::Polygon.rectangle([0,0,SIZE,SIZE], @player.color)
-      @body.pos = options[:pos] || [0, 0]
+      @body.pos = [options[:pos][0] * SIZE, options[:pos][1] * SIZE] || [0, 0]      
       @molecules = options[:molecules]
       @pointer = @player.pointer
+      
     end                                      
                   
     def move                   
@@ -20,9 +32,10 @@ module Pugnacious
     end
     
     def try_to_go(direction)                                                  
-      intention = POSSIBLE_MOVEMENTS.index(direction)                                                           
+      intention = POSSIBLE_MOVEMENTS.index(direction)
       
       if can_i_move_there?(POSSIBLE_MOVEMENTS[intention])
+        @game_map = [@position[0]][@position[1]] = :empty
         move_there!(POSSIBLE_MOVEMENTS[intention])           
       elsif can_i_move_there?(POSSIBLE_MOVEMENTS[intention+1])
         move_there!(POSSIBLE_MOVEMENTS[intention+1])        
@@ -35,143 +48,39 @@ module Pugnacious
       end              
     end    
     
-    def can_i_move_there?(direction)       
-      pos = move_there(direction)
-      do_i = Ray::Rect.new(pos.x, pos.y, SIZE, SIZE)
-            
-      @molecules.none? do |m|
-        collision = false 
-        if m != self          
-          with_this_molecule = Ray::Rect.new(m.body.pos.x, m.body.pos.y, SIZE, SIZE)
-          collision = do_i.collide?(with_this_molecule)
-        end
-        collision
-      end                       
+    def can_i_move_there?(direction)           
+      xw, yw =  + DIRECTIONS[direction]    
+      
+      x = xw + @position[0]
+      y = yw + @position[1]                       
+      
+      if @game_map[y][x] == :empty
+        return true
+      else
+        return false
+      end
+    end
+    
+    def direction_of_pointer
+      x, y = [@pointer.x / SIZE, @pointer.y / SIZE]            
     end       
     
     
     #####################
     # Move the molecule
-    #####################    
-        
-    # Simulates the movement
-    def move_there(movement)  
-      self.send(:"move_#{movement}")
-    end
+    #####################            
     
     # Move it
-    def move_there!(movement)
-      pos = self.send(:"move_#{movement}")
-      body.pos = pos
-    end
-    
-    def move_up
-      pos = body.pos
-      pos.y -= SPEED
-      pos
-    end   
-    
-    def move_down
-      pos = body.pos
-      pos.y += SPEED      
-      pos
-    end     
-    
-    def move_right                     
-      pos = body.pos
-      pos.x += SPEED
-      pos
-    end      
-    
-    def move_left      
-      pos = body.pos
-      pos.x -= SPEED
-      pos
-    end     
-    
-    def move_up_right                  
-      pos = body.pos
-      pos.y -= SPEED
-      pos.x += SPEED                      
-      pos
-    end         
-    
-    def move_up_left
-      pos = body.pos
-      pos.x -= SPEED
-      pos.y -= SPEED        
-      pos
-    end        
-    
-    def move_down_right
-      pos = body.pos
-      pos.y += SPEED
-      pos.x += SPEED
-      pos
-    end           
-    
-    def move_down_left    
-      pos = body.pos
-      pos.x -= SPEED
-      pos.y += SPEED              
-      pos
-    end            
-               
-    #######################
-    # Where is the pointer?
-    #######################    
-    
-    def where_is_the_pointer?
-      if pointer_is_down then return :down end
-      if pointer_is_up then return :up end
-      if pointer_is_right then return :right end
-      if pointer_is_left then return :left end
-      if pointer_is_down_right then return :down_right end
-      if pointer_is_up_right then return :up_right end
-      if pointer_is_down_left then return :down_left end
-      if pointer_is_up_left then return :up_left end
-      if here then return :here end
-    end
-           
-    def pointer_is_down      
-      #(@pointer.x-SIZE..@pointer.x+SIZE).cover?(body.x) and @pointer.y > body.y      
-      @pointer.x == body.x and @pointer.y > body.y      
-    end
-    
-    def pointer_is_up                                                                                      
-      #(@pointer.x-SIZE..@pointer.x+SIZE).cover?(body.x) and @pointer.y < body.y
-      @pointer.x == body.x and @pointer.y < body.y      
-    end
-    
-    def pointer_is_right      
-      #@pointer.x > body.x and (@pointer.y-SIZE..@pointer.y+SIZE).cover?(body.y)
-      @pointer.x > body.x and @pointer.y == body.y      
-    end
-    
-    def pointer_is_left
-      #@pointer.x < body.x and (@pointer.y-SIZE..@pointer.y+SIZE).cover?(body.y)
-      @pointer.x < body.x and @pointer.y == body.y      
-    end   
-    
-    def pointer_is_down_right 
-      @pointer.x > body.x and @pointer.y > body.y      
-    end     
-    
-    def pointer_is_up_right
-      @pointer.x > body.x and @pointer.y < body.y      
-    end
-    
-    def pointer_is_down_left
-      @pointer.x < body.x and @pointer.y > body.y
-    end  
-    
-    def pointer_is_up_left
-      @pointer.x < body.x and @pointer.y < body.y
-    end            
-    
-    def here                                       
-      #(@pointer.x-SIZE..@pointer.x+SIZE).cover?(body.x) and (@pointer.y-SIZE..@pointer.y+SIZE).cover?(body.y)
-      @pointer.x == body.x and @pointer.y == body.y
-    end
+    def move_there!(movement) 
+      xw, yw =  + DIRECTIONS[direction]    
+      
+      x = (xw + @position[0]) * SIZE
+      y = (yw + @position[1]) * SIZE
+      
+      @game_map[x][y] = :empty            
+                
+      body.pos = [y, x]
+      @position = [x, y]      
+    end                              
   end
 end
\ No newline at end of file
