module ApplicationHelper
  # タイトルを動的に
  def page_title(page_title = '')
    base_title = 'Nemo'

    page_title.empty? ? base_title : page_title + ' | ' + base_title
  end

  # 管理画面のタイトルを動的に
  def page_admin_title(page_title = '')
    base_title = 'Nemo管理画面'

    page_title.empty? ? base_title : page_title + ' | ' + base_title
  end
end
