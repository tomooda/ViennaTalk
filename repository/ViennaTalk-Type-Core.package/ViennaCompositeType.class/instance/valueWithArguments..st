instance creation
valueWithArguments: anArray
	| composite |
	composite := ViennaComposite constructorName: constructorName withAll: anArray.
	self
		indicesAndFieldsDo: [ :index :fieldName :equalityAbstraction :type | 
			fieldName
				ifNotNil: [ 
					equalityAbstraction = true
						ifTrue: [ composite equalityAbstractionFieldNameAt: index put: fieldName ]
						ifFalse: [ composite fieldNameAt: index put: fieldName ] ] ].
	^ composite