Class {
	#name : 'ViennaRealType',
	#superclass : 'ViennaBasicType',
	#category : 'ViennaTalk-Type-Core',
	#package : 'ViennaTalk-Type-Core'
}

{ #category : 'accessing' }
ViennaRealType class >> precedence [
	^ 6
]

{ #category : 'comparing' }
ViennaRealType >> = anObject [
	^ self class = anObject class
]

{ #category : 'comparing' }
ViennaRealType >> >= aViennaType [
	^ super >= aViennaType or: [ aViennaType isRealType ]
]

{ #category : 'enumerating' }
ViennaRealType >> basicDo: aBlock [
	^ self shouldNotImplement
]

{ #category : 'testing' }
ViennaRealType >> basicIncludes: anObject [
	^ anObject isNumber
]

{ #category : 'testing' }
ViennaRealType >> basicIsEnumerable [
	^ false
]

{ #category : 'comparing' }
ViennaRealType >> hash [
	^ self class hash
]

{ #category : 'testing' }
ViennaRealType >> isCompatibleWith: aViennaType [

	^ aViennaType isRealType or: [ super isCompatibleWith: aViennaType ]
]

{ #category : 'testing' }
ViennaRealType >> isRealType [
	^ true
]

{ #category : 'accessing' }
ViennaRealType >> name [
	^ 'real'
]
