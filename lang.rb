require './lib/language_finder.rb'

a = LanguageFinder.new(ARGV[0])
puts a.top_language
