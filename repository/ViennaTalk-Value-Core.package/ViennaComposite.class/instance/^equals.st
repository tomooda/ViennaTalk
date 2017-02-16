comparing
= anObject
	^ self == anObject
		or: [ anObject isViennaComposite
				and: [ constructorName = anObject constructorName
						and: [ self size = anObject size
								and: [ equalityFields allSatisfy: [ :index | (self at: index) = (anObject at: index) ] ] ] ] ]