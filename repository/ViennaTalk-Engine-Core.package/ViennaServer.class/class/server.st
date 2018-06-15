servicing
server
	^ Server
		ifNil: [ Server := (ZnMultiThreadedServer defaultOn: self defaultPort)
				bindingAddress: nil;
				register;
				start;
				yourself ]