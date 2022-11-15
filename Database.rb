class Database
  attr_accessor :crossdata
  attr_accessor :seeds
  attr_accessor :geneinfo
  attr_accessor :newfilename
  attr_accessor :takeout
  def initialize (crossdatafile, seedstockdatafile, geneinformationfile, newseedstockfilename, seedstocktakeout)
    
    @seeds = CSV.parse(File.read(seedstockdatafile), headers: true, col_sep: "\t")
    @takeout = seedstocktakeout
    @newfilename = newseedstockfilename
    @crossdata = CSV.parse(File.read(crossdatafile), headers: true, col_sep: "\t")
    @geneinfo = CSV.parse(File.read(geneinformationfile), headers: true, col_sep: "\t")
  end
  def planting?
    p = SeedStock.new(seeds: @seeds, takeout: @takeout, newfilename: @newfilename) #calling Seedstock class using given parameters
    p.planting
  end
  def linkedgenes?
    p = Linkage.new(crossdata: @crossdata, seeds: @seeds, geneinfo: @geneinfo) #calling Linkage class using given parameters
    p.chilinkage
  end
end