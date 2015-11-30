testing
includes: anObject
	((anObject isKindOf: ViennaComposite)
		and: [  constructorName = anObject constructorName and: [ self size = anObject size ] ])
		ifFalse: [ ^ false ].
	1 to: self basicSize do: [ :index | 
		((self at: index) third includes: (anObject at: index))
			ifFalse: [ ^ false ] ].
	^ true