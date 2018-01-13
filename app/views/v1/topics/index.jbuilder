json.success true

json.data do
  json.array! @topics, partial: 'v1/topics/topic', as: :topic
end