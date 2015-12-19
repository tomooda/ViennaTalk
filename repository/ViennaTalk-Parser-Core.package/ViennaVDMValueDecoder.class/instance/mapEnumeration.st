parsers-expressions
mapEnumeration
	^ super mapEnumeration
		==> [ :pairs | 
			| map |
			map := Dictionary new.
			pairs do: [ :pair | map at: pair first put: pair second ].
			map ]