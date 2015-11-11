testing
isHexadecimalDigit: aCharacter
	^ (aCharacter charCode between: $0 charCode and: $9 charCode)
		or: [ 
			(aCharacter charCode between: $a charCode and: $f charCode)
				or: [ aCharacter charCode between: $A charCode and: $F charCode ] ]