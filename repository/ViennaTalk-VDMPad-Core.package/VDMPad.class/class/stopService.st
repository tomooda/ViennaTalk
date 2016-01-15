servicing
stopService
	Server
		ifNotNil: [ 
			Server stop.
			Server := nil ]