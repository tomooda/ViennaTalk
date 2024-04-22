Class {
	#name : #ViennaMapDomainNode,
	#superclass : #ViennaUnaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaMapDomainNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ 'dom'
]

{ #category : #testing }
ViennaMapDomainNode >> isViennaMapDomainNode [

	^ true
]

{ #category : #accessing }
ViennaMapDomainNode >> label [

	^ 'MapDomain'
]

{ #category : #typechecking }
ViennaMapDomainNode >> maximalType: aViennaType [

	| keytype |
	aViennaType isAnyType
		ifTrue: [ keytype := ViennaType any ]
		ifFalse: [
			keytype := ViennaType unit.
			aViennaType
				possibleTypesSuchThat: #isSetType
				do: [ :setType | keytype := keytype + setType basetype ] ].
	self expression maximalType: (keytype mapTo: ViennaType any).
	super maximalType: aViennaType
]

{ #category : #'pretty printing' }
ViennaMapDomainNode >> operatorPrecedence [

	^ 36
]

{ #category : #typechecking }
ViennaMapDomainNode >> paramType [

	^ ViennaType any mapTo: ViennaType any
]

{ #category : #typechecking }
ViennaMapDomainNode >> returnTypeFor: aViennaType [

	^ aViennaType keytype set
]
