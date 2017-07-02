servicing
server
	^ Server
		ifNil: [ Server := (ZnMultiThreadedServer defaultOn: self defaultPort)
				bindingAddress:  #[127 0 0 1] ;
				register;
				start;
				yourself ]