Class {
	#name : #ViennaInitialisationNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaInitialisationNode class >> invariantInitialFunction: aViennaInvariantInitialFunctionNode [

	^ (self new: 1)
		  invariantInitialFunction: aViennaInvariantInitialFunctionNode;
		  yourself
]

{ #category : #private }
ViennaInitialisationNode >> boundIdentifiersDo: aBlock [

	
]

{ #category : #accessing }
ViennaInitialisationNode >> expression [

	^ self invariantInitialFunction ifNotNil: #expression
]

{ #category : #'pretty printing' }
ViennaInitialisationNode >> formatWith: aViennaAbstractFormatter [

	^ 'init '
	  , (aViennaAbstractFormatter format: self invariantInitialFunction)
]

{ #category : #private }
ViennaInitialisationNode >> freeIdentifiersExcept: aSet do: aBlock [

	self invariantInitialFunction freeIdentifiersExcept: aSet do: aBlock
]

{ #category : #accessing }
ViennaInitialisationNode >> invariantInitialFunction [

	^ self at: 1
]

{ #category : #accessing }
ViennaInitialisationNode >> invariantInitialFunction: aViennaInvariantInitialFunctionNode [

	self at: 1 put: aViennaInvariantInitialFunctionNode
]

{ #category : #accessing }
ViennaInitialisationNode >> isViennaInitialisationNode [

	^ true
]

{ #category : #accessing }
ViennaInitialisationNode >> label [

	^ 'Initialisation'
]

{ #category : #accessing }
ViennaInitialisationNode >> pattern [

	^ self invariantInitialFunction pattern
]

{ #category : #accessing }
ViennaInitialisationNode >> pattern: aViennaPatternNode [

	^ self invariantInitialFunction pattern: aViennaPatternNode
]
