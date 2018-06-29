Class {
	#name : #ViennaCompositeType,
	#superclass : #ViennaType,
	#type : #variable,
	#instVars : [
		'constructorName'
	],
	#category : 'ViennaTalk-Type-Core'
}

{ #category : #'instance creation' }
ViennaCompositeType class >> constructorName: aString withAll: anArrayOfFieldNameAndEqualityAbstractionAndType [
	| composite |
	composite := self new: anArrayOfFieldNameAndEqualityAbstractionAndType size.
	composite setConstructorName: aString.
	1 to: anArrayOfFieldNameAndEqualityAbstractionAndType size do: [ :index | composite at: index put: (anArrayOfFieldNameAndEqualityAbstractionAndType at: index) ].
	^ composite
]

{ #category : #accessing }
ViennaCompositeType class >> precedence [
	^ 6
]

{ #category : #accessing }
ViennaCompositeType >> basetypeAt: anIndex [
	^ (self at: anIndex) third
]

{ #category : #enumerating }
ViennaCompositeType >> do: aBlock [
	| blockGenerator block |
	blockGenerator := [ :outerCollection :b | [ :v | outerCollection do: [ :outerValue | b value: (v copyWith: outerValue) ] ] ].
	block := blockGenerator value: (self basetypeAt: self size) value: aBlock.
	self size - 1 to: 2 by: -1 do: [ :index | block := blockGenerator value: (self basetypeAt: index) value: block ].
	(self basetypeAt: 1) do: [ :v | block value: (Array with: v) ]
]

{ #category : #private }
ViennaCompositeType >> fieldsCollect: aBlock [
	^ (1 to: self size) collect: [ :index | aBlock valueWithArguments: (self at: index) ]
]

{ #category : #private }
ViennaCompositeType >> fieldsDo: aBlock [
	1 to: self size do: [ :index | aBlock valueWithArguments: (self at: index) ]
]

{ #category : #testing }
ViennaCompositeType >> includes: anObject [
	((anObject isKindOf: ViennaComposite)
		and: [ self constructorName = anObject constructorName and: [ self size = anObject size ] ])
		ifFalse: [ ^ false ].
	1 to: self basicSize do: [ :index | 
		((self at: index) third includes: (anObject at: index))
			ifFalse: [ ^ false ] ].
	^ true
]

{ #category : #private }
ViennaCompositeType >> indicesAndFieldsDo: aBlock [
	1 to: self size do: [ :index | 
		| field |
		field := self at: index.
		aBlock
			value: index
			value: field first
			value: field second
			value: field third ]
]

{ #category : #testing }
ViennaCompositeType >> isEnumerable [
	1 to: self size do: [ :index | 
		(self basetypeAt: index) isEnumerable
			ifFalse: [ ^ false ] ].
	^ true
]

{ #category : #accessing }
ViennaCompositeType >> name [
	^ 'compose ' , constructorName , ' of '
		,
			(' '
				join:
					(self
						fieldsCollect: [ :fieldName :equalityAbstraction :fieldType | 
							(fieldName
								ifNil: [ '' ]
								ifNotNil: [ 
									fieldName , ':'
										,
											(equalityAbstraction = true
												ifTrue: [ '-' ]
												ifFalse: [ '' ]) ]) , fieldType name ])) , ' end'
]

{ #category : #accessing }
ViennaCompositeType >> numFields [
	^ self size
]

{ #category : #private }
ViennaCompositeType >> setConstructorName: aString [
	constructorName := aString
]

{ #category : #'instance creation' }
ViennaCompositeType >> valueWithArguments: anArray [
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
]
