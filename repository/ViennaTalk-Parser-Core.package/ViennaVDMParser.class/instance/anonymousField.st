parsers-types
anonymousField
	^ super anonymousField
		=>> [ :start :end :typeNode | 
			{nil.
			false.
			(typeNode
				start: start end: end;
				yourself)} ]