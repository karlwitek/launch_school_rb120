# complete the program so that is produces the expected output:
# expected output:

# The author of "Snow Crash" is Neil Stephenson.
# book = "Snow Crash", by Neil Stephenson.
# needs getter and setter methods. (attr_accessor)


class Book
  attr_accessor :title, :author

  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new
book.author = "Neil Stephenson"
book.title = "Snow Crash"
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)# calling instance to_s

# The author of "Snow Crash" is Neil Stephenson.
# book = "Snow Crash", by Neil Stephenson.

# good . LS :

# Further: 
# What do you think of this way of creating and initializing Book objects?
# (The two steps are separate.) Would it be better to create and initialize at
# the same time like in the previous exercise? What potential problems, if any,
# are introduced by separating the steps?

# the potential problems may be that is easy to change the state of the object.

# the setter method is public. may cause problems.
# may want to validate the input when setting the state.(better to do it inside the class)

