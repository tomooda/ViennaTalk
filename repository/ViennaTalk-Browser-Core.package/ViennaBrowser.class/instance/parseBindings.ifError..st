value pane
parseBindings: aString ifError: errorBlock
	| reader bindings stream readName |
	reader := ViennaReader new.
	bindings := Array new writeStream.
	stream := aString readStream.
	readName := [ 
	(String
		new: 1
		streamContents: [ :writeStream | [ stream atEnd or: [ stream peek = $| ] ] whileFalse: [ writeStream nextPut: stream next ] ])
		trimmed ].
	stream skipSeparators.
	(stream nextMatchAll: '{')
		ifFalse: [ ^ errorBlock value: 1 value: 'Should start with "{"' ].
	stream skipSeparators.
	[ stream atEnd ]
		whileFalse: [ 
			| name start end |
			stream peek = $}
				ifTrue: [ ^ bindings contents ].
			name := readName value.
			(stream nextMatchAll: '|->')
				ifFalse: [ ^ errorBlock value: stream position value: '"|->" is expected.' ].
			stream skipSeparators.
			start := stream position+1.
			[ reader parseOn: stream ]
				on: Error
				do: [ :ex | ^ errorBlock value: stream position value: ex messageText ].
			end := stream position.
			bindings nextPut: name -> (aString copyFrom: start to: end).
			stream skipSeparators.
			stream peek = $}
				ifTrue: [ ^ bindings contents ].
			stream next = $,
				ifFalse: [ ^ errorBlock value: stream position value: '"," is expected.' ] ].
	^ errorBlock value: aString size value: 'Unexpected end before reaching to "}"'