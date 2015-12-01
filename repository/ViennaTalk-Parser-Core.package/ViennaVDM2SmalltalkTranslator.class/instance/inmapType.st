parsers-types
inmapType
	^ super inmapType
		==> [ :pair | 
			| domaintype rangetype |
			domaintype := pair first.
			rangetype := pair second.
			'(' , domaintype , ' inmapTo: ' , rangetype , ')' ]