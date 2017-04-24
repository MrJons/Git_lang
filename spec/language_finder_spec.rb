require "language_finder.rb"

describe LanguageFinder do

  context "app works as intended" do
    it "Should output best guess at main language" do
      mrjons = LanguageFinder.new('mrjons')
      EXPECTED_OUTPUT = "Ruby is used most frequently by mrjons - 13 times in fact."
      expect(mrjons.print_top_language).to eq(EXPECTED_OUTPUT)
    end

    it "should return 'provide username' prompt if username not given" do
      blank = LanguageFinder.new(nil)
      ERROR = "Please enter a Github username after launching app - eg. 'ruby ./lib/language_finder.rb username'"
      expect{blank.print_top_language}.to raise_error(ERROR)
    end
  end

end
