require_relative 'new_cust'
require_relative 'customer'

module Operating
    module_function
    exit_loop = false
    customers = []

    File.open("customers.txt").each do |line|
        customers = JSON.parse(line, {symbolize_names: true})

        table = Terminal::Table.new :title => "Customers", :headings => ["Table number", "Customer", "Dietry needs", "Order cost"], :rows => customers
        table.style = {:width => 100, :padding_left => 3, :border_x => "=", :border_i => "x"}
        table_actual = table
    end 

    def organise state
        exit_loop = state
    end

    while exit_loop == false










    end
end