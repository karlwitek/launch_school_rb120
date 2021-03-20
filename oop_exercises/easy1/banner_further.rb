# Further:  Modify this class so new will optionally let you specify a fixed banner width at the time the Banner
# object is created.  The message in the banner should be centered within the banner of that width. Decide for 
# yourself how you want to handle widths that are either too narrow or too wide.


class Banner
  def initialize(message, width=message.length + 2)
    @message = message
    @width = width
  end

  def to_s
    if @width > @message.length + 1
      [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
    else
      "Not wide enough for message."
    end
  end

  private

  def horizontal_rule
    "-" * (@width + 4)
  end

  def empty_line
    "|" + ' ' * (@width + 2) + "|"
  end

  def message_line
    "| #{@message.center(@width)} |"
  end
end

banner = Banner.new('word', 68)
puts banner

banner2 = Banner.new('A much longer string', 100)
puts banner2
