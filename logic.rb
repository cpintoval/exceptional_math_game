# This file contains the actual logic of the Math Game
require './player'
require './invalid_guess_error'
require './invalid_name_error'

# Initializing player's lives
@players = [ Player.new("Player 1", 1), Player.new("Player 2", 2)]
@actual_question = ""
@actual_answer = nil
@actual_player = 1

def generate_question
  operation = Random.rand(1..4)
  num1 = Random.rand(1..20)
  num2 = Random.rand(1..20)
  case operation
  when 1
    # Addition
    @actual_answer = num1 + num2
    "What does #{num1} plus #{num2} equal?"
  when 2
    # Substraction
    @actual_answer = num1 - num2
    "What does #{num1} minus #{num2} equal?"
  when 3
    # Multiplication
    @actual_answer = num1 * num2
    "What does #{num1} times #{num2} equal?"
  when 4
    # Division
    @actual_answer = num1 / num2
    "What does #{num1} divided by #{num2} equal (rounded to the nearest integer)?"
  end
end

def verify_answer(answer)

  if !(/\A[-+]?\d+\z/ === answer)
    raise InvalidGuessError, "Guess is not an Integer"
  end

  answer = answer.to_i
  output = @actual_answer == answer
  if output
    @players[@actual_player - 1].gain_point
  else
    @players[@actual_player - 1].lose_life
  end
  output
end

def verify_name(name)

  if name == ""
    raise InvalidNameError, "Empty name received"
  end

  true

end

def next_turn
  if @actual_player == 1
    @actual_player = 2
  else
    @actual_player = 1
  end
end

def get_loser
  if @players[0].lives == 0
    @players[0].name
  elsif @players[1].lives == 0
    @players[1].name
  else
    "No loser yet"
  end  
end

def restart_lives
  @players[0].lives = 3
  @players[1].lives = 3
end