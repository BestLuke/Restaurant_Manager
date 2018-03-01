require_relative 'new_cust'
require_relative 'customer'

module Operating
    module_function
    exit_loop = false
    customers = []
    table_actual = Terminal::Table.new

    File.open("customers.txt").each do |line|
        customers = JSON.parse(line, {symbolize_names: true})

        table = Terminal::Table.new :title => "Customers", :headings => ["Table number", "Customer", "Dietry needs", "Order cost"], :rows => customers
        table.style = {:width => 100, :padding_left => 3, :border_x => "=", :border_i => "x"}
        table_actual = table
    end 
    def organise customers, state, table_actual
        exit_loop = state
        last_customers = []
        operations_main customers, exit_loop, table_actual
    end
    def operations_main customers, exit_loop, table_actual
        while exit_loop == false
            File.open("customers.txt").each do |line|
                customers = JSON.parse(line, {symbolize_names: true})
                table = Terminal::Table.new :title => "Customers", :headings => ["Table number", "Customer", "Dietry needs", "Order cost"], :rows => customers
                table.style = {:width => 100, :padding_left => 3, :border_x => "=", :border_i => "x"}
                table_actual = table
            end
            puts "What would you like to do?(View customers, Add customer, End of service)"
            option = gets.chomp.capitalize!
            puts option
            case option
            when "View customers"
                system "clear"
                Customer::customer_main table_actual, customers
            when "Add customer"
                New_Cust::add_customer customers
            when "End of service"
                system "clear"
                exit_loop = true
                last_customers = customers
                puts " new customers are #{last_customers.inspect}"
                #customers.clear
                File.open("#{Time.new}.txt", "w") do |line|
                    line.puts JSON.generate(last_customers)
                end 
                customers.clear    
                puts "old customers are #{customers.inspect}"         
                File.open("customers.txt", "w") do |line|
                    line.puts JSON.generate(customers)
                end 
            end
    end








    end
end