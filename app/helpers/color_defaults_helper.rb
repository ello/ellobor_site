module ColorDefaultsHelper
  
  def grab_color(color_name)
    case color_name.to_s
    ## define our colors below:
    when "white"
      "#fff"
    when "black"
      "#000"
    when "lightBlue"
      "#dfefff"
    when "lightGrey"
      "#bfbfbf"
    when "grey"
      "#ccc"
    when "mediumGrey"
      "#808080"
    when "darkGrey"
      "#666"
    end
  end

  def grab_color_plain(color_name)
    color = grab_color(color_name)
    return color.gsub('#','')
  end

end
