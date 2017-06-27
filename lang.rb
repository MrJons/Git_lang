require 'lib/language_finder.rb'

a = LanguageFinder.new(ARGV[0])
puts a.print_top_language
