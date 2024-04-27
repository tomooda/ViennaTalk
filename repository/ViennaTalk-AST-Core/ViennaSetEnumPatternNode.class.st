Class {
	#name : #ViennaSetEnumPatternNode,
	#superclass : #ViennaPatternNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #private }
ViennaSetEnumPatternNode >> boundIdentifiersDo: aBlock [

	self do: [ :pattern | pattern boundIdentifiersDo: aBlock ]
]

{ #category : #'pretty printing' }
ViennaSetEnumPatternNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter empty , '{' , (aViennaAbstractFormatter
		   formatEnumerate: (aViennaAbstractFormatter formatAll: self)
		   ifEmpty: [ aViennaAbstractFormatter empty ]) , '}'
]

{ #category : #private }
ViennaSetEnumPatternNode >> freeIdentifiersExcept: aSet do: aBlock [

	self do: [ :pattern | pattern freeIdentifiersExcept: aSet do: aBlock ]
]

{ #category : #testing }
ViennaSetEnumPatternNode >> isViennaSetEnumPatternNode [

	^ true
]

{ #category : #accessing }
ViennaSetEnumPatternNode >> label [

	^ 'SetEnumPattern'
]

{ #category : #typechecking }
ViennaSetEnumPatternNode >> maximalType [

	^ self
		  ifNotEmpty: [
			  | basetype |
			  basetype := ViennaType unit.
			  self do: [ :pattern |
				  pattern typecheck possibleTypesDo: [ :type |
					  basetype := basetype + type ] ].
			  basetype ifNotUnit: #set1 ]
		  ifEmpty: [ ViennaType unit set ]
]

{ #category : #typechecking }
ViennaSetEnumPatternNode >> maximalType: aViennaType [

	| basetype |
	basetype := ViennaType unit.
	aViennaType possibleTypesDo: [ :type |
		type isSetType ifTrue: [ basetype := basetype + type basetype ] ].
	self do: [ :pattern | pattern maximalType: basetype ].
	super maximalType: self maximalType
]
