class Linkage
  attr_accessor :crossdata
  attr_accessor :seeds
  attr_accessor :geneinfo

  def initialize (crossdata: "1", seeds: "2", geneinfo: "3")
    @crossdata = crossdata
    @seeds = seeds
    @geneinfo = geneinfo
  end
  def chilinkage 
    #definition of needed temporary objects(?)
    a = 0
    b = Array.new(@crossdata.by_row.length)
    temp = Array(0..1)
    finalreport = Array(0)
  # Analysing the data row by row:
  until a > (@crossdata.by_row.length - 1)
      cross_row = @crossdata.by_row[a]
      cross_row = cross_row[2..5]
      cross_row = cross_row.map(&:to_i)
      
      #Following is the chi-square test --> I wasnt able to get decimals but the values are so high that it doesnt matter
      e = cross_row.sum / 4 
      chisquare = cross_row.map { |item|
      (((item - e) * (item - e)) / e)
      }
      
      b[a] = chisquare.sum
      if b[a] > 7.815 then # df is n-1 --> 4-1=3. 7.815 is the border of significance base on http://chisquaretable.net/
        linked = @crossdata.by_row[a][0..1]
        
        #Crossreferencing between datasets:
        temp[0] = @seeds.by_col[0].find_index linked[0]
        temp[1] = @seeds.by_col[0].find_index linked[1]
        temp[0] = @seeds.by_col[1][temp[0]]
        temp[1] = @seeds.by_col[1][temp[1]]
        temp[0] = @geneinfo.by_col[0].find_index temp[0]
        temp[1] = @geneinfo.by_col[0].find_index temp[1]
        temp[0] = @geneinfo.by_col[1][temp[0]]
        temp[1] = @geneinfo.by_col[1][temp[1]]
        puts "Recording: #{temp[0]} is linked to #{temp[1]} with a chisquare score of: #{b[a]}"
        finalreport[a] = "#{temp[0]} is linked to #{temp[1]}"
      end
      a += 1
    end
    puts "Final Report:"
    puts finalreport
  end
end