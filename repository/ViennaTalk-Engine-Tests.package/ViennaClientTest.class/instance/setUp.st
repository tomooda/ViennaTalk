running
setUp
	fixture := ViennaClient on: 'http://localhost:8088/'.
	ViennaServer isRunning
		ifFalse: [ ViennaServer installHandler ]