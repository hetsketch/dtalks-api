# frozen_string_literal: true

json.extract!(comment, :id, :text, :created_at)

json.partial!('v1/author/author', author: comment.author)
