require "language_finder.rb"

describe LanguageFinder do

  context "app works as intended" do
    it "Should output best guess at main language" do
      mrjons = LanguageFinder.new('mrjons')
      EXPECTED_OUTPUT = "Ruby is used most frequently by mrjons - 14 times in fact."
      expect(mrjons.print_top_language).to eq(EXPECTED_OUTPUT)
    end

    it "should return 'provide username' prompt if username not given" do
      blank = LanguageFinder.new(nil)
      ERROR = "Please enter a Github username after launching app - eg. 'ruby lang.rb username'\n"
      expect{blank.print_top_language}.to output(ERROR).to_stdout
    end
  end

end
