Class {
	#name : 'ViennaParametricType',
	#superclass : 'ViennaBasicType',
	#instVars : [
		'identifier'
	],
	#category : 'ViennaTalk-Type-Core',
	#package : 'ViennaTalk-Type-Core'
}

{ #category : 'instance creation' }
ViennaParametricType class >> current [

	^ self shouldNotImplement
]

{ #category : 'accessing' }
ViennaParametricType class >> precedence [
	^ 6
]

{ #category : 'instance creation' }
ViennaParametricType class >> with: aString [

	^ self new
		  identifier: aString;
		  yourself
]

{ #category : 'comparing' }
ViennaParametricType >> = anObject [

	^ self class = anObject class and: [
		  identifier = anObject identifier ]
]

{ #category : 'enumerating' }
ViennaParametricType >> basicDo: aBlock [
	^ self shouldNotImplement
]

{ #category : 'testing' }
ViennaParametricType >> basicIncludes: anObject [

	^ false
]

{ #category : 'testing' }
ViennaParametricType >> basicIsEnumerable [
	^ false
]

{ #category : 'comparing' }
ViennaParametricType >> hash [

	^ self class hash bitXor: identifier hash
]

{ #category : 'accessing' }
ViennaParametricType >> identifier [

	^ identifier
]

{ #category : 'accessing' }
ViennaParametricType >> identifier: aString [

	identifier := aString
]

{ #category : 'accessing' }
ViennaParametricType >> instantiate: aDictionary [

	^ aDictionary at: self ifAbsent: [ self ]
]

{ #category : 'accessing' }
ViennaParametricType >> name [
	^ identifier
]
