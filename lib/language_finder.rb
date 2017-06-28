require 'faraday'
require 'json'

class LanguageFinder

  def initialize(user)
    @user = user
  end

  def top_language
    if input_handler == true
      language_list = get_languages
      top_lang = language_list.last
      "#{top_lang[0]} is used most frequently by #{@user} - #{top_lang[1]} times in fact."
    end
  end

  private

  def github_url
    "https://api.github.com/users/#{@user}/repos"
  end

  def get_api_data
    response = Faraday.get(github_url)
    JSON.parse(response.body)
  end

  def get_languages
    repos = get_api_data
    languages = {}

    repos.each do |repo|
      lang = repo['language']
      languages.include?(lang) ? languages[lang] += 1 : languages[lang] = 1
    end
    languages.sort_by{|lang,count| count }
  end

  def input_handler
    if @user == nil
      begin
        raise StandardError
      rescue
        puts INPUT_ERRORS[:no_user]
      end
    else
      true
    end
  end

  INPUT_ERRORS = {
    no_user: "Please enter a Github username after launching app - eg. 'ruby lang.rb username'"
  }

end
