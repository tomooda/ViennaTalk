servicing
server
	^ Server
		ifNil: [ Server := (self serverClass on: self defaultPort)
				bindingAddress: #[127 0 0 1];
				register;
				start;
				yourself ]