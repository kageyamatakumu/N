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

  # OGP
  def default_meta_tags
    {
      site: 'Nemo',
      title: 'Nemo',
      reverse: true,
      separator: '|',
      description: 'Nemoは優れたクリエイターが創造した新たなブランドを紹介するプラットフォームです',
      keywords: 'Nemo',
      canonical: request.original_url,
      noindex: ! Rails.env.production?,
      icon: [
        { href: image_url('NEMO_logo.jpg') },
        { href: image_url('Nemo(sp).jpg'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/jpg' },
      ],
      og: {
        site_name: 'Nemo',
        title: 'Nemo',
        description: 'Nemoは優れたクリエイターが創造した新たなブランドを紹介するプラットフォームです',
        type: 'website',
        url: request.original_url,
        image: image_url('Nemo(sp).jpg'),
        locale: 'ja_JP',
      },
      twitter: {
        card: 'summary_large_image',
        site: '@takumukageyama',
      }
    }
  end
end
