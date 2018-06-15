servicing
flushServer
	"ViennaServer flushServer"

	Server
		ifNotNil: [ (Server
				stop;
				unregister;
				yourself) delegate prefixMap at: 'eval' ifPresent: #close.
			Server := nil ]