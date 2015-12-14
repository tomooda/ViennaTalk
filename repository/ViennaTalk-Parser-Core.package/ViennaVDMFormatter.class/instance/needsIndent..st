private
needsIndent: aString
	^ (aString includes: Character cr) or: [ aString size > self maxSizePerLine ]