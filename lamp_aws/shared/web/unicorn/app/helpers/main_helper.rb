module MainHelper
  def big_link(image, short_text, explanations)
    haml_tag :a, href: '/', class: 'item' do
      haml_concat image_tag image
      haml_tag :div, class: 'overlay regular' do
        haml_tag :div, class: 'center' do
          haml_tag :div, class: 'content' do
            haml_concat short_text
          end
        end
      end
      haml_tag :div, class: 'overlay detailed' do
        haml_tag :div, class: 'center' do
          haml_tag :div, class: 'content' do
            explanations.each do |explanation|
              haml_concat explanation
              haml_tag :br
            end
          end
        end
      end
    end
  end
end
