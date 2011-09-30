$(document).ready ->
	count = 0
	socket = io.connect()
	socket.on "message", (message) ->
		count = count + 1
		if count == 50
			$('#messages').empty()
			count = 0
		$('#messages').prepend("<p>" + message + "</p>")

	socket.connect() 
