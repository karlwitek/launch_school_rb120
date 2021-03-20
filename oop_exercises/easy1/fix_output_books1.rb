# complete this program so that it produces the expected ouput:
# expected output:

# The author of "Snow Crash" is Neil Stephenson.
# book = "Snow Crash", by Neil Stephenson.


class Book
  #attr_accessor :author, :title

  def initialize(author, title)
    @author = author
    @title = title
  end

  def title
    @title
  end

  def author
    @author
  end

  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new("Neil Stephenson", "Snow Crash")
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)

# Fix: needs getter and setter methods for author , title.

# The author of "Snow Crash" is Neil Stephenson.
# book = "Snow Crash", by Neil Stephenson.

# good. LS:

# called attr_reader :author, :title  instead (don't need a setter method)
# Further: commented out attr_accessor ( should be attr_reader), and added def author .. @author.end instead.
# works as well.
# possible advantages to this code: extra functionality.. ?


