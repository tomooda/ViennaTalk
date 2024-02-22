Class {
	#name : #ViennaInvariantNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #accessing }
ViennaInvariantNode class >> invariantInitialFunction: aViennaInvariantInitialFunctionNode [

	^ (self new: 1)
		  invariantInitialFunction: aViennaInvariantInitialFunctionNode;
		  yourself
]

{ #category : #private }
ViennaInvariantNode >> boundIdentifiersDo: aBlock [

	
]

{ #category : #accessing }
ViennaInvariantNode >> expression [

	^ self invariantInitialFunction ifNotNil: #expression
]

{ #category : #'pretty printing' }
ViennaInvariantNode >> formatWith: aViennaAbstractFormatter [

	^ 'inv '
	  , (aViennaAbstractFormatter format: self invariantInitialFunction)
]

{ #category : #private }
ViennaInvariantNode >> freeIdentifiersExcept: aSet do: aBlock [

	self invariantInitialFunction freeIdentifiersExcept: aSet do: aBlock
]

{ #category : #accessing }
ViennaInvariantNode >> invariantInitialFunction [

	^ self at: 1
]

{ #category : #accessing }
ViennaInvariantNode >> invariantInitialFunction: aViennaInvariantInitialFunctionNode [

	self at: 1 put: aViennaInvariantInitialFunctionNode
]

{ #category : #testing }
ViennaInvariantNode >> isViennaInvariantNode [

	^ true
]

{ #category : #accessing }
ViennaInvariantNode >> label [

	^ 'Invariant'
]

{ #category : #typechecking }
ViennaInvariantNode >> maximalType [

	^ self invariantInitialFunction typecheck
]

{ #category : #typechecking }
ViennaInvariantNode >> maximalType: aViennaType [

	self invariantInitialFunction maximalType: aViennaType
]

{ #category : #accessing }
ViennaInvariantNode >> pattern [

	^ self invariantInitialFunction ifNotNil: #pattern
]

{ #category : #accessing }
ViennaInvariantNode >> pattern: aViennaPatternNode [

	^ self invariantInitialFunction pattern: aViennaPatternNode
]
