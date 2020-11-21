module NavigationHelper
  def show_my_bookmarks_maybe(current_user=nil)
    if current_user
      content_tag :li do 
        link_to "My Bookmarks", user_bookmarks_path(current_user)
      end 
    end
  end

  def show_add_bookmark_maybe(current_user=nil)
    if current_user
      content_tag :li do
        link_to "Add Bookmark", new_bookmark_path
      end
    end
  end

end
