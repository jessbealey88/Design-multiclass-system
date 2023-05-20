## 1. Describe the Problem

>As a user
>So that I can record my experiences
>I want to keep a regular diary

>As a user
>So that I can reflect on my experiences
>I want to read my past diary entries

>As a user
>So that I can reflect on my experiences in my busy day
>I want to select diary entries to read based on how much time I ?>have and my reading speed

>As a user
>So that I can keep track of my tasks
>I want to keep a todo list along with my diary

>As a user
>So that I can keep track of my contacts
>I want to see a list of all of the mobile phone numbers in all my >diary entries


## 2. Design the Class System
```
┌─────────────────────────┐
│  Diary Entry            │
│                         │
│  Initializes            │
│  (title,contents)       │
│                         │
│  returns title          │
│                         │
│  returns contents       │
│                         │
│                         │
└────────────┬────────────┘
             │
┌────────────▼────────────┐    ┌───────────────────────┐
│                         │    │ Todo List             │
│  Diary                  │    │                       │
│                         │    │ Initializes(blank)    │
│  Initializes(blank)     │    │                       │
│                         │    │ Adds a task           │
│  adds an entry          │    │                       │
│  stores and returns     ◄────┤ returns a list of     │
│  all entries            │    │ tasks                 │
│                         │    │ deletes completed     │
│  finds the best entry   │    │ tasks from the list   │
│  for reading time       │    │                       │
└─────────────┬───────────┘    └───────────────────────┘
              │
 ┌────────────▼───────────┐
 │                        │
 │ Phonenumber extractor  │
 │                        │
 │ Initializes with an    │
 │ instance of diary      │
 │                        │
 │ extracts all phone-    │
 │ numbers from diary     │
 │ and returns them as    │
 │ a list of strings      │
 │                        │
 │                        │
 └────────────────────────┘
```
```ruby


class DiaryEntry

def initialize(title, contents)
end

def title
#returns title
end

def contents
#returns contents
end

end

class Diary

def initialize
#blank array for entries to be added
end

def add(entry) #entry is an instance of diary_entry
# adds entry to the array
end

def all 
#returns all entries
end

def count_words
#returns a word count of entries
end

def reading_time(wpm)
#returns reading time for all entries based on reading speed entered
end

def find_best_entry_for_reading_time(wpm, minutes)
#returns readable entries within the given time based on the reading speed entered
end

end


class TodoList

def intitialize
#a blank list of tasks
end

def add(task) #task is a string
#takes the task entered and adds it to the list
end

def list
#returns the list of tasks
end
 
def complete(task) 
deletes a completes task from the list
end

class PhoneBook

def initialize(diary) #diary is an instance of Diary
end

def extract_numbers
#returns a list of strings representing phone numbers
#gathered from all diary entries
end

end

```

## 3. Create Examples as Integration Tests

_Make a list of examples of what the method will take and return._

```ruby
# 1
diary = Diary.new
diary_entry_1 = DiaryEntry.new("my_title_1", "my_contents_1") diary.add(diary_entry_1)
diary_entry_2= DiaryEntry.new("my_title_2", "my_contents_2")
diary.add(diary_entry_2)
expect(diary.all).to eq [diary_entry_1, diary_entry_2]

#2
diary = Diary.new
diary_entry_1 = DiaryEntry.new("my_title_1", "one two")
diary_entry_2 = DiaryEntry.new("my_title_2", "three four five")
diary.add(diary_entry_1)
diary.add(diary_entry_2)
expect(diary.count_words).to eq 5

#3
diary = Diary.new
diary_entry_1 = DiaryEntry.new("my_title_1", "one two")
diary.add(diary_entry_1)
expect{ diary.reading_time(0) }.to raise_error "WPM must be positive."

#4
diary = Diary.new
diary_entry_1 = DiaryEntry.new("my_title_1", "one two three")
diary_entry_2 = DiaryEntry.new("my_title_2", "four five six")
diary.add(diary_entry_1)
diary.add(diary_entry_2)
expect(diary.reading_time(2)).to eq 3

#5
diary = Diary.new
diary_entry_1 = DiaryEntry.new("my_title_1", "one two")
diary_entry_2 = DiaryEntry.new("my_title_2", "three four five")
diary.add(diary_entry_1)
diary.add(diary_entry_2)
expect(diary.reading_time(2)).to eq 3

#6
diary = Diary.new
diary_entry_1 = DiaryEntry.new("my_title_1", "one two")
diary.add(diary_entry_1)
expect{ diary.find_best_entry_for_reading_time(0,1)}.to raise_error "WPM must be positive."

#7
diary = Diary.new
diary_entry_1 = DiaryEntry.new("my_title_1", "one two")
diary.add(diary_entry_1)
expect(diary.find_best_entry_for_reading_time(2,1)).to eq diary_entry_1
        

#8
diary = Diary.new
diary_entry_1 = DiaryEntry.new("my_title_1", "one two three")
diary.add(diary_entry_1)
expect(diary.find_best_entry_for_reading_time(2,1)).to eq nil

#9
diary = Diary.new
diary_entry_1 = DiaryEntry.new("my_title_1", "one two")
diary.add(diary_entry_1)
diary.add(DiaryEntry.new("my_title_1", "one"))
diary.add(DiaryEntry.new("my_title_1", "one two three"))
diary.add(DiaryEntry.new("my_title_1", "one two three four"))
expect(diary.find_best_entry_for_reading_time(2,1)).to eq diary_entry_1

#10 
diary = Diary.new
phone_book = PhonenumberExtractor.new(diary)
diary.add(DiaryEntry.new("title0","my friend is cool"))
diary.add(DiaryEntry.new("title1","my friend 07800000000 is cool"))
diary.add(DiaryEntry.new("title0","my friends 07800000000, 07800000001, 07800000002 are cool"))
expect(phone_book.extract_numbers).to eq ["07800000000", "07800000001", "07800000002"]

#11
diary = Diary.new
phone_book = PhonenumberExtractor.new(diary)
diary.add(DiaryEntry.new("title0","my friends 078000000, 780000000111, 08000000010 are cool"))
expect(phone_book.extract_numbers).to eq []


```

## 4. Create Examples as unit tests

```ruby
#todo_list_spec
#1
todo_list = TodoList.new
expect(todo_list.list).to eq []

#2
todo_list = TodoList.new
todo_list.add("Do the laundry")
expect(todo_list.list).to eq ["Do the laundry"]

#3
todo_list = TodoList.new
todo_list.add("Do the laundry")
todo_list.add("Go to the gym")
expect(todo_list.list).to eq ["Do the laundry", "Go to the gym"]

#4
todo_list = TodoList.new
todo_list.add("Do the laundry")
todo_list.add("Go to the gym")
todo_list.complete("Do the laundry")
expect(todo_list.list).to eq ["Go to the gym"]

#5
todo_list = TodoList.new
todo_list.add("Do the laundry") 
expect{ todo_list.complete("Go to the gym") }.to raise_error "No such task."

#diary_entry_spec
#1
diary_entry = DiaryEntry.new("my_title", "my_contents")
expect(diary_entry.title).to eq "my_title"

#2
diary_entry = DiaryEntry.new("my_title", "my_contents")
expect(diary_entry.contents).to eq "my_contents"

#3
diary_entry = DiaryEntry.new("my_title", "one two three four five")
expect(diary_entry.count_words).to eq 5

#4
diary_entry = DiaryEntry.new("my_title", "one " * 550)
expect(diary_entry.reading_time(200)).to eq 3

#diary_spec

#1
diary_entry = Diary.new
expect(diary_entry.all).to eq []

#2
diary = Diary.new
expect(diary.count_words).to eq 0

#3
diary = Diary.new
expect(diary.reading_time(2)).to eq 0


```


## 5. Implement the behaviour 