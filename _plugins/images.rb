require 'digest'

module Jekyll
    module Tags
        class CarouselItemTag < Liquid::Tag
            def initialize(tag_name, input, tokens)
                super
                @input = input.strip
            end

            def render(context)
                item = context[@markup.strip]
                assets_path = "/assets/images/carousel/"
                image_file = assets_path + item[1]['image'] + ".jpg"
                keyword = item[1]['keyword']
                text = item[1]['text']
                md5 = Digest::MD5.file(File.dirname(__FILE__) + "/.." + image_file)
                image = '<div class="car-image" style="background-image: url(' + image_file + '?' + md5.hexdigest + ')"></div>'
                template = <<-END
                  <div class="item">
                    #{image}
				    <div class="text-container position-absolute">
					  <p>#{keyword}</p>
					  <h1>#{text}</h1>
				    </div>
                  </div>
                END
            end
        end
    end
end

Liquid::Template.register_tag('carousel_item', Jekyll::Tags::CarouselItemTag)
