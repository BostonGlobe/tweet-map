sys						= require 'sys'
_							= require 'underscore'
sio						= require 'socket.io'
express				= require 'express'
twitter				= require 'twitter'

app = express.createServer()
app.configure ->
	app.use express.static(__dirname + '/public')
app.listen 3000

io = sio.listen app

twit = new twitter(
)

filter = 
	locations: '-71.32, 42.15, -70.79, 42.54'

twit.stream "statuses/filter", filter, (stream) ->
	stream.on "data", (tweet) ->
		console.log tweet.text
		geo_text = ""
		if tweet.geo
			geo_text = tweet.geo.coordinates
		if tweet.coordinates
			geo_text += " / " + tweet.geo.coordinates
		if tweet.place
			geo_text += " / " + tweet.place.full_name
		io.sockets.send '<img src=' + tweet.user.profile_image_url_https + '>' + tweet.user.screen_name + ": " + tweet.text + " @[" + geo_text + "]"
