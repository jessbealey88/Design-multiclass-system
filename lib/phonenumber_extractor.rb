class PhonenumberExtractor

  def initialize(diary)
    @diary = diary
  end

  def extract_numbers
    @diary.all.flat_map do |entry|
        extract_numbers_from_entry(entry)
    end.uniq
  end

  private

  def extract_numbers_from_entry(entry)
    return entry.contents.scan(/07[0-9]{9}/)
  end


end