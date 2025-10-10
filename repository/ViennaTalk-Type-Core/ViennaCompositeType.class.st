Class {
	#name : 'ViennaCompositeType',
	#superclass : 'ViennaCompoundType',
	#type : 'variable',
	#instVars : [
		'constructorName'
	],
	#category : 'ViennaTalk-Type-Core',
	#package : 'ViennaTalk-Type-Core'
}

{ #category : 'instance creation' }
ViennaCompositeType class >> constructorName: aString withAll: anArrayOfFieldNameAndEqualityAbstractionAndType [
	| composite |
	composite := self new: anArrayOfFieldNameAndEqualityAbstractionAndType size.
	composite setConstructorName: aString.
	1 to: anArrayOfFieldNameAndEqualityAbstractionAndType size do: [ :index | composite at: index put: (anArrayOfFieldNameAndEqualityAbstractionAndType at: index) ].
	^ composite
]

{ #category : 'accessing' }
ViennaCompositeType class >> precedence [
	^ 6
]

{ #category : 'comparing' }
ViennaCompositeType >> = anObject [
	^ self class = anObject class
		and: [ 
			constructorName = anObject constructorName
				and: [ (1 to: self size) allSatisfy: [ :i | (self at: i) = (anObject at: i) ] ] ]
]

{ #category : 'instance creation' }
ViennaCompositeType >> applyTo: anArray [
	^ self valueWithArguments: anArray
]

{ #category : 'accessing' }
ViennaCompositeType >> basetypeAt: anIndex [
	^ (self at: anIndex) third
]

{ #category : 'accessing' }
ViennaCompositeType >> basetypeAtName: aString ifAbsent: errorBlock [

	1 to: self size do: [ :index |
		(self at: index) first = aString ifTrue: [ ^ (self at: index) third ] ].
	^ errorBlock value
]

{ #category : 'accessing' }
ViennaCompositeType >> basetypes: anArrayOfViennaType [

	1 to: self size do: [ :index |
	self at: index put: (anArrayOfViennaType at: index) ]
]

{ #category : 'enumerating' }
ViennaCompositeType >> basicDo: aBlock [
	| blockGenerator block |
	blockGenerator := [ :outerCollection :b | [ :v | outerCollection do: [ :outerValue | b value: (v copyWith: outerValue) ] ] ].
	block := blockGenerator value: (self basetypeAt: self size) value: aBlock.
	self size - 1 to: 2 by: -1 do: [ :index | block := blockGenerator value: (self basetypeAt: index) value: block ].
	(self basetypeAt: 1) do: [ :v | block value: (Array with: v) ]
]

{ #category : 'testing' }
ViennaCompositeType >> basicIncludes: anObject [
	((anObject isKindOf: ViennaComposite)
		and: [ constructorName = anObject constructorName and: [ self size = anObject size ] ])
		ifFalse: [ ^ false ].
	1 to: self basicSize do: [ :index | 
		((self at: index) third includes: (anObject at: index))
			ifFalse: [ ^ false ] ].
	^ true
]

{ #category : 'testing' }
ViennaCompositeType >> basicIsEnumerable [
	1 to: self size do: [ :index | 
		(self basetypeAt: index) isEnumerable
			ifFalse: [ ^ false ] ].
	^ true
]

{ #category : 'accessing' }
ViennaCompositeType >> constructorName [
	^ constructorName
]

{ #category : 'private' }
ViennaCompositeType >> fieldsCollect: aBlock [
	^ (1 to: self size) collect: [ :index | aBlock valueWithArguments: (self at: index) ]
]

{ #category : 'private' }
ViennaCompositeType >> fieldsDo: aBlock [
	1 to: self size do: [ :index | aBlock valueWithArguments: (self at: index) ]
]

{ #category : 'comparing' }
ViennaCompositeType >> hash [
	^ (1 to: self size) inject: constructorName hash into: [ :hash :field | hash bitXor: field hash ]
]

{ #category : 'testing' }
ViennaCompositeType >> includesField: aString [

	1 to: self size do: [ :index |
	aString = (self at: index) first ifTrue: [ ^ true ] ].
	^ false
]

{ #category : 'private' }
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

{ #category : 'accessing' }
ViennaCompositeType >> instantiate: aDictionary [

	^ self class
		  constructorName: self constructorName
		  withAll: (self fieldsCollect: [ :f :e :t |
				   {
					   f.
					   e.
					   (t instantiate: aDictionary) } ])
]

{ #category : 'testing' }
ViennaCompositeType >> isCompositeType [

	^ true
]

{ #category : 'accessing' }
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

{ #category : 'accessing' }
ViennaCompositeType >> numFields [
	^ self size
]

{ #category : 'private' }
ViennaCompositeType >> removeTypeHolders: aSet [
	(aSet includes: self) ifTrue: [ ^self ].
	aSet add: self.
	1 to: self size do: [ :index | 
		| field |
		field := self at: index.
		field at: 3 put: ((field at: 3) removeTypeHolders: aSet) ]
]

{ #category : 'private' }
ViennaCompositeType >> setConstructorName: aString [
	constructorName := aString
]

{ #category : 'accessing' }
ViennaCompositeType >> shortName [
	^ constructorName
]

{ #category : 'instance creation' }
ViennaCompositeType >> value: anObject [
	^ self valueWithArguments: (Array with: anObject)
]

{ #category : 'instance creation' }
ViennaCompositeType >> value: anObject1 value: anObject2 [
	^ self valueWithArguments: (Array with: anObject1 with: anObject2)
]

{ #category : 'instance creation' }
ViennaCompositeType >> value: anObject1 value: anObject2 value: anObject3 [
	^ self valueWithArguments: (Array with: anObject1 with: anObject2 with: anObject3)
]

{ #category : 'instance creation' }
ViennaCompositeType >> value: anObject1 value: anObject2 value: anObject3 value: anObject4 [
	^ self
		valueWithArguments:
			(Array
				with: anObject1
				with: anObject2
				with: anObject3
				with: anObject4)
]

{ #category : 'instance creation' }
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
