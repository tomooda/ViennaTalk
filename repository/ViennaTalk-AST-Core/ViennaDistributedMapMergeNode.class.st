Class {
	#name : 'ViennaDistributedMapMergeNode',
	#superclass : 'ViennaUnaryOperatorExpressionNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'pretty printing' }
ViennaDistributedMapMergeNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ 'merge'
]

{ #category : 'testing' }
ViennaDistributedMapMergeNode >> isViennaDistributedMapMergeNode [

	^ true
]

{ #category : 'accessing' }
ViennaDistributedMapMergeNode >> label [

	^ 'DistributedMapMerge'
]

{ #category : 'typechecking' }
ViennaDistributedMapMergeNode >> maximalType: aViennaType [

	self expression maximalType: aViennaType set1.
	super maximalType: aViennaType
]

{ #category : 'pretty printing' }
ViennaDistributedMapMergeNode >> operatorPrecedence [

	^ 36
]

{ #category : 'typechecking' }
ViennaDistributedMapMergeNode >> paramType [

	^ (ViennaType any mapTo: ViennaType any) set1
]

{ #category : 'typechecking' }
ViennaDistributedMapMergeNode >> returnTypeFor: aViennaType [

	^ aViennaType basetype
]
