require 'rails_helper'
require 'nokogiri'

describe ProviderPriceCalcs do

	it 'should return correct value for type a' do
		allow(ProviderPriceCalcs).to receive(:page).and_return(Nokogiri::HTML '<body>a<a>a</a><p>a</p></body>')
		expect(ProviderPriceCalcs.type_a).to eq 0.03
	end

	it 'should return correct value for type b' do
		allow(ProviderPriceCalcs).to receive(:page).and_return(Nokogiri::HTML '<body>1\u003cb\u003e2\u003cb\u003e3\u003cb\u003e4\u003cb\u003eend</body>')
		expect(ProviderPriceCalcs.type_b).to eq 4.0
	end

	it 'should return correct value for node' do
		allow(ProviderPriceCalcs).to receive(:page).and_return(Nokogiri::HTML '<body><div><p>1</p><span>2</span</div><h1>3</h1></body>')
		expect(ProviderPriceCalcs.node).to eq 0.11
		# 1. doc
		# 2. dtd
		# 3. html
		# 4. body
		# 5. div
		# 6. p
		# 7. p text 
		# 8. span 
		# 9. span text 
		# 10. h1
		# 11. h1 text
	end

end
