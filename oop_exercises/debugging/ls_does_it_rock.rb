class AuthenticationError < StandardError; end# 1st change to StandardError, not Exception

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
  API_KEY = 'LS1A'

  class NoScore; end

  class Score
    def self.for_term(term)
      #positive = SearchEngine.count(%{"#{term} rocks"}, API_KEY).to_f
      #negative = SearchEngine.count(%{"#{term} is not fun"}, API_KEY).to_f
      positive = 1
      negative = -1

      positive / (positive + negative)
    # rescue Exception
    #   NoScore // original: (NoScore is a class, ends up left side of when clause)
    rescue ZeroDivisionError# change so 
      NoScore.new
    end
  end

  def self.find_out(term)
    score = Score.for_term(term)# calling a class method. Is it creating an instance also?
          # this becomes the return value of #find_out!!! which was a class, not an instance
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
  # rescue Exception => e
  #   e.message
  rescue StandardError => e 
    e.message
  end
end

# Example (your output may differ)

puts DoesItRock.find_out('Sushi')       # Sushi seems to be ok...
puts DoesItRock.find_out('Rain')        # Rain is not fun.
puts DoesItRock.find_out('Bug hunting') # Bug hunting rocks!

