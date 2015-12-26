parsers-expressions-basics
oldName
	^ (identifier , (self operator: '~')) ==> [ :pair | pair first , pair second ]