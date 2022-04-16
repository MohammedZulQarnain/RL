require 'date'
class PeopleController
  def initialize(params)
    @params = params
  end

  def normalize
    normalize_data = []
    if params[:dollar_format]
      normalize_data = normalize_data + dollar_normalize
    end
    if params[:percent_format]
      normalize_data = normalize_data + percent_normalize
    end
    normalize_data.sort
  end

  def dollar_normalize
    i = 1
    normailzed_d = []
    d_items = params[:dollar_format]&.split("\n")
    while ( i < d_items.length)
      dhd = d_items[i].split("$").map(&:strip)
      str = dhd[3] + ", " + dhd[0] + ", " +  Date.parse(dhd[1]).strftime("%-m/%-d/%Y")
      normailzed_d = normailzed_d.append(str)
      i+=1
    end
    normailzed_d
  end

  def percent_normalize
    i = 1
    normailzed_p = []
    p_items = params[:percent_format]&.split("\n") 
    while ( i < p_items.length)
      dhp = p_items[i].split("%").map(&:strip)
      str = dhp[0] + ", " + dhp[1] + ", " +  Date.parse(dhp[2]).strftime("%-m/%-d/%Y")
      normailzed_p = normailzed_p.append(str)
      i+=1
    end
    normailzed_p
  end

  private

  attr_reader :params
end
