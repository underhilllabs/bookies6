module BookmarksHelper
  def nice_date_form(date)
    date&.strftime('%B %e, %Y') 
  end
end
