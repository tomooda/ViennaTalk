parsers-patterns
setUnionPattern
	^ super setUnionPattern
		==> [ :pair | 
			| vars pat1 pat2 |
			vars := (pair first first , pair second first) asSet asArray.
			pat1 := pair first second.
			pat2 := pair second second.
			{vars.
			('(ViennaRuntimeUtil match: ' , pat1 , ' union: ' , pat2 , ')')} ]