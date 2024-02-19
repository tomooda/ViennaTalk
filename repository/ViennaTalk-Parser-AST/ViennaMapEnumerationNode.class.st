Class {
	#name : #ViennaMapEnumerationNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaMapEnumerationNode >> formatWith: aViennaAbstractFormatter [

	| elements |
	elements := aViennaAbstractFormatter formatAll: self.
	^ '{' , (aViennaAbstractFormatter
		   formatEnumerate: elements
		   ifEmpty: [ aViennaAbstractFormatter maplet ]) , '}'
]

{ #category : #private }
ViennaMapEnumerationNode >> freeIdentifiersExcept: aSet do: aBlock [

	self do: [ :maplet | maplet freeIdentifiersExcept: aSet do: aBlock ]
]

{ #category : #private }
ViennaMapEnumerationNode >> isLiteralInmap [

	self do: [ :maplet |
		maplet valueExpression isViennaSymbolicLiteralNode ifFalse: [
			^ false ] ].
	^ (self collect: #valueExpression) asSet size = self size
]

{ #category : #accessing }
ViennaMapEnumerationNode >> isViennaMapEnumerationNode [

	^ true
]

{ #category : #accessing }
ViennaMapEnumerationNode >> label [

	^ 'MapEnumeration'
]

{ #category : #typechecking }
ViennaMapEnumerationNode >> maximalType [

	| keytype valuetype |
	keytype := ViennaType unit.
	valuetype := ViennaType unit.
	self do: [ :maplet |
		keytype := keytype + maplet keyExpression typecheck.
		valuetype := valuetype + maplet valueExpression typecheck ].
	^ self isLiteralInmap
		  ifTrue: [ keytype inmapTo: valuetype ]
		  ifFalse: [ keytype mapTo: valuetype ]
]
