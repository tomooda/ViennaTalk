utilities
closureFromMethodSource: aString binds: binds
	| header |
	header := ((aString readStream upTo: Character cr) trim readStream upTo: $:) , ':'.
	^ String
		new: 1024
		streamContents: [ :stream | 
			stream nextPut: $[.
			1 to: binds size do: [ :i | 
				stream nextPutAll: ' :arg'.
				i printOn: stream ].
			stream space.
			binds ifNotEmpty: [ stream nextPutAll: '| ' ].
			stream nextPutAll: 'self '.
			binds
				ifEmpty: [ 
					stream
						nextPutAll: header;
						nextPutAll: ' nil' ]
				ifNotEmpty: [ 
					stream
						nextPutAll: header;
						nextPutAll: ' arg1'.
					2 to: binds size do: [ :i | 
						stream nextPutAll: ' _: arg'.
						i printOn: stream ] ].
			stream nextPutAll: ']' ]