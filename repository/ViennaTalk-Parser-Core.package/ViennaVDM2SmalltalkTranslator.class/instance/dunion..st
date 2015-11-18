parsers-expressions-operators
dunion: arg
	^ '(' , arg , ' inject: Set new into: [:union :set | union addAll: set; yourself])'