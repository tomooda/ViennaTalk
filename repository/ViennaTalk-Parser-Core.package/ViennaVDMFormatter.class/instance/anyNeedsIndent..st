private
anyNeedsIndent: anArrayOfString
	^ (anArrayOfString contains: [ :string | string includes: Character cr ])
		or: [ (anArrayOfString collect: #size) sum > self maxSizePerLine ]