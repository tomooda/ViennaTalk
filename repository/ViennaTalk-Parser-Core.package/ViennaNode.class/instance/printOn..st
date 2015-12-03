printing
printOn: aStream
	| substrings |
	aStream
		nextPut: $(;
		nextPutAll: label asString;
		nextPut: Character space.
	substrings := self collect: #printString.
	((substrings contains: [ :string | string includes: Character cr ]) or: [ (substrings collect: #size) sum > 50 ])
		ifTrue: [ 
			substrings
				do: [ :string | 
					aStream nextPut: Character cr.
					string lines
						do: [ :line | 
							aStream
								nextPutAll: '  ';
								nextPutAll: line ]
						separatedBy: [ aStream nextPut: Character cr ] ] ]
		ifFalse: [ substrings do: [ :string | aStream nextPutAll: string ] separatedBy: [ aStream nextPut: Character space ] ].
	aStream nextPut: $)