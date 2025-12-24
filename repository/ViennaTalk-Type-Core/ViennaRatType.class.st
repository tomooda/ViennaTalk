Class {
	#name : 'ViennaRatType',
	#superclass : 'ViennaBasicType',
	#category : 'ViennaTalk-Type-Core',
	#package : 'ViennaTalk-Type-Core'
}

{ #category : 'accessing' }
ViennaRatType class >> precedence [
	^ 6
]

{ #category : 'comparing' }
ViennaRatType >> = anObject [
	^ self class = anObject class
]

{ #category : 'comparing' }
ViennaRatType >> >= aViennaType [
	^ super >= aViennaType or: [ aViennaType isRealType ]
]

{ #category : 'enumerating' }
ViennaRatType >> basicDo: aBlock [
	^ self shouldNotImplement
]

{ #category : 'testing' }
ViennaRatType >> basicIncludes: anObject [
	^ anObject isNumber
]

{ #category : 'testing' }
ViennaRatType >> basicIsEnumerable [
	^ false
]

{ #category : 'comparing' }
ViennaRatType >> hash [
	^ self class hash
]

{ #category : 'testing' }
ViennaRatType >> isCompatibleWith: aViennaType [

	^ aViennaType isRealType or: [ super isCompatibleWith: aViennaType ]
]

{ #category : 'testing' }
ViennaRatType >> isRealType [
	^ true
]

{ #category : 'accessing' }
ViennaRatType >> name [
	^ 'real'
]
