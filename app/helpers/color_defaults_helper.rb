module ColorDefaultsHelper
  
  def grab_color(color_name)
    case color_name.to_s
    ## define our colors below:
    # base
    when "white"
      "white"
    when "black"
      "black"
    # all the greys
    when "grey1"
      "#f1f1f1"
    when "grey2"
      "#e5e5e5"
    when "grey3"
      "#aaa"
    when "grey4"
      "#666"
    when "grey5"
      "#4d4d4d"
    when "grey6"
      "#231f20"
    # actual color
    when "yellow"
      "#ffffcc"
    when "pink"
      "#ffcccc"
    when "red"
      "#ff0000"
    end
  end

  def grab_color_plain(color_name)
    color = grab_color(color_name)
    return color.gsub('#','')
  end

end
