# Pugnacious Juices

Two or more liquid battle agains each other for dominance.

# Game Play

The player directs a liquid mass in an effort to assimilate other's player liquid masses.

The player who assimilates all the liquid in the map is the winner.

A player controls the movement of the liquid by moving a pointer. The liquid mass moves to where the pointer is at.

The liquid mass is not a single entity, but it is composed of smaller units. Fighters.

Two fighters of rival teams fight when they collide.

All fighters are always moving – or wanting to move – in any of these directions: 0º 45º 90º 135º 180º 225º 270º 315º 360º

The outcome of two fighters match is determined by who is colliding with more force. For example:

A ->    <- B       Same force, there is not a winner.

A ->   -> B         A wins.  

When a fighter loses the battle he becomes part of the winner's army. 

 
                     
# Install  

``` ruby
Mac OS
                    
brew install libsndfile glew
gem install pugnacious_juices

Linux 
apt-get install libsndfile freetype2 openal
gem install pugnacious_juices
```       

# Play

``` bash    
$ pugnacious

$ pugnacious 500  # 500 molecules in the game
```

# Development

``` ruby     
git clone https://Nerian@github.com/Nerian/Pugnacious-Juices.git        
cd Pugnacious-Juices
rake osx_install
gem install ray # or bundle install  
ruby bin/pugnacious.rb
```
