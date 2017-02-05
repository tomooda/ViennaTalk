parsers-definitions
error
	^ (identifier trim , colon , expression , self arrow , expression)
		==> [ :quin | 
			{quin first.
			quin third.
			quin fifth} ]