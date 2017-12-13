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
    image_tag user.avatar, size: 30
	end


end
