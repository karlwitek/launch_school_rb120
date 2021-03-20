# complete the class so that the test cases below work as intended. You are free to add any
# methods or instance variables you need.  However, do not make the implementation details
# public.  You may assume that the input will always fit in your terminal window.


class Banner
  def initialize(message)
    @message = message
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end

  private

  def horizontal_rule
    "-" * (@message.length.to_i + 4)
  end

  def empty_line
    "|" + ' ' * (@message.length.to_i + 2) + "|"
  end

  def message_line
    "| #{@message} |"
  end
end

banner = Banner.new('sample string')
puts banner

banner2 = Banner.new('To go boldly where no one has gone before')
puts banner2

# Further:  Modify this class so new will optionally let you specify a fixed banner width at the time the Banner
# object is created.  The message in the banner should be centered within the banner of that width. Decide for 
# yourself how you want to handle widths that are either too narrow or too wide.

