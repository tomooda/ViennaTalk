Class {
	#name : #ViennaComposite,
	#superclass : #Object,
	#type : #variable,
	#instVars : [
		'namedFields',
		'equalityFields',
		'constructorName'
	],
	#category : 'ViennaTalk-Value-Core'
}

{ #category : #'instance creation' }
ViennaComposite class >> type: aString [
	^ self type: aString withAll: Array new
]

{ #category : #'instance creation' }
ViennaComposite class >> type: aString with: anObject [
	^ self type: aString withAll: (Array with:anObject)
]

{ #category : #'instance creation' }
ViennaComposite class >> type: aString with: anObject1 with: anObject2 [
	^ self type: aString withAll: (Array with: anObject1 with: anObject2)
]

{ #category : #'instance creation' }
ViennaComposite class >> type: aString with: anObject1 with: anObject2 with: anObject3 [
	^ self type: aString withAll: (Array with: anObject1 with: anObject2 with: anObject3)
]

{ #category : #'instance creation' }
ViennaComposite class >> type: aString with: anObject1 with: anObject2 with: anObject3 with: anObject4 [
	^ self
		type: aString
		withAll:
			(Array
				with: anObject1
				with: anObject2
				with: anObject3
				with: anObject4)
]

{ #category : #'instance creation' }
ViennaComposite class >> type: aString with: anObject1 with: anObject2 with: anObject3 with: anObject4 with: anObject5 [
	^ self
		type: aString
		withAll:
			(Array
				with: anObject1
				with: anObject2
				with: anObject3
				with: anObject4
				with: anObject5)
]

{ #category : #'instance creation' }
ViennaComposite class >> type: aString withAll: anArray [
	| composite |
	composite := self new: anArray size.
	composite setConstructorName: aString.
	1 to: anArray size do: [ :index | composite at: index put: (anArray at: index) ].
	^ composite
]

{ #category : #comparing }
ViennaComposite >> = anObject [
	self == anObject
		ifTrue: [ ^ true ].
	constructorName = anObject constructorName
		ifFalse: [ ^ false ].
	self size = anObject size
		ifFalse: [ ^ false ].
	equalityFields
		do: [ :index | 
			(self at: index) = (anObject at: index)
				ifFalse: [ ^ false ] ].
	^ true
]

{ #category : #accessing }
ViennaComposite >> at: anIntegerOrString [
	^ super
		at:
			(anIntegerOrString isString
				ifTrue: [ namedFields at: anIntegerOrString ]
				ifFalse: [ anIntegerOrString ])
]

{ #category : #accessing }
ViennaComposite >> constructorName [
	^ constructorName
]

{ #category : #'accessing-field types' }
ViennaComposite >> equalityAbstractionFieldNameAt: anInteger put: aString [
	namedFields at: aString put: anInteger.
	equalityFields := equalityFields copyWithout: anInteger
]

{ #category : #'accessing-field types' }
ViennaComposite >> fieldNameAt: anInteger put: aString [
	namedFields at: aString put: anInteger
]

{ #category : #comparing }
ViennaComposite >> hash [
	| hash |
	hash := constructorName hash.
	1 to: self size do: [ :i | hash := (hash + (self at: i) hash) hashMultiply ].
	^ hash
]

{ #category : #'initialize-release' }
ViennaComposite >> initialize [
	super initialize.
	namedFields := Dictionary new.
	equalityFields := (1 to: self size) asArray
]

{ #category : #testing }
ViennaComposite >> isViennaComposite [
	^ true
]

{ #category : #printing }
ViennaComposite >> printOn: aStream [
	aStream nextPutAll: self class name.
	aStream nextPut: $(.
	self vdmcStringOn: aStream.
	aStream nextPut: $)
]

{ #category : #private }
ViennaComposite >> setConstructorName: aString [
	constructorName := aString
]

{ #category : #printing }
ViennaComposite >> vdmcStringOn: aStream [
	aStream
		nextPutAll: 'mk_';
		nextPutAll: constructorName;
		nextPut: $(.
	(1 to: self size) do: [ :index | (self at: index) printOn: aStream ] separatedBy: [ aStream nextPut: $, ].
	aStream nextPut: $)
]
