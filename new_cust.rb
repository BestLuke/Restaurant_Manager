require 'terminal-table'

module New_Cust
    module_function

    customers = []

    def add_customer(customers)
        puts "What is your new customers name?"
        name = gets.chomp.capitalize!
        puts "Do they have any dietry requirements? please put a ',' between if multiple"
        diet = gets.chomp.capitalize!
        puts "What table will they be at?"
        table_no = gets.chomp.to_i
        customers << [table_no, name, diet]

        table = Terminal::Table.new :title => "Customers", :headings => ["Table number", "Customer", "Dietry needs"], :rows => customers

        table.style = {:width => 100, :padding_left => 3, :border_x => "=", :border_i => "x"}

        puts table

    end

    puts add_customer(customers)

end