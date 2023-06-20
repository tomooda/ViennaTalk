Class {
	#name : #ViennaTypeVariableIdentifierNode,
	#superclass : #ViennaTypeNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaTypeVariableIdentifierNode class >> identifier: aString [

	^ (self new: 1)
		  identifier: aString;
		  yourself
]

{ #category : #private }
ViennaTypeVariableIdentifierNode >> boundIdentifiersDo: aBlock [

	aBlock value: self identifier
]

{ #category : #'pretty printing' }
ViennaTypeVariableIdentifierNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter format: self identifier
]

{ #category : #private }
ViennaTypeVariableIdentifierNode >> freeIdentifiersExcept: aSet do: aBlock [

	(aSet includes: self identifier) ifFalse: [
		aBlock value: self identifier ]
]

{ #category : #accessing }
ViennaTypeVariableIdentifierNode >> identifier [

	^ self at: 1
]

{ #category : #accessing }
ViennaTypeVariableIdentifierNode >> identifier: aString [

	self at: 1 put: aString
]

{ #category : #testing }
ViennaTypeVariableIdentifierNode >> isViennaTypeVariableIdentifierNode [

	^ true
]

{ #category : #testing }
ViennaTypeVariableIdentifierNode >> isViennaTypeVariableIdentifierNode: aString [

	^ self string = aString
]

{ #category : #accessing }
ViennaTypeVariableIdentifierNode >> label [

	^ 'TypeVariableIdentifier'
]
