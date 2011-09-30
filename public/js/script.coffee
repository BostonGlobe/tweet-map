$(document).ready ->
	socket = io.connect()
	socket.on "message", (message) ->
		$('#messages').prepend("<p>" + message + "</p>")

	socket.connect() 
