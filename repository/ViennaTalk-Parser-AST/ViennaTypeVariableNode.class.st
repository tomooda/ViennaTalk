Class {
	#name : #ViennaTypeVariableNode,
	#superclass : #ViennaTypeNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaTypeVariableNode class >> variableIdentifier: aString [

	^ (self new: 1)
		  variableIdentifier: aString;
		  yourself
]

{ #category : #'pretty printing' }
ViennaTypeVariableNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter format: self identifier
]

{ #category : #private }
ViennaTypeVariableNode >> freeIdentifiersExcept: aSet do: aBlock [

	self variableIdentifier freeIdentifiersExcept: aSet do: aBlock
]

{ #category : #accessing }
ViennaTypeVariableNode >> identifier [

	^ self variableIdentifier identifier
]

{ #category : #accessing }
ViennaTypeVariableNode >> identifier: aString [

	self variableIdentifier identifier: aString
]

{ #category : #testing }
ViennaTypeVariableNode >> isViennaTypeVariableNode [

	^ true
]

{ #category : #testing }
ViennaTypeVariableNode >> isViennaTypeVariableNode: aString [

	^ self string = aString
]

{ #category : #accessing }
ViennaTypeVariableNode >> label [

	^ 'TypeVariable'
]

{ #category : #accessing }
ViennaTypeVariableNode >> variableIdentifier [

	^ self at: 1
]

{ #category : #accessing }
ViennaTypeVariableNode >> variableIdentifier: aString [

	self at: 1 put: aString
]
