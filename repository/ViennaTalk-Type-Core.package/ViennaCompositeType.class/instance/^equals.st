comparing
= anObject
	^ self class = anObject class
		and: [ 
			constructorName = anObject constructorName
				and: [ (1 to: self size) allSatisfy: [ :i | (self at: i) = (anObject at: i) ] ] ]