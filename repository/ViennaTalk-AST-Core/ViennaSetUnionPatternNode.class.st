Class {
	#name : 'ViennaSetUnionPatternNode',
	#superclass : 'ViennaPatternNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'instance creation' }
ViennaSetUnionPatternNode class >> pattern: aViennaPatternNode1 pattern: aViennaPatternNode2 [

	^ (self new: 2)
		  pattern1: aViennaPatternNode1;
		  pattern2: aViennaPatternNode2;
		  yourself
]

{ #category : 'converting' }
ViennaSetUnionPatternNode >> asExpression [

	^ ViennaSetUnionNode
		  expression: self pattern1 asExpression
		  expression: self pattern2 asExpression
]

{ #category : 'private' }
ViennaSetUnionPatternNode >> boundIdentifiersDo: aBlock [

	self pattern1 boundIdentifiersDo: aBlock.
	self pattern2 boundIdentifiersDo: aBlock
]

{ #category : 'pretty printing' }
ViennaSetUnionPatternNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter
		  print: (aViennaAbstractFormatter format: self pattern1)
		  infix: aViennaAbstractFormatter union
		  arg: (aViennaAbstractFormatter format: self pattern2)
]

{ #category : 'private' }
ViennaSetUnionPatternNode >> freeIdentifiersExcept: aSet do: aBlock [

	self pattern1 freeIdentifiersExcept: aSet do: aBlock.
	self pattern2 freeIdentifiersExcept: aSet do: aBlock
]

{ #category : 'testing' }
ViennaSetUnionPatternNode >> isViennaSetUnionPatternNode [

	^ true
]

{ #category : 'accessing' }
ViennaSetUnionPatternNode >> label [

	^ 'SetUnionPattern'
]

{ #category : 'typechecking' }
ViennaSetUnionPatternNode >> maximalType [

	| basetype isSet1 |
	basetype := ViennaType unit.
	isSet1 := false.
	self do: [ :pattern |
		pattern typecheck possibleTypesDo: [ :type |
			type isSetType ifTrue: [
				basetype := basetype + type basetype.
				isSet1 := isSet1 or: [ type isSet1Type ] ].
			type isAnyType ifTrue: [ basetype := ViennaType any ] ] ].
	^ basetype ifNotUnit: [
		  isSet1
			  ifTrue: [ basetype set1 ]
			  ifFalse: [ basetype set ] ]
]

{ #category : 'typechecking' }
ViennaSetUnionPatternNode >> maximalType: aViennaType [

	| type |
	type := ViennaType unit.
	aViennaType possibleTypesDo: [ :setType |
		setType isSetType ifTrue: [ type := type + setType ] ].
	self do: [ :pattern | pattern maximalType: aViennaType ].
	super maximalType: self maximalType
]

{ #category : 'accessing' }
ViennaSetUnionPatternNode >> pattern1 [

	^ self at: 1
]

{ #category : 'accessing' }
ViennaSetUnionPatternNode >> pattern1: aViennaPatternNode [

	self at: 1 put: aViennaPatternNode
]

{ #category : 'accessing' }
ViennaSetUnionPatternNode >> pattern2 [

	^ self at: 2
]

{ #category : 'accessing' }
ViennaSetUnionPatternNode >> pattern2: aViennaPatternNode [

	self at: 2 put: aViennaPatternNode
]
