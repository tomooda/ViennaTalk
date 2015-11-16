comparing
= anObject
	self == anObject
		ifTrue: [ ^ true ].
	typeName = anObject typeName
		ifFalse: [ ^ false ].
	self size = anObject size
		ifFalse: [ ^ false ].
	equalityFields
		do: [ :index | 
			(self at: index) = (anObject at: index)
				ifFalse: [ ^ false ] ].
	^ true