servicing
server
	^ Server
		ifNil: [ 
			Server := (ZnMultiThreadedServer on: self defaultPort)
				bindingAddress:
						(LocalOnly ~= false
								ifTrue: [ #[127 0 0 1] ]
								ifFalse: [ nil ]);
				register;
				start;
				yourself ]