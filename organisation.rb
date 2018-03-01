#require 'Table-Terminal'
require 'json'

module Organisation
    module_function
    table_no = -1
    puts "Welcome to Restaurant Manager 2018"
    sleep 2
    system "clear"
    puts "Do you already have a table configuration? (y/n)"
    ans = gets.chomp
    if ans == "y"
        puts "Please enter your configurations name"
        ans = gets.chomp
        puts "Invalid Name"
        table_no = File.open("#{ans}_layout.txt") do |line|
            line.gets.to_i# before gets number was acting as an 8 result
        end
    else
        puts "Please enter how many tables you have"
        table_no = gets.chomp.to_i
        puts "You have #{table_no} tables, at the moment 4 people is only option" #WILL CHANGE TO HOLD MORE THAN 4 PEOPLE
        puts "What would you like to save your configuration as?"
        config = gets.chomp
        File.open("#{config}_layout.txt", "w") do |line|
            line.puts JSON.generate(table_no.to_s)
        end
    end
    system "clear"
    puts "How many staff are on tonight?"
    staff = gets.chomp.to_i
    staff_table = table_no / staff
    puts "you have #{staff} staff on tonight, each member will cover #{staff_table} tables"
    table_a = Array.new()

    while table_no > 0
        table_a.push(table_no)
        table_no -=1
    end

    staff_a = Array.new()
    while staff > 0
        staff_a.push(staff)
        staff -=1
    end
    table_a.shuffle!
    table_covered = table_a.each_slice(staff_table).to_a 
    #NEED TO MAKE THIS SO THAT SLICE ADDS THE REMAINDER TO ONE OF THE ARRAYS TO KEEP TO STAFF LIMIT

    def generate_random_index_for_table_covered(table_covered)
        return rand(0..(table_covered.length - 1))
    end

    # convert the randomly chosen table numbers array into a formatted string
    def formatted_table_numbers_for_random_index(table_numbers_for_random_index)
        return table_numbers_for_random_index.join(",") + "\n"
    end

    for i in staff_a.reverse
        random_index = generate_random_index_for_table_covered(table_covered)
        table_numbers_for_random_index = table_covered[random_index]
        tns = formatted_table_numbers_for_random_index(table_numbers_for_random_index)  
        table_covered.delete_at(random_index)
        puts "Staff #{i} will cover table numbers #{tns}"
    end

    #START OPERATIONS LOOP




end