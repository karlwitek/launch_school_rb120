# Need to modify this class so any access to data must result in a log entry being 
# generated. Hint: Assume that you can modify the initialize method in SecretFile to 
# have an instance of SecurityLogger be passed in as an additional argument.
# assume SecurityLogger exists.

class SecretFile
  attr_reader :data

  def initialize(secret_data, object)
    @data = secret_data
    @logger = object
  end
end

# LS: (I left out part of the solution, first part good)

class SecretFile
  attr_reader :data

  def initialize(secret_data, logger)
    @data = secret_data
    @logger = logger
  end
end

# second, need to remove attr_reader and replace it with an explicit implementation of a 
# method that returns the data instance variable. In the new method, can add a call to the
# security logger.

class SecretFile
  def initialize(secret_data, logger)
    @data = secret_data
    @logger = logger
  end

  def data
    @logger.create_log_entry
    @data
  end
end

