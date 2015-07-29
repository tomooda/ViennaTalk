commands
modulesDo: aBlock ifError: errorBlock 
	^ self
		send: 'modules'
		responseDo: [:modules | modules do: aBlock]
		ifError: errorBlock