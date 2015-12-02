printing
printOn: aStream
	aStream
		nextPutAll: label asString;
		nextPut: $(.
	(1 to: self size)
		do: [ :index | 
			| child |
			child := self at: index.
			child isArray
				ifTrue: [ 
					aStream nextPut: $(.
					child do: [ :ast | ast printOn: aStream ] separatedBy: [ aStream nextPut: Character cr ].
					aStream nextPut: $) ]
				ifFalse: [ child printOn: aStream ] ]
		separatedBy: [ aStream nextPutAll: ', ' ].
	aStream nextPut: $)