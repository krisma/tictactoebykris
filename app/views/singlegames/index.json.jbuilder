json.array!(@singlegames) do |singlegame|
  json.extract! singlegame, :id, :status, :turn
  json.url singlegame_url(singlegame, format: :json)
end
