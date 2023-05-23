#RNGguesser by AKYUH && FURRO404
#fuckthis

defmodule Game do    
    def start(hs, score) do
        tries_left = 3
        random_number = Enum.random(1..5)

        IO.puts("Guess a number between 1 and 10, you have #{tries_left} tries!\nHigh score = #{hs}\nCurrent score = #{score}\n")
        
        user = IO.gets("Enter a number: ") 
            |> Float.parse 
            |> elem(0)
            
        case random_number == user do
            true -> IO.puts("#{IO.ANSI.green()}You guessed right good job!#{IO.ANSI.reset()}\n\n")
                score = score + 1
                Game.start(hs, score)
            
            false -> tries_left = tries_left - 1
                IO.puts("Wrong, you have #{tries_left} tries left, Try again!\n")
                tryagain(hs, score, random_number, tries_left)
        end
    end
    
    def tryagain(hs, score, random_number, tries_left) do
        user = IO.gets("Enter a number: ") 
            |> Float.parse 
            |> elem(0)
        
        case random_number == user do
            true -> IO.puts("#{IO.ANSI.green()}You guessed right good job!#{IO.ANSI.reset()}\n\n")
                score = score + 1
                Game.start(hs, score)
            
            false -> tries_left = tries_left - 1

            case tries_left == 1 do
                true -> IO.puts("Wrong, you have #{tries_left} try left, Try again!\n")
                false -> IO.puts("Wrong, you have #{tries_left} tries left, Try again!\n")
            end
            
            case tries_left < 1 do
                true -> 
                    case score > hs do
                        true -> IO.puts("#{IO.ANSI.red()}Game Over!#{IO.ANSI.reset()}")
                                IO.puts("Number was #{random_number}\nNEW HIGH SCORE = #{score}")
                                content = Integer.to_string(score)
                                File.write("score.txt", content)
                        false -> IO.puts("#{IO.ANSI.red()}Game Over!#{random_number}#{IO.ANSI.reset()}")
                                IO.puts("High score = #{hs}\nScore: #{score}")
                    end
                false -> tryagain(hs, score, random_number, tries_left)
            end
        end
    end
end

filepath = "score.txt"
hs = File.read(filepath) |> elem(1) |> String.to_integer()

IO.puts("RNG Guessing Game!\n")
score = 0
Game.start(hs, score)
