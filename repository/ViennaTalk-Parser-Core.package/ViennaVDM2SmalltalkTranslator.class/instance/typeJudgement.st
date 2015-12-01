parsers-type discriminations
typeJudgement
	^ super typeJudgement
		==> [ :pair | 
			| t e |
			t := pair second.
			e := pair first.
			'(' , t , ' includes: ' , e , ')' ]