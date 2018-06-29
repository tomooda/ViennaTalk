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
ViennaCompositeType class >> constructor: aString withAll: anArrayOfFieldNameAndEqualityAbstractionAndType [
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

{ #category : #enumerating }
ViennaCompositeType >> fieldsCollect: aBlock [
	^ (1 to: self basicSize) collect: [ :index | aBlock valueWithArguments: (self at: index) ]
]

{ #category : #enumerating }
ViennaCompositeType >> fieldsDo: aBlock [
	1 to: self basicSize do: [ :index | aBlock valueWithArguments: (self at: index) ]
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
	^ self basicSize
]

{ #category : #private }
ViennaCompositeType >> setConstructorName: aString [
	constructorName := aString
]
