class ProviderPriceCalcs
	require 'nokogiri'
	require 'open-uri'

	class << self

		def type_a
			page = Nokogiri::HTML(open("http://time.com"))
			page.css('body').text.count('a') / 100.0
		end

		def type_b
			page = Nokogiri::HTML(open('https://ajax.googleapis.com/ajax/services/feed/find?v=1.0&q=news'))
			page.css('body').text.scan(/\\u003cb\\u003e/).size.to_f
		end

		def node
			page = Nokogiri::HTML(open("http://time.com"))
			nodes = 0
			page.traverse { nodes += 1 }
			nodes / 100.0
		end

	end
end
