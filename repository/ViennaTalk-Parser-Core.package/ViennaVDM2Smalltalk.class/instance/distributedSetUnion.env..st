code generation-expressions
distributedSetUnion: aViennaNode env: aDictionary
	| arg |
	arg := self generate: aViennaNode first env: aDictionary.
	^ '(' , arg , ' inject: Set new into: [:union :set | union addAll: set; yourself])'