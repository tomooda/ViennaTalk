Class {
	#name : #VDMComposite,
	#superclass : #Object,
	#type : #variable,
	#instVars : [
		'typeName',
		'namedFields',
		'equalityFields'
	],
	#category : 'ViennaTalk-Value-Core'
}

{ #category : #'instance creation' }
VDMComposite class >> type: aString [
	^ self type: aString withAll: Array new
]

{ #category : #'instance creation' }
VDMComposite class >> type: aString with: anObject [
	^ self type: aString withAll: (Array with:anObject)
]

{ #category : #'instance creation' }
VDMComposite class >> type: aString with: anObject1 with: anObject2 [
	^ self type: aString withAll: (Array with: anObject1 with: anObject2)
]

{ #category : #'instance creation' }
VDMComposite class >> type: aString with: anObject1 with: anObject2 with: anObject3 [
	^ self type: aString withAll: (Array with: anObject1 with: anObject2 with: anObject3)
]

{ #category : #'instance creation' }
VDMComposite class >> type: aString with: anObject1 with: anObject2 with: anObject3 with: anObject4 [
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
VDMComposite class >> type: aString with: anObject1 with: anObject2 with: anObject3 with: anObject4 with: anObject5 [
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
VDMComposite class >> type: aString withAll: anArray [
	| composite |
	composite := self new: anArray size.
	composite setTypeName: aString.
	1 to: anArray size do: [ :index | composite at: index put: (anArray at: index) ].
	^ composite
]

{ #category : #comparing }
VDMComposite >> = anObject [
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
]

{ #category : #accessing }
VDMComposite >> at: anIntegerOrString [
	^ super
		at:
			(anIntegerOrString isString
				ifTrue: [ namedFields at: anIntegerOrString ]
				ifFalse: [ anIntegerOrString ])
]

{ #category : #'accessing-field types' }
VDMComposite >> equalityAbstractionFieldNameAt: anInteger put: aString [
	namedFields at: aString put: anInteger.
	equalityFields := equalityFields copyWithout: anInteger
]

{ #category : #'accessing-field types' }
VDMComposite >> fieldNameAt: anInteger put: aString [
	namedFields at: aString put: anInteger
]

{ #category : #comparing }
VDMComposite >> hash [
	| hash |
	hash := typeName hash.
	1 to: self size do: [ :i | hash := (hash + (self at: i) hash) hashMultiply ].
	^ hash
]

{ #category : #'initialize-release' }
VDMComposite >> initialize [
	super initialize.
	namedFields := Dictionary new.
	equalityFields := (1 to: self size) asArray
]

{ #category : #printing }
VDMComposite >> printOn: aStream [
	aStream nextPutAll: self class name.
	aStream nextPut: $(.
	self vdmcStringOn: aStream.
	aStream nextPut: $)
]

{ #category : #private }
VDMComposite >> setTypeName: aString [
	typeName := aString
]

{ #category : #accessing }
VDMComposite >> typeName [
	^ typeName
]

{ #category : #printing }
VDMComposite >> vdmcStringOn: aStream [
	aStream
		nextPutAll: 'mk_';
		nextPutAll: typeName;
		nextPut: $(.
	(1 to: self size) do: [ :index | (self at: index) printOn: aStream ] separatedBy: [ aStream nextPut: $, ].
	aStream nextPut: $)
]
