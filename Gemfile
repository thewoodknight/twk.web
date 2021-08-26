source "https://rubygems.org"


gem "jekyll", "~> 4.2.0"
gem "webrick"

gem "liquid-c"
# If you want to use GitHub Pages, remove the "gem "jekyll"" above and
# uncomment the line below. To upgrade, run `bundle update github-pages`.
# gem "github-pages", group: :jekyll_plugins
# If you have any plugins, put them here!
group :jekyll_plugins do
  gem 'jekyll-feed'
  gem 'jekyll-paginate'
  gem 'jekyll-seo-tag'
  gem 'jekyll-archives'
  gem 'jekyll-sitemap'
  gem 'kramdown'
  gem 'rouge'
  gem 'jekyll-toc'
  gem 'jekyll-category-pages'
  gem 'jekyll-purgecss'
  gem 'jekyll_picture_tag', '~> 2.0'
end

# Windows and JRuby does not include zoneinfo files, so bundle the tzinfo-data gem
# and associated library.
platforms :mingw, :x64_mingw, :mswin, :jruby do
  gem "tzinfo", "~> 1.2"
  gem "tzinfo-data"
end

gem 'rake'
gem 'html-proofer'

# Performance-booster for watching directories on Windows
gem "wdm", "~> 0.1.1", :platforms => [:mingw, :x64_mingw, :mswin]