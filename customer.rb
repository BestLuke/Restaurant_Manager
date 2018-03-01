require 'terminal-table'
require_relative 'new_cust'

module Customer
    module_function

    name_found = false
    customers = []
    table_actual = Terminal::Table.new
    File.open("customers.txt").each do |line|
        customers = JSON.parse(line, {symbolize_names: true})

        table = Terminal::Table.new :title => "Customers", :headings => ["Table number", "Customer", "Dietry needs", "Order cost"], :rows => customers
        table.style = {:width => 100, :padding_left => 3, :border_x => "=", :border_i => "x"}
        table_actual = table
    end 

    def start_operations table
        puts "Here is who is at your Restaurant now"
        puts table
    end

    def customer_main table_actual, customers
        puts start_operations table_actual
        cost = -1
        if customers.length != 0
            puts "Who would you like to view?"
            name = gets.chomp.capitalize!
            #set up loop to iterate through customers
            #Check the second element for .include?
            #Continue with functionality.
            for i in customers
                if i[1].include? name
                    puts "What would you like to do for #{name}? (Add order, Pay status, Pay order)"
                    name_found = true
                    cost = i[3]
                end
            end
            if name_found == true
                res = gets.chomp.capitalize!
            end
                case res
                when "Add order"
                    puts "Please insert the cost of the order"
                    added_cost = gets.chomp.to_i
                    cost = cost + added_cost
                    puts "#{name}'s order is now: $#{cost}"
                    for i in customers
                        if i[1].include? name
                            i[3] = cost
                        end
                    end
                when "Pay status"
                    if cost == 0
                        puts "#{name} hasn't payed yet, owes $#{cost}"
                    else
                        puts "Customer has paid"
                    end
                when "Pay order"
                    if cost != 0
                        puts "#{name} owes $#{cost}, are you paying?(y/n)"
                        ans = gets.chomp.capitalize!
                        if ans == "Y" || ans == "Yes"
                            cost = cost - cost
                            puts "#{name} has paid"
                            for i in customers
                                if i[1].include? name
                                    i[3] = cost
                                end
                            end
                        else
                            puts "#{name} still hasn't payed yet, owes $#{cost}"
                        end
                    else
                        puts "Customer has paid"
                    end
                end
            end
            File.open("customers.txt", "w") do |line|
                line.puts JSON.generate(customers)
            end 
        end


end