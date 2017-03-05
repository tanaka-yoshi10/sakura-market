module ShoppingHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
    css_class = (column == sort_column) ? "btn btn-success sort #{direction}" : "btn btn-default sort nosort"
    link_to title, {:sort => column, :direction => direction}, {:class => css_class}
    # [review] hashの書き方は新しい形式にしたいです
    # link_to title, {sort: column, direction: direction}, {class: css_class}
  end
end
