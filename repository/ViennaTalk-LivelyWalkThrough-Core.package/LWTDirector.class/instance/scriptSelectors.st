accessing-scripts
scriptSelectors
	^ (Array new: 10 streamContents: [ :stream | self scriptsDo: [ :script | stream nextPut: script name ] ])
		asSortedCollection