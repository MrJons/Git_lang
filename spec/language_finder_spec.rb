require "language_finder.rb"

describe LanguageFinder do

  context "app works as intended" do
    it "Should output best guess at main language" do

      stub_request(:get, "https://api.github.com/users/testuser/repos").
        to_return(status: 200, body: '[{
            "name": "test1",
            "language": "Ruby"
          },{
            "name": "test2",
            "language": "Ruby"
          },{
            "name": "test3",
            "language": "Java"
          }]',headers: {})

      testuser = LanguageFinder.new('testuser')
      EXPECTED_OUTPUT = "Ruby is used most frequently by testuser - 2 times in fact."
      expect(testuser.top_language).to eq(EXPECTED_OUTPUT)
    end

    it "should return 'provide username' prompt if username not given" do
      blank = LanguageFinder.new(nil)
      ERROR = "Please enter a Github username after launching app - eg. 'ruby lang.rb username'\n"
      expect{blank.top_language}.to output(ERROR).to_stdout
    end
  end
end
