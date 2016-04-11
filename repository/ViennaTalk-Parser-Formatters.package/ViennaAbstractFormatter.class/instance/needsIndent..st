private
needsIndent: aString
	^ (aString includes: Character cr) or: [ (self strlen: aString) > self maxSizePerLine ]