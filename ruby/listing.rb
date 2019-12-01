class Listing
  attr_accessor :category, :battery, :color, :manufacturer, :status, :year, :price
  
  def add_to_listing(elem)
    elem.strip!

    case elem
    when /smartphone|tablet|laptop|smartwatch/i
      @category = elem
    when /hrs/i
      @battery = elem
    when /white|black|silver/i
      @color = elem
    when /apple|samsung|google|lenovo|lg/i
      @manufacturer = elem
    when /new|used|refurbished/i
      @status = elem
    when /\d{4}[^$]/
      @year = elem
    when /\d+\$/
      @price = elem
    end
  end
  
  def export_listing()
    return "#@category, #@battery, #@color, #@manufacturer, #@status, #@year, #@price"
  end
end

for line in File.readlines('test.txt') do
  new_listing = Listing.new()
  line.to_s.split(/\s*,\s*/).each { | elem | new_listing.add_to_listing(elem) }
  puts new_listing.export_listing()
end

# Local Variables:
# compile-command: "ruby listing.rb"
# End:
