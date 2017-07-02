require "language_finder.rb"

describe LanguageFinder do

  context "When a valid user is entered" do
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
      RUBY_USED = "Ruby is used most frequently by testuser - 2 times in fact."
      expect(testuser.top_language).to eq(RUBY_USED)
    end
  end

  context "When no username is provided" do
    it "should return 'provide username' prompt" do
      blank = LanguageFinder.new(nil)
      ERROR = "Please enter a Github username after launching app - eg. 'ruby lang.rb username'.\n"
      expect{blank.top_language}.to output(ERROR).to_stdout
    end
  end

  context "When a non-existent user is provided" do
    it "should return 'invalid user' prompt" do

      stub_request(:get, "https://api.github.com/users/invaliduser/repos").
        to_return(status: 404, headers: {"status": "404 Not Found"})

      invalid = LanguageFinder.new('invaliduser')
      NO_USER = "That user does not seem to exist, please try again."
      expect{invalid.top_language}.to output(NO_USER).to_stdout
    end
  end

  context "When a provided user has no repositories" do
    it "Should return 'no repos' prompt" do

      stub_request(:get, "https://api.github.com/users/norepos/repos").
        to_return(status: 200, body: '[]',headers: {})

      no_repos = LanguageFinder.new('norepos')
      NO_REPOS = "That user does not seem to have any repos."
      expect{no_repos.top_language}.to output(NO_REPOS).to_stdout
    end
  end

end
