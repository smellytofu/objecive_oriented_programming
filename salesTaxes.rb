class Item
	attr_accessor :exempted, :imported, :price, :name
	attr_reader :tax, :iTax, :eTax

	def initialize(myName, myPrice, isImported, isExempted)
		@exempted = isExempted
		@imported = isImported
		@price = myPrice
		@name = myName
		@tax = 0.10
		@eTax = 0
		@iTax = 0.05
	end

	def getTax()
		if @exempted && @imported
			theTax = @price * @eTax + @price * @iTax
		elsif @imported
			theTax = @price * @iTax
		elsif @exempted
			theTax = @price * @eTax
		else
			theTax = @price * @tax
		end
		return theTax
	end
end

i = 0
orders = []
input = ""
while(input != "exit")
	i += 1
	puts "Input #{i}:"
	newOrder = []
	while(true)
		input = gets.chop

		#breaking out of loop, exit to stop, next to get next order
		if input == "exit" || input == "next"
			break
		end

		input[/(.+) at \$(.+)/]
		itemName = $1
		itemPrice = $2.to_f
		#puts "debug: input - #{input}, itemName = #{itemName}, itemPrice = #{itemPrice}"
		if((input =~ /imported/) && (input =~ /chocolate|pills|book/))
			thing = Item.new(itemName, itemPrice, true, true)
			#puts "debug: is imported and exempted"
		elsif(input =~ /imported/)
			thing = Item.new(itemName, itemPrice, true, false)
			#puts "debug: is imported"
		elsif(input =~ /chocolate|pills|book/)
			thing = Item.new(itemName, itemPrice, false, true)
			#puts "debug: is exempted"
		else
			thing = Item.new(itemName, itemPrice, false, false)
			#puts "debug: is neither"
		end
		newOrder.push(thing)
		#puts "debug: name - #{thing.name}, price - $#{thing.price}"
	end
	orders.push(newOrder)
end

order = orders.reverse!.each{|v| v = v.reverse}

i = 0
while(order.any?)
	i += 1

	#getting order
	orderList = order.pop
	puts "Order #{i}:"

	#printing items and collecting tax and total
	newtax = 0.0
	subtotal = 0.0
	while(orderList.any?)
		newItem = orderList.pop
		#puts "debug: name: #{newItem.name}, price: #{newItem.price}, imported: #{newItem.imported}, exempted: #{newItem.exempted}, getTax: #{newItem.getTax}"
		#puts newtax
		#puts newItem.getTax
		newtax = newtax + newItem.getTax
		subtotal = subtotal + newItem.price
		puts "#{newItem.name} at $#{newItem.price}"
	end
	total = newtax + subtotal
	puts "\t\t\t\t tax: \t$#{newtax}\n \t\t\t\t total: \t$#{total}"
end