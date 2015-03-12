module SiteHelper

  def selected_top_navigation(actual, expected)
    actual == expected ? "selected" : ""
  end
end
