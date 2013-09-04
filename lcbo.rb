# puts "first argument"
# puts ARGV[0]
# puts "second argument"
# puts ARGV[1]

# if ARGV[0] == "index"
# 	puts "hello I'm a index"
# elsif ARGV[0] == "show"
# 	puts "Hello, I'm a show"
# end

# nokogiri only doe html 

require_relative 'generator'
if ARGV.empty?
	puts "Usage: ruby router.rb [action]"
else
	action = ARGV[0]
	generator = HtmlGenerator.new
end

if action == "index"
	generator.index
elsif action == "show"
	generator.show ARGV[1]
else
	puts "Unknown action #{action}. Use index or show."
end