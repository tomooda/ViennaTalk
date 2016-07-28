utilities
generateCheck: varString type: typeString
	^ '(' , typeString , ' includes: ' , varString , ') ifFalse: [ViennaRuntimeTypeError signal]. '