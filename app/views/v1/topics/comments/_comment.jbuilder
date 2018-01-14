# frozen_string_literal: true

json.extract!(comment, :id, :text, :created_at)
json.author comment.author.full_name
