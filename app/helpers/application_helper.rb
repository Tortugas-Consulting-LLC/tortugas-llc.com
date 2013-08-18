module ApplicationHelper
  def set_then_return_title title
    content_for(:title, title + " :: Tortugas LLC")
    title
  end
end
