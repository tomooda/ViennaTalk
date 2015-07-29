parsing
parseOn: aStream
	aStream skipSeparatorsAndPeekNext
		in: [ :char | 
			char = $n
				ifTrue: [ ^ self parseNilOn: aStream ].
			char = $t
				ifTrue: [ ^ self parseTrueOn: aStream ].
			char = $f
				ifTrue: [ ^ self parseFalseOn: aStream ].
			char = $m
				ifTrue: [ ^ self parseCompositeOn: aStream ].
			char = ${
				ifTrue: [ ^ self parseSetOrMapOn: aStream ].
			char = $[
				ifTrue: [ ^ self parseSeqOn: aStream ].
			char = $<
				ifTrue: [ ^ self parseQuoteOn: aStream ].
			char = $'
				ifTrue: [ ^ self parseCharOn: aStream ].
			char = $"
				ifTrue: [ ^ self parseStringOn: aStream ].
			(char = $- or: [ char isDigit ])
				ifTrue: [ ^ self parseNumberOn: aStream ].
			^ self error: 'Unexpected character in VDM value: ' , aStream upToEnd ]