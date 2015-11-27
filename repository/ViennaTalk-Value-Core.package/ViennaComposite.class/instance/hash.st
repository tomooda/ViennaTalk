comparing
hash
	| hash |
	hash := constructorName hash.
	1 to: self size do: [ :i | hash := (hash + (self at: i) hash) hashMultiply ].
	^ hash