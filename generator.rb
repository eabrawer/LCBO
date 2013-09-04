require "json"
require "open-uri"

class HtmlGenerator
	def initialize
		@raw_response = open("http://lcboapi.com/products").read
		# Parse JSON­formatted text into a Ruby Hash
		@parsed_response = JSON.parse(@raw_response)
		@products = @parsed_response["result"]
	end

	def index
		puts "Generating index.html"
		@output=File.open('index.html', 'w')
		@output.puts display_header

		@products.each do |product|
			display_product(product)
		end

		@output.close
	end

	def show(product_id)
		# write the same as the index method but passing a product_id in
		puts "Generating show.html"
		@output=File.open('show.html', 'w')

		found=false
		@products.each do |product|
			if product['id'].to_i==product_id.to_i then
				found=true
				display_product(product)
			end
		end

		if !found then
			@output.puts "Nothing found for id #{product_id}"
		end

		@output.puts "<a href='index.html'>Back to index</a>"
		@output.close
	end

	def display_header
		@output.puts "<!DOCTYPE html>"
		@output.puts "<html>"
		@output.puts "<head>"
		@output.puts "<link rel=\"stylesheet\" type=\"text/css\" href=\"style.css\">"
		@output.puts "<title>Connoisseur</title>"
		@output.puts "</head>"
		@output.puts "<body>"
		@output.puts "<div id=\"content\">"
		@output.puts "<h1>Connoisseur App</h1>"
		
	end

	def display_product(product)
			@output.puts "<ul class=\"product_list\">"
			@output.puts "<img src=#{product['image_thumb_url']}>"
			if !product['image_thumb_url']
				@output.puts "<img src=\"imgres.jpeg\" alt=\"?\" width=\"234\" length=\"234\">"
			end
			@output.puts "<li>#{product['name']}</li>"
			@output.puts "<li>#{product['id']}</li>"
			@output.puts "<li>#{product['primary_category']}</li>"
			@output.puts "<li>$#{product['price_in_cents'] / 100}</li>"
			@output.puts "</ul>"
		@output.puts "</div>"
		@output.puts "</body>"
		@output.puts "</html>"
	end 


end