json.extract!(event, :id, :title, :text, :start_time, :end_time, :author)

json.participants event.participants
