require 'diary'

RSpec.describe Diary do
    it "initializes with empty list" do
        diary_entry = Diary.new
        expect(diary_entry.all).to eq []
    end

    it "has an initial word count of 0" do
        diary = Diary.new
        expect(diary.count_words).to eq 0
    end

    it "has an initial reading time of 0" do
        diary = Diary.new
        expect(diary.reading_time(2)).to eq 0
    end

end
