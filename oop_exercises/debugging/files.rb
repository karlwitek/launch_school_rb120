class File
  attr_accessor :name, :byte_content

  def initialize(name)
    @name = name
  end

  alias_method :read,  :byte_content
  alias_method :write, :byte_content=

  def copy(target_file_name)
    target_file = self.class.new(target_file_name)
    target_file.write(read)

    target_file
  end

  def to_s
    "#{name}.#{self.class::FORMAT}"
  end
end

class MarkdownFile < File
  FORMAT = :md
end

class VectorGraphicsFile < File
  FORMAT = :svg
end

class MP3File < File
  FORMAT = :mp3
end

# Test

blog_post = MarkdownFile.new('Adventures_in_OOP_Land')
blog_post.write('Content will be added soon!')#.bytes)

copy_of_blog_post = blog_post.copy('Same_Adventures_in_OOP_Land')

puts copy_of_blog_post.is_a? MarkdownFile     # true
puts copy_of_blog_post.read == blog_post.read # true / this is true because it is a copy (same object) and byte_content is overwritten.

# true // Not sure about overwritten. That's the name.  'Adventures_in_OOP_Land' write/read refers to the content. check below:
# true
# Adventures_in_OOP_Land.md

puts blog_post
p blog_post.read
# [67, 111, 110, 116, 101, 110, 116, 32, 119, 105, 108, 108, 32, 98, 101, 32, 97, 100, 100, 101, 100, 32, 115, 111, 111, 110, 33]
# bytes of each character?  total is 27.
# "Content will be added soon!"  // output if remove .bytes in passed in argument.



# Get a NameError. (uninitialized constant File::FORMAT). Problem? Fix?
# The problem is in #to_s. Need to specify where to look for FORMAT (self.class::FORMAT)
# LS: in File#to_s. When ruby resolves a constant, it looks up in it lexical scope, in this case
# in the File class as well in all of its ancestor classes. It doesn't find them, throws a 
# NameError.  Could define #to_s in each of the sub-classes. (not DRY). Alternatively, can add
# explicit namespacing by prepending the class name.  Which class? This will be determined by
# the subclass from which we are calling #to_s. Can reference this sub-class as self.class
# (the class of the caller of the method (blog_post in our example). Using self.class offers the
# same flexibility that we use on line 12 when creating a new instance of the subclass from which
# we are calling new.

# class MarkdownFile < File
#   def format
#     :md
#   end
# end

# Another example would be to use a method instead of a constant. (above)
# Could also use an instance variable to store the format, although this doesn't convey the fact that
# the format of a particular file is fixed and cannot change.  Which option you pick is mainly a 
# design choice.
# Finally, this example is for illustration purposes. Ruby has a File class and there is no good 
# reason to write one ourselves.
# FE: Review Docs: Module#alias_method.
