servicing
flushServer
	"VDMPad flushServer"

	Server
		ifNotNil: [ 
			Server stop.
			Server unregister.
			Server := nil ]