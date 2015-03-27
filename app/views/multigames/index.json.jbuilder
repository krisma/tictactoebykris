json.array!(@multigames) do |multigame|
  json.extract! multigame, :id, :status, :turn, :player1, :player2
  json.url multigame_url(multigame, format: :json)
end
