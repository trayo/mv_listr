module ApplicationHelper
  def viewing_recommendations?
    current_page? recommendations_path
  end
end
