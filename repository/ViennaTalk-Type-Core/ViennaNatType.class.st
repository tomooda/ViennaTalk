Class {
	#name : 'ViennaNatType',
	#superclass : 'ViennaBasicType',
	#category : 'ViennaTalk-Type-Core',
	#package : 'ViennaTalk-Type-Core'
}

{ #category : 'accessing' }
ViennaNatType class >> precedence [
	^ 6
]

{ #category : 'comparing' }
ViennaNatType >> = anObject [
	^ self class = anObject class
]

{ #category : 'comparing' }
ViennaNatType >> >= aViennaType [
	^ super >= aViennaType or: [ aViennaType isNatType ]
]

{ #category : 'enumerating' }
ViennaNatType >> basicDo: aBlock [
	^ self shouldNotImplement
]

{ #category : 'testing' }
ViennaNatType >> basicIncludes: anObject [

	^ (anObject isInteger and: [ anObject >= 0 ]) or: [
			  anObject isFloat and: [
				  anObject >= 0.0 and: [ (anObject truncateTo: 1.0) = anObject ] ] ]
]

{ #category : 'testing' }
ViennaNatType >> basicIsEnumerable [
	^ false
]

{ #category : 'comparing' }
ViennaNatType >> hash [
	^ self class hash
]

{ #category : 'testing' }
ViennaNatType >> isCompatibleWith: aViennaType [

	^ aViennaType isRealType or: [ super isCompatibleWith: aViennaType ]
]

{ #category : 'testing' }
ViennaNatType >> isIntType [
	^ true
]

{ #category : 'testing' }
ViennaNatType >> isNatType [
	^ true
]

{ #category : 'testing' }
ViennaNatType >> isRealType [
	^ true
]

{ #category : 'accessing' }
ViennaNatType >> name [
	^ 'nat'
]
