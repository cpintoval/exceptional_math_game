# This is the main entrypoint into the program
# It requires the other files/gems that it needs

require 'colorize'
require './logic'
require './player'
require './invalid_guess_error'

def play
  puts "*************************************************************************".yellow
  puts "                        LET'S GET READY TO RUMBLE!                       ".yellow
  while(@players[0].lives > 0 && @players[1].lives > 0)
    puts "- #{@players[@actual_player - 1].name}: #{generate_question}"
    while true
      begin
        print "Answer: "
        answer = gets.chomp
        puts verify_answer(answer) ? "- That's correct! You got 1 point!".green : "- Too bad, right answer is #{@actual_answer}. Lost 1 life.".red
        break
      rescue Exception => e
        puts "#{e.class}: #{e.message} - Try again".red
      end
    end
    puts "-------------------------------------------------------------------------".yellow
    next_turn
  end
  # Game ended. Display who won and scores
  puts "                           Round Finished                                ".yellow
  puts "- #{get_loser} lost all his lives!"
  puts "~~~ Scores ~~~".yellow
  puts "- #{@players[0].name}: #{@players[0].score} points."
  puts "- #{@players[1].name}: #{@players[1].score} points."
end

puts "************************  Multiplayer Math Game  ************************".yellow
puts "- Let's start by selecting your names..."
while true
  begin
    puts "- Player 1 enter your name: "
    p1_name = gets.chomp
    verify_name(p1_name)
    @players[0].name = p1_name
    puts "- Welcome to the game #{@players[0].name}!"
    break
  rescue Exception => e
    puts "#{e.class}: #{e.message} - Try again".red
  end
end

while true
  begin
    puts "- Player 2 enter your name: "
    p2_name = gets.chomp
    verify_name(p2_name)
    @players[1].name = p2_name
    puts "- Welcome to the game #{@players[1].name}!"
    break
  rescue Exception => e
    puts "#{e.class}: #{e.message} - Try again".red
  end
end

while true
  play
  puts "- Wanna play again? (yes/no)".yellow
  cmd = gets.chomp
  if cmd.downcase == 'no'
    puts "- No problem! Come back later for more Math Fun! Bye! :)".yellow
    break
  elsif cmd.downcase == 'yes'
    restart_lives
  else
    puts "- Oh, oh...you broke the game, dude!".red
    break
  end
end
