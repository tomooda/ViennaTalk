Class {
	#name : #ViennaMapMergeNode,
	#superclass : #ViennaBinaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #'pretty printing' }
ViennaMapMergeNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter munion
]

{ #category : #'pretty printing' }
ViennaMapMergeNode >> ifAssociatesLeftDo: aBlock1 ifAssociatesRightDo: aBlock2 otherwise: aBlock3 [

	^ aBlock1 value
]

{ #category : #accessing }
ViennaMapMergeNode >> isViennaMapMergeNode [

	^ true
]

{ #category : #accessing }
ViennaMapMergeNode >> label [

	^ 'MapMerge'
]

{ #category : #accessing }
ViennaMapMergeNode >> maximalType: aViennaType [

	self expression1 maximalType: aViennaType.
	self expression2 maximalType: aViennaType.
	super maximalType: aViennaType
]

{ #category : #'pretty printing' }
ViennaMapMergeNode >> operatorPrecedence [

	^ 31
]

{ #category : #accessing }
ViennaMapMergeNode >> paramType1 [

	^ ViennaType any mapTo: ViennaType any
]

{ #category : #accessing }
ViennaMapMergeNode >> paramType2 [

	^ ViennaType any mapTo: ViennaType any
]

{ #category : #accessing }
ViennaMapMergeNode >> returnTypeFor: aViennaType1 and: aViennaType2 [

	| domaintype1 domaintype2 domaintype rangetype1 rangetype2 rangetype |
	domaintype1 := aViennaType1 keytype.
	domaintype2 := aViennaType2 keytype.
	domaintype := domaintype1 >= domaintype2
		              ifTrue: [ domaintype1 ]
		              ifFalse: [
			              domaintype2 >= domaintype1
				              ifTrue: [ domaintype2 ]
				              ifFalse: [ domaintype1 | domaintype2 ] ].
	rangetype1 := aViennaType1 valuetype.
	rangetype2 := aViennaType2 valuetype.
	rangetype := rangetype1 >= rangetype2
		             ifTrue: [ rangetype1 ]
		             ifFalse: [
			             rangetype2 >= rangetype1
				             ifTrue: [ rangetype2 ]
				             ifFalse: [ rangetype1 | rangetype2 ] ].
	^ domaintype mapTo: rangetype
]
