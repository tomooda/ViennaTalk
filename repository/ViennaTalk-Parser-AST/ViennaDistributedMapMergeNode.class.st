Class {
	#name : #ViennaDistributedMapMergeNode,
	#superclass : #ViennaUnaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaDistributedMapMergeNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ 'merge'
]

{ #category : #testing }
ViennaDistributedMapMergeNode >> isViennaDistributedMapMergeNode [

	^ true
]

{ #category : #accessing }
ViennaDistributedMapMergeNode >> label [

	^ 'DistributedMapMerge'
]

{ #category : #'pretty printing' }
ViennaDistributedMapMergeNode >> operatorPrecedence [

	^ 36
]

{ #category : #typechecking }
ViennaDistributedMapMergeNode >> paramType [

	^ (ViennaType any mapTo: ViennaType any) set1
]

{ #category : #typechecking }
ViennaDistributedMapMergeNode >> returnTypeFor: aViennaType [

	^ aViennaType basetype
]
