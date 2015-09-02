class Player

  attr_accessor :name, :lives, :id, :score

  def initialize(name, id)
    @name = name
    @id = id
    @lives = 3
    @score = 0
  end

  def gain_point
    @score += 1
  end

  def lose_life
    @lives -= 1
  end

end