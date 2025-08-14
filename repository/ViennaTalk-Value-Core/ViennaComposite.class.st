Class {
	#name : 'ViennaComposite',
	#superclass : 'Object',
	#type : 'variable',
	#instVars : [
		'namedFields',
		'equalityFields',
		'constructorName'
	],
	#category : 'ViennaTalk-Value-Core',
	#package : 'ViennaTalk-Value-Core'
}

{ #category : 'instance creation' }
ViennaComposite class >> constructorName: aString [
	^ self constructorName: aString withAll: Array new
]

{ #category : 'instance creation' }
ViennaComposite class >> constructorName: aString with: anObject [
	^ self constructorName: aString withAll: (Array with:anObject)
]

{ #category : 'instance creation' }
ViennaComposite class >> constructorName: aString with: anObject1 with: anObject2 [
	^ self constructorName: aString withAll: (Array with: anObject1 with: anObject2)
]

{ #category : 'instance creation' }
ViennaComposite class >> constructorName: aString with: anObject1 with: anObject2 with: anObject3 [
	^ self constructorName: aString withAll: (Array with: anObject1 with: anObject2 with: anObject3)
]

{ #category : 'instance creation' }
ViennaComposite class >> constructorName: aString with: anObject1 with: anObject2 with: anObject3 with: anObject4 with: anObject5 [
	^ self
		constructorName: aString
		withAll:
			(Array
				with: anObject1
				with: anObject2
				with: anObject3
				with: anObject4
				with: anObject5)
]

{ #category : 'instance creation' }
ViennaComposite class >> constructorName: aString withAll: anArray [
	| composite |
	composite := self new: anArray size.
	composite setConstructorName: aString.
	1 to: anArray size do: [ :index | composite at: index put: (anArray at: index) ].
	^ composite
]

{ #category : 'instance creation' }
ViennaComposite class >> consturctorName: aString with: anObject1 with: anObject2 with: anObject3 with: anObject4 [
	^ self
		constructorName: aString
		withAll:
			(Array
				with: anObject1
				with: anObject2
				with: anObject3
				with: anObject4)
]

{ #category : 'comparing' }
ViennaComposite >> = anObject [
	^ self == anObject
		or: [ anObject isViennaComposite
				and: [ constructorName = anObject constructorName
						and: [ self size = anObject size
								and: [ equalityFields allSatisfy: [ :index | (self at: index) = (anObject at: index) ] ] ] ] ]
]

{ #category : 'converting' }
ViennaComposite >> asArray [
	| array |
	array := Array new: self size.
	1 to: self size do: [ :index | array at: index put: (self at: index) ].
	^ array
]

{ #category : 'accessing' }
ViennaComposite >> at: anIntegerOrString [
	^ super
		at:
			(anIntegerOrString isString
				ifTrue: [ namedFields at: anIntegerOrString ]
				ifFalse: [ anIntegerOrString ])
]

{ #category : 'accessing' }
ViennaComposite >> at: anIntegerOrString put: anObject [
	^ super
		at:
			(anIntegerOrString isString
				ifTrue: [ namedFields at: anIntegerOrString ]
				ifFalse: [ anIntegerOrString ])
		put: anObject
]

{ #category : 'accessing' }
ViennaComposite >> constructorName [
	^ constructorName
]

{ #category : 'accessing' }
ViennaComposite >> copyAt: anIntegerOrString put: anObject [
	^ self copy
		at: anIntegerOrString put: anObject;
		yourself
]

{ #category : 'accessing' }
ViennaComposite >> copyAtPath: anArrayOfKey put: anObject [
	| copy |
	copy := self copy.
	anArrayOfKey size = 1
		ifTrue: [ copy at: anArrayOfKey first put: anObject ]
		ifFalse: [ copy at: anArrayOfKey first put: ((copy at: anArrayOfKey first) copyAtPath: anArrayOfKey tail put: anObject) ].
	^ copy
]

{ #category : 'accessing-field types' }
ViennaComposite >> equalityAbstractionFieldNameAt: anInteger put: aString [
	namedFields at: aString put: anInteger.
	equalityFields := equalityFields copyWithout: anInteger
]

{ #category : 'accessing-field types' }
ViennaComposite >> fieldNameAt: anInteger put: aString [
	namedFields at: aString put: anInteger
]

{ #category : 'enumerating' }
ViennaComposite >> fieldNamesAndValuesDo: aBlock [

	namedFields keysAndValuesDo: [ :name :index |
		aBlock value: name value: (self basicAt: index) ]
]

{ #category : 'comparing' }
ViennaComposite >> hash [
	| hash |
	hash := constructorName hash.
	1 to: self size do: [ :i | hash := (hash + (self at: i) hash) hashMultiply ].
	^ hash
]

{ #category : 'initialize-release' }
ViennaComposite >> initialize [
	super initialize.
	namedFields := Dictionary new.
	equalityFields := (1 to: self size) asArray
]

{ #category : 'testing' }
ViennaComposite >> isViennaComposite [
	^ true
]

{ #category : 'private' }
ViennaComposite >> namedFields [
	^ namedFields
]

{ #category : 'printing' }
ViennaComposite >> neoJsonOn: neoJSONWriter [
	(Dictionary new
		at: constructorName put: self asArray;
		yourself) neoJsonOn: neoJSONWriter
]

{ #category : 'copying' }
ViennaComposite >> postCopy [
	namedFields := namedFields copy.
	equalityFields := namedFields copy
]

{ #category : 'printing' }
ViennaComposite >> printOn: aStream [
	aStream nextPutAll: self class name.
	aStream nextPut: $(.
	self viennaStringOn: aStream.
	aStream nextPut: $)
]

{ #category : 'private' }
ViennaComposite >> setConstructorName: aString [
	constructorName := aString
]

{ #category : 'printing' }
ViennaComposite >> viennaStringOn: aStream [
	aStream
		nextPutAll: 'mk_';
		nextPutAll: self constructorName;
		nextPutAll: '('.
	(1 to: self size) do: [ :index | (self at: index) viennaStringOn: aStream ] separatedBy: [ aStream nextPutAll: ', ' ].
	aStream nextPutAll: ')'
]
