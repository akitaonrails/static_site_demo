ActiveAdmin.register Page do
  permit_params %i[title author published_at summary body]

  controller do
    def find_resource
      scoped_collection.friendly.find(params[:id])
    end
  end

  show do
    h3 page.author
    div do
      link_to page.published_at.to_formatted_s(:long), page
    end
    div do
      page.summary_html.html_safe
    end
    div do
      page.body_html.html_safe
    end
  end

  form do |f|
    inputs 'Meta' do
      input :title
      input :author
      input :published_at
    end
    inputs 'Content (use Markdown)' do
      input :summary
      input :body
    end

    actions
  end

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end


end
