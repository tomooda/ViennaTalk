parsers-expressions-operators
power: set
	^ '(' , set
		,
			' asArray in: [:set | | power | power := Set new: 1<<set size. 0 to: 1<<(set size)-1 do: [ :i | | elem | elem := Set new:set size//2. 1 to: set size do: [ :b | (i bitAt: b) = 0 ifTrue: [ elem add: (set at: b) ] ]. power add: elem]. power])'