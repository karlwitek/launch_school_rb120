class TaskManager
  attr_reader :owner
  attr_accessor :tasks

  def initialize(owner)
    @owner = owner
    @tasks = []
  end

  def add_task(name, priority=:normal)
    task = Task.new(name, priority)
    tasks.push(task)
  end

  def complete_task(task_name)
    completed_task = nil

    tasks.each do |task|
      completed_task = task if task.name == task_name
    end

    if completed_task
      tasks.delete(completed_task)
      puts "Task '#{completed_task.name}' complete! Removed from list."
    else
      puts "Task not found."
    end
  end

  def display_all_tasks
    display(tasks)
  end

  def display_high_priority_tasks
    tasks = @tasks.select do |task|# works, but see explanation/LS solution below
      task.priority == :high
    end

    display(tasks)
  end

  private

  def display(tasks)
    puts "--------"
    tasks.each do |task|
      puts task
    end
    puts "--------"
  end
end

class Task
  attr_accessor :name, :priority

  def initialize(name, priority=:normal)
    @name = name
    @priority = priority
  end

  def to_s
    "[" + sprintf("%-6s", priority) + "] #{name}"
  end
end

valentinas_tasks = TaskManager.new('Valentina')

valentinas_tasks.add_task('pay bills', :high)
valentinas_tasks.add_task('read OOP book')
valentinas_tasks.add_task('practice Ruby')
valentinas_tasks.add_task('run 5k', :low)

valentinas_tasks.complete_task('read OOP book')

valentinas_tasks.display_all_tasks
valentinas_tasks.display_high_priority_tasks

# error is raised. find the bug and fix it.

# try @tasks.select instead of tasks = tasks.select..  (this is calling #select on uninitialized local variable)
# (good output) LS: 

# def display_high_priority_tasks
#   high_priority_tasks = tasks.select do |task|
#     task.priority == :high
#   end

#   display(high_priority_tasks)
# end

# When attempting to invoke the tasks getter method in the code tasks.select, we are unintentionally
# referencing a local variable tasks.  Since it has not yet been assigned a value, its value is nil.
# 'tasks' on the left side of the = (in principle) could be a setter method or a local variable 
# assignment.  (would need self.) if invoking the setter. Next, Ruby must diambiguate the reference
# to tasks on the right side of the assignment operator (tasks.select). At this point, the getter
# method is shadowed by the local variable that was just initialized on the left side side.
# This shadowing is also at work in the private display method, where tasks in the method body refers
# to the method parameter, not the getter method.  As a result, both references to tasks (35) are
# interpreted as a local variable.  This means that we initialize a local variable, and on the same
# line reference it via tasks.select, before it has been assigned a value. Invoking the select method
# on nil caused the error.  Best to give our local variable a unique name. That way, it does not shadow
# the getter method. This is also in line with Ruby style guide: 'avoid shadowing methods with local
# variables unless they are both equivalent'
