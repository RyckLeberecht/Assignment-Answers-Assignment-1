class SeedStock
  attr_accessor :seeds
  attr_accessor :takeout
  attr_accessor :newfilename

  def initialize (seeds: "1", takeout: "0", newfilename: "newstock.tsv")
    @seeds = seeds
    @takeout = takeout
    @newfilename = newfilename
  end

    #Quick method to check inputs
  def show
    puts @seeds
    puts @seeds.class
    puts @takeout
    puts @takeout.class
    time = Time.new
    today = Array("#{time.month}/#{time.day}/#{time.year}")
    puts today
  end
  
  def planting
    #Creation of temporary Objects(?)
    time = Time.new
    today = Array.new(@seeds.by_col["Last_Planted"].length, "#{time.month}/#{time.day}/#{time.year}")
    temp = Array(0..(seeds.by_row.length-1))
    rem = @seeds.by_col["Grams_Remaining"].map(&:to_i)
    #Going through the Remaining Grams entry by entry and substracting the wanted value
    temp.map { |item|
      temp2 = rem[item] - @takeout 
      if  temp2 < 0 then
        temp3 = temp2.abs
        puts "Warning: We have run out of Seed Stock #{seeds.by_col["Seed_Stock"][item]}, #{temp3} are missing"
        rem[item] = "0"
      elsif temp2 == 0
        puts "Warning: We have run out of Seed Stock #{seeds.by_col["Seed_Stock"][item]}"
        rem[item] = temp2.to_s
      else
        rem[item] = temp2.to_s
      end
    }
    #Updating the data
    @seeds.by_col["Grams_Remaining"] = rem
    @seeds.by_col["Last_Planted"] = today
    #Creating the new datafile and converting , to \t
    File.write(@newfilename, @seeds)
    file_new = File.open(@newfilename)
    file_new = file_new.read
    file_new = file_new.gsub(",", "\t")
    File.write(@newfilename, file_new)
    puts "The new Stock can be found in #{@newfilename}"
  end
end

