testing
includes: anArray
	^ anArray isArray
		and: [ 
			anArray size = basetypes size
				and: [ (1 to: basetypes size) allSatisfy: [ :index | (basetypes at: index) includes: (anArray at: index) ] ] ]