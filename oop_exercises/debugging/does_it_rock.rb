class AuthenticationError < Exception; end

# A mock search engine
# that returns a random number instead of an actual count.
class SearchEngine
  def self.count(query, api_key)
    unless valid?(api_key)
      raise AuthenticationError, 'API key is not valid.'
    end

    rand(200_000)
  end

  private

  def self.valid?(key)
    key == 'LS1A'
  end
end

module DoesItRock
  API_KEY = 'FAKE'

  class NoScore; end

  class Score
    def self.for_term(term)
      positive = SearchEngine.count(%{"#{term} rocks"}, API_KEY).to_f
      negative = SearchEngine.count(%{"#{term} is not fun"}, API_KEY).to_f
      puts "inside self.for_term  "# not executed because of error raised above
      positive / (positive + negative)
    # rescue Exception
    #   NoScore
    rescue Exception => e 
      puts e.message
      p positive# outputs nil
    end
  end

  def self.find_out(term)
    score = Score.for_term(term)
    # p "score is :" + score // (this gets rescued by line 54, outputs error msg.)
    puts "score is : #{score}"
    case score
    when NoScore
      "No idea about #{term}..."
    when 0...0.5
      "#{term} is not fun."
    when 0.5
      "#{term} seems to be ok..."
    else
      "#{term} rocks!"
    end
  rescue Exception => e
    e.message
  end
end

# Example (your output may differ)

puts DoesItRock.find_out('Sushi')       # Sushi seems to be ok...
puts DoesItRock.find_out('Rain')        # Rain is not fun.
puts DoesItRock.find_out('Bug hunting') # Bug hunting rocks!

# my answer: (Not accurate)
# does not output 'API key is not valid' because in self.for_term (Score class method), the rescue
# keyword is rescuing Exception , not AuthenticationError and does not call puts e.message.(NO)
# Also, rocks! is displayed because self.count in SearchEngine does not return a random number 
# because an error is raised. (API key is not valid). The self.count method stops executing.
# Therefore, self.count returns nil. In self.find_out (class Score), the local variable used in the case
# statement gets assigned the value nil. In the case statement, 'else' gets executed resulting in
# rocks! for each return value of self.find_out.

# answer is not accurate. rescue Exception(does) / puts e.message outputs 'API key is not valid'.
# LS:
# The unintended behavior is caused by two independent issues:
# The AuthenticationError is raised, but the Score::for_term method catches it, so it never
# reaches the DoesItRock::find_out method.
# 2) When the return value of Score::for_term is NoScore, the case statement in DoesItRock::find_out
# does not behave as expected.

# In addition, we inherit from and rescue Exception(s). This does not influence the behavior of our
# code directly, but it is highly discouraged.

# class Score
#   def self.for_term(term)
#     positive = SearchEngine.count(%{"#{term} rocks"}, API_KEY).to_f
#     negative = SearchEngine.count(%{"#{term} is not fun"}, API_KEY).to_f

#     positive / (positive + negative)
#   rescue ZeroDivisionError
#     NoScore.new
#   end
# end
# omitted code: in self.find_out (case statement)

# else
#   "#{term} rocks!"
# end
# rescue StandardError => e
# e.message
# end
# The SearchEngine indeed raises an AuthenticationError, but it never reaches the DoesItRock::find_out
# method, because Score::for_term already catches it, resulting in the return value NoScore.

# But if the return value NoScore, why does the find_out method not print the message "No idea about.."
# It's because of how case statements work.  The value of score(local var) will be compared with each
# value in the when clauses using the === operator.  In case of the first when clause, the comparison
# is NoScore === score, and since the left-hand side is a class, its implementation boils down to
# checking whether score is_a? NoScore.  This yields false when score has the value NoScore, as it is 
# not an instance of the NoScore class.  As a result, we end up with the value of the else clause.

