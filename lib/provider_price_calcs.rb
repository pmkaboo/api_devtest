class ProviderPriceCalcs
	require 'nokogiri'
	require 'open-uri'

	SOURCE = {
		type_a: 'http://time.com',
		type_b: 'https://ajax.googleapis.com/ajax/services/feed/find?v=1.0&q=news',
		node: 'http://time.com'
	}

	class << self

		def type_a
			# page = Nokogiri::HTML(open("http://time.com"))
			page(:type_a).css('body').text.count('a') / 100.0
		end

		def type_b
			# page = Nokogiri::HTML(open('https://ajax.googleapis.com/ajax/services/feed/find?v=1.0&q=news'))
			page(:type_b).css('body').text.scan(/\\u003cb\\u003e/).size.to_f
		end

		def node
			# page = Nokogiri::HTML(open("http://time.com"))
			nodes = 0
			page(:node).traverse { nodes += 1 }
			nodes / 100.0
		end

		private
		def page type
			Nokogiri::HTML(open(SOURCE[type]))
		end
	end
end
