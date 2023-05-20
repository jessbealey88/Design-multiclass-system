require 'diary'
require 'diary_entry'
require 'phonenumber_extractor'

RSpec.describe "integration" do
    it "lists added diary entries" do
        diary = Diary.new
        diary_entry = DiaryEntry.new("my_title", "my_contents")
        diary.add(diary_entry)
        expect(diary.all).to eq [diary_entry]
    end

    it "lists multiple added diary entries" do 
        diary = Diary.new
        diary_entry_1 = DiaryEntry.new("my_title_1", "my_contents_1")
        diary.add(diary_entry_1)
        diary_entry_2 = DiaryEntry.new("my_title_2", "my_contents_2")
        diary.add(diary_entry_2)
        expect(diary.all).to eq [diary_entry_1, diary_entry_2]
    end

    describe "word counting behaviour" do
        it "counts the words in all entries" do
            diary = Diary.new
            diary_entry_1 = DiaryEntry.new("my_title_1", "one two")
            diary_entry_2 = DiaryEntry.new("my_title_2", "three four five")
            diary.add(diary_entry_1)
            diary.add(diary_entry_2)
            expect(diary.count_words).to eq 5
        end
    end

    describe "reading time behaviour" do
        it "fails when wpm is 0" do
            diary = Diary.new
            diary_entry_1 = DiaryEntry.new("my_title_1", "one two")
            diary.add(diary_entry_1)
            expect{ diary.reading_time(0) }.to raise_error "WPM must be positive."
        end  

        it "calculates reading time for all entries where time fits exactly" do
            diary = Diary.new
            diary_entry_1 = DiaryEntry.new("my_title_1", "one two three")
            diary_entry_2 = DiaryEntry.new("my_title_2", "four five six")
            diary.add(diary_entry_1)
            diary.add(diary_entry_2)
            expect(diary.reading_time(2)).to eq 3
        end

        it "calculates reading time for all entries where time doesn't fit exactly" do
            diary = Diary.new
            diary_entry_1 = DiaryEntry.new("my_title_1", "one two")
            diary_entry_2 = DiaryEntry.new("my_title_2", "three four five")
            diary.add(diary_entry_1)
            diary.add(diary_entry_2)
            expect(diary.reading_time(2)).to eq 3
        end
    end

    describe "reading time entry behaviour" do
        it "fails where wpm is 0" do
            diary = Diary.new
            diary_entry_1 = DiaryEntry.new("my_title_1", "one two")
            diary.add(diary_entry_1)
            expect{ diary.find_best_entry_for_reading_time(0,1)}.to raise_error "WPM must be positive."
        end
        it "returns entry where we have just one entry and it is readable in the time" do
            diary = Diary.new
            diary_entry_1 = DiaryEntry.new("my_title_1", "one two")
            diary.add(diary_entry_1)
            expect(diary.find_best_entry_for_reading_time(2,1)).to eq diary_entry_1
        end

        it "returns nil where we have just one entry and it is unreadable in the time" do
            diary = Diary.new
            diary_entry_1 = DiaryEntry.new("my_title_1", "one two three")
            diary.add(diary_entry_1)
            expect(diary.find_best_entry_for_reading_time(2,1)).to eq nil
        end

        it "returns the longest entry the user could read in the time where there are multiple entries" do
            diary = Diary.new
            diary_entry_1 = DiaryEntry.new("my_title_1", "one two")
            diary.add(diary_entry_1)
            diary.add(DiaryEntry.new("my_title_1", "one"))
            diary.add(DiaryEntry.new("my_title_1", "one two three"))
            diary.add(DiaryEntry.new("my_title_1", "one two three four"))
            expect(diary.find_best_entry_for_reading_time(2,1)).to eq diary_entry_1
        end    
    end

    describe "phone number extraction behaviour" do
        it "extracts phone numbers from all diary entries" do
            diary = Diary.new
            phone_book = PhonenumberExtractor.new(diary)
            diary.add(DiaryEntry.new("title0","my friend is cool"))
            diary.add(DiaryEntry.new("title1","my friend 07800000000 is cool"))
            diary.add(DiaryEntry.new("title0","my friends 07800000000, 07800000001, 07800000002 are cool"))
            expect(phone_book.extract_numbers).to eq [
                "07800000000",
                "07800000001",
                "07800000002"
            ]
        end

        it "doesn't extract invalid numbers" do
            diary = Diary.new
            phone_book = PhonenumberExtractor.new(diary)
            diary.add(DiaryEntry.new("title0","my friends 078000000, 780000000111, 08000000010 are cool"))
            expect(phone_book.extract_numbers).to eq []
        
        end
    
    end
            

end