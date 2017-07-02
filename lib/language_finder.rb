require 'faraday'
require 'json'

class LanguageFinder

  def initialize(user)
    @user = user
  end

  def top_language
    if no_input_check == true
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
    check_status(response.headers)
    JSON.parse(response.body)
  end

  def get_languages
    languages = {}

    repos = get_api_data
    check_for_repos(repos)
    repos.each do |repo|
      lang = repo['language']
      languages.include?(lang) ? languages[lang] += 1 : languages[lang] = 1
    end
    languages.sort_by{|lang,count| count }
  end

  def no_input_check
    if @user == nil
      puts INPUT_ERRORS[:no_user]
    else
      true
    end
  end

  def check_status(api_header)
    if api_header['status'] == '404 Not Found'
      puts INPUT_ERRORS[:invalid_user]
      exit
    end
  end

  def check_for_repos(repo_obj)
    if repo_obj.empty?
      puts INPUT_ERRORS[:no_repos]
      exit
    end
  end

  INPUT_ERRORS = {
    no_user: "Please enter a Github username after launching app - eg. 'ruby lang.rb username'.",
    invalid_user: "That user does not seem to exist, please try again.",
    no_repos: "That user does not seem to have any repos."
  }

end
