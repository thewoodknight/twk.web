---
layout: page
title: Jekyll Optimisation
permalink: /jekyll
showlastmodified: true
---
After years using Wordpress for TWK's website, I was sick of the constant updates, security maintenance, and generally "things break on updates". Performance was also a big concern.

{% include image.html 
image="/assets/images/posts/2021-08/before.jpg"
title="before"
width="523"
caption="Before.." %}

So for the new version of the website, I set about making an ultra-optimised, can't-be-hacked-because-its-just-HTML website using [Jekyll](https://jekyllrb.com/). 

{% include image.html 
image="/assets/images/posts/2021-08/after.jpg"
title="after"
width="518"
caption="...After! Not sure why accessibility took a hit" %}

"Within reason", at least. Perhaps a more efficient site would forgo any JS, handcrafting every line of CSS, but I wanted something that was reasonable to build, maintain, and still "fast enough".

#### GH-Pages
The elephant in the room to get out of the way is these optimisations will not run on GH-Pages. You *may* be able to use GH-Actions to build your site, then copy the output HTML to a repo that gets served up. GH-Pages is very limited in plugin support, and you can't run other CLI stuff alongside it during the build process.

This does, however, work amazing on [Cloudflare Pages](https://pages.cloudflare.com/).

### Getting it fast..

#### PurgeCSS
Reducing the total amount of CSS is good - less parsing by the browser, less data to download. If you use something like Bootstrap, you'll invariably have a *lot* of unused CSS.
[PurgeCSS](https://purgecss.com/) looks at your HTML (the generated files in `_site/`) and determines what CSS classes aren't used and strips them.

Using PurgeCSS takes my CSS for TWK's website down from 156kb to ***19kb***. `jekyll-purgecss` helps do this at build time, rather than having to manaully run it.

#### Jekyll Picture Tag
[Jekyll-picture-tag](http://rbuchberger.github.io/jekyll_picture_tag/) is *amazing*. At its very basics, you can just make it generate a `.webp` version of any image that goes through the picture tag, but more advanced use will let you crop, resize, and generates `src-set` for responsive/scaling images.


#### Optimisation config
##### .gemfile
Much of the gem file is the defaults for Jekyll, but `liquid-c`, `jekyll-purgecss` and `jekyll_picture_tag` can be massively beneficial.

```ruby
source "https://rubygems.org"

gem "jekyll", "~> 4.2.0"
gem "webrick"

gem "liquid-c" # faster liquid processing
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
  gem 'jekyll-purgecss' #really optimise your CSS
  gem 'jekyll_picture_tag', '~> 2.0' #optimise your images
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
```


##### _config.yml
In the config file, there isn't a whole lot to actually configure, other than where your CSS directory is for purge-css.

```yml
plugins:
  - jekyll-purgecss

sass: 
  sass_dir: _sass
  style: :compressed

#assets
css_dir: "/assets/css/"

picture:
  ignore_missing_images: true
```

##### command line/installs
Once the gemfile is populated/setup, you'll need to install the extra gems with `bundle install`, while `libvips` and `imagemagick` need to be pulled from whatever package manager you're using.

```shell
bundle install
apt-get install libvips
apt-get install ImageMagick
```

#### Running Jekyll
`purge-css` only works when `JEKYLL_ENV` variable is set, so if you can set it at the environment level, great, do that! Otherwise, it can be passed in at the CLI.


```shell
npm install purgecss && JEKYLL_ENV=production bundle exec jekyll serve --force-polling --trace
```

#### Handling Images
[Jekyll-picture-tag](http://rbuchberger.github.io/jekyll_picture_tag/) is one of the "big ones" for optimising your images, and keeping it managable by generating the images at compile time. Using JPT, you can (at build time) convert all your images over to next gen formats like `webp`, which are considerably smaller.

Rather than `<img src="">`, use the picture liquid tag

```
{% raw  %}
{% picture jpt-webp "{{ post.featured_image }}"  %}
{% endraw %}
```

The usage format is explained more in the JPT documentation, but basically

```
picture <preset> <image> <cropping> <other html>
```

ie

```
{% raw  %}
{% picture jpt-webp "{{ post.featured_image }}" 1:1 center class="postboximage" alt="{{post.title}}" %}
{% endraw %}
```

You can make your own presets by defining them in `_data\picture.yml`

```yml
presets:
  frontpage:
    widths: [360]
    formats: [webp, original]
    sizes:
      mobile: 80vw
    size: 360px
```