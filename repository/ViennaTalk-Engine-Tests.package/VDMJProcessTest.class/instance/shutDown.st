running
shutDown
	process ifNotNil: [process close].
	process := nil