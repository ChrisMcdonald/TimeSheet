module ApplicationHelper

	def link_to_add_fields(name, f, association, url)
		new_object = f.object.send(association).klass.new
		id = new_object.object_id
		fields = f.fields_for(association, new_object, child_index: id,) do |builder|
			render(url, f: builder)
		end
    link_to(name, '#', class: "btn btn-default add_fields", data: {id: id, fields: fields.gsub("\n", "")})
	end

  def paginate(collection, params= {})
    will_paginate collection, params.merge(:renderer => RemoteLinkPaginationHelper::LinkRenderer)
  end

  def gravatar_for(user, opts = {})
    opts[:alt] = user.full_name
    if user.identities.present?
      image_tag user.identities.first.image, size: 30
    else
      image_tag 'default_avatar.jpeg', size: 30, class: "img-circle img-sm"
		end
	end


end
