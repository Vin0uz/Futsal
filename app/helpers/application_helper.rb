module ApplicationHelper
  def class_nav_link(link:, color:)
    html_class = "block py-1 md:py-3 pl-1 align-middle no-underline hover:text-gray-900 border-b-2"
    if current_page?(link)
      html_class += " text-#{color}-600 border-#{color}-600 hover:border-#{color}-600"
    else
      html_class += " text-gray-500 border-white hover:border-#{color}-500"
    end

    html_class
  end

  def class_nav_link_text(link:, color:)
    if current_page?(link)
      "fas fa-home fa-fw mr-3 text-#{color}-600"
    else
      "fas fa-home fa-fw mr-3"
    end
  end
end
