module Jekyll
    class TagPageGenerator < Generator
      safe true
  
      def generate(site)
        tags = site.documents.flat_map { |post| post.data['tags'] || [] }.to_set
        tags.each do |tag|
          site.pages << TagPage.new(site, site.source, tag)
        end
      end
    end
  
    class TagPage < Page
      def initialize(site, base, tag)
        @site = site
        @base = base
        @dir  = File.join('tag', slugify(tag))
        @name = 'index.html'
  
        self.process(@name)
        self.read_yaml(File.join(base, '_layouts'), 'tag.html')
        self.data['tag'] = tag
        self.data['title'] = "Plans: #{tag}"
      end

      def slugify(value)
        slug = value
        # Remove single quotes from input
        slug = slug.gsub(/[']+/, '')
  
        # Replace any non-word character (\W) with a space
        slug = slug.gsub(/\W+/, ' ')
  
        # Remove any whitespace before and after the string
        slug = slug.strip
  
        # All characters should be downcased
        slug = slug.downcase
  
        # Replace spaces with dashes
        slug = slug.gsub(' ', '-')
  
        # Return the resulting slug
        slug
      end
    end
  end