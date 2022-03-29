crumb :root do
  link "Home", root_path
end

crumb :owner_new do
  link "新規会員登録（ブランドオーナー）", new_owner_path
  parent :acounts
end

crumb :general_new do
  link " 登録画面", new_general_path
  parent :acounts
end

crumb :general_sessions_new do
  link " ログイン画面", general_login_path
  parent :sessions
end

crumb :items_show do |item|
  link "#{item.brand.name}", brand_item_path(item)
  parent :root
end

crumb :items_likes do
  link " お気に入り", items_likes_path
  parent :root
end

crumb :acounts do
  link "新規会員登録", acounts_path
  parent :root
end

crumb :sessions do
  link "ログイン", sessions_path
  parent :root
end

crumb :privacy do
  link "プライバシーポリシー", privacy_path
  parent :root
end

crumb :terms do
  link "利用規約", terms_path
  parent :root
end

crumb :contacts do
  link "お問い合わせ", contact_path
  parent :root
end