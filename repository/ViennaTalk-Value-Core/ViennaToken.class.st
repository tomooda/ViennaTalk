Class {
	#name : 'ViennaToken',
	#superclass : 'Object',
	#type : 'variable',
	#instVars : [
		'value'
	],
	#category : 'ViennaTalk-Value-Core',
	#package : 'ViennaTalk-Value-Core'
}

{ #category : 'instance creation' }
ViennaToken class >> with: anObject [
	^ self new
		setValue: anObject;
		yourself
]

{ #category : 'comparing' }
ViennaToken >> = anObject [
	^ self class == anObject class and: [ value = anObject value ]
]

{ #category : 'comparing' }
ViennaToken >> hash [
	^ value hash
]

{ #category : 'printing' }
ViennaToken >> neoJsonOn: neoJSONWriter [
	(Dictionary new
		at: 'token' put: value;
		yourself) neoJsonOn: neoJSONWriter
]

{ #category : 'printing' }
ViennaToken >> printOn: aStream [
	aStream
		nextPutAll: self class name;
		nextPutAll: '('.
	value printOn: aStream.
	aStream nextPutAll: ') '
]

{ #category : 'private' }
ViennaToken >> setValue: anObject [
	value := anObject
]

{ #category : 'accessing' }
ViennaToken >> value [
	^ value
]

{ #category : 'printing' }
ViennaToken >> viennaStringOn: aStream [
	aStream nextPutAll: 'mk_token('.
	value viennaStringOn: aStream.
	aStream nextPutAll: ')'
]
