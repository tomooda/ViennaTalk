parsers-types
mapType
	^ super mapType
		==> [ :pair | 
			| domaintype rangetype |
			domaintype := pair first.
			rangetype := pair second.
			'(' , domaintype , ' mapTo: ' , rangetype , ')' ]