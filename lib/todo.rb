class Todo
    def initialize(task) 
      fail "Please enter a task to add to the list" if task.empty?
      @todo = task
    end
  
    def task
      @todo
    end
end  