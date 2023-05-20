require 'todo_list'

RSpec.describe TodoList do
    it "given no tasks has an empty list" do
        todo_list = TodoList.new
        expect(todo_list.list).to eq []
    end

    it "when given a task, puts the task in list" do
        todo_list = TodoList.new
        todo_list.add("Do the laundry")
        expect(todo_list.list).to eq ["Do the laundry"]
    end

    it "when given two tasks they are both added to the list" do
        todo_list = TodoList.new
        todo_list.add("Do the laundry")
        todo_list.add("Go to the gym")
        expect(todo_list.list).to eq ["Do the laundry", "Go to the gym"]
    end

    it "when given a task to complete it removes it from the list" do
        todo_list = TodoList.new
        todo_list.add("Do the laundry")
        todo_list.add("Go to the gym")
        todo_list.complete("Do the laundry")
        expect(todo_list.list).to eq ["Go to the gym"]
    end
   
    it "fails when asked to complete a task that is not on the list" do
        todo_list = TodoList.new
        todo_list.add("Do the laundry") 
        expect{ todo_list.complete("Go to the gym") }.to raise_error "No such task."
    end

end