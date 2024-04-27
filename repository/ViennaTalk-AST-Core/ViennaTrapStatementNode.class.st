Class {
	#name : #ViennaTrapStatementNode,
	#superclass : #ViennaStatementNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #'instance creation' }
ViennaTrapStatementNode class >> pattern: aViennaPatternNode handlerStatement: aViennaStatementNode1 statement: aViennaStatementNode2 [

	^ (self new: 3)
		  pattern: aViennaPatternNode;
		  handlerStatement: aViennaStatementNode1;
		  statement: aViennaStatementNode2;
		  yourself
]

{ #category : #'accessing-definitions' }
ViennaTrapStatementNode >> definitionOfLocalName: aString [

	self pattern
		allDescendantsSuchThat: [ :n |
		n isViennaPatternIdentifierNode: aString ]
		do: [ :n | ^ n ].
	^ parent ifNotNil: [ parent definitionOfLocalName: aString ]
]

{ #category : #'accessing-definitions' }
ViennaTrapStatementNode >> findResolverForIdentifier: aString [

	^ (self pattern bindsIdentifier: aString)
		  ifTrue: [ self ]
		  ifFalse: [ super findResolverForIdentifier: aString ]
]

{ #category : #'pretty printing' }
ViennaTrapStatementNode >> formatWith: aViennaAbstractFormatter [

	| pattern handler statement |
	pattern := aViennaAbstractFormatter format: self pattern.
	handler := aViennaAbstractFormatter format: self handlerStatement.
	statement := aViennaAbstractFormatter format: self statement.
	^ (aViennaAbstractFormatter needsIndent: pattern)
		  ifTrue: [
			  (aViennaAbstractFormatter
				   indentString: (aViennaAbstractFormatter keyword: 'trap')
				   insertCr: pattern) , String cr , (aViennaAbstractFormatter
				   indentString: (aViennaAbstractFormatter keyword: 'with')
				   insertCr: handler) , String cr , (aViennaAbstractFormatter
				   indentString: (aViennaAbstractFormatter keyword: 'in')
				   insertCr: statement) ]
		  ifFalse: [
			  | trap |
			  trap := (aViennaAbstractFormatter keyword: 'trap ') , pattern.
			  (aViennaAbstractFormatter needsIndent: trap , handler)
				  ifTrue: [
					  trap , String cr , (aViennaAbstractFormatter
						   indentString: (aViennaAbstractFormatter keyword: 'with')
						   insertCr: handler) , String cr , (aViennaAbstractFormatter
						   indentString: (aViennaAbstractFormatter keyword: 'in')
						   insertCr: statement) ]
				  ifFalse: [
					  trap := trap , (aViennaAbstractFormatter keyword: ' with ')
					          , handler.
					  (aViennaAbstractFormatter needsIndent: trap , statement)
						  ifTrue: [
							  trap , String cr , (aViennaAbstractFormatter
								   indentString: (aViennaAbstractFormatter keyword: 'in')
								   insertCr: statement) ]
						  ifFalse: [
						  trap , (aViennaAbstractFormatter keyword: ' in ') , statement ] ] ]
]

{ #category : #accessing }
ViennaTrapStatementNode >> freeIdentifiersExcept: aSet do: aBlock [

	self statement freeIdentifiersExcept: aSet do: aBlock.
	self pattern freeIdentifiersExcept: aSet do: aBlock.
	self handlerStatement
		freeIdentifiersExcept: aSet , self pattern uniqueBoundIdentifiers
		do: aBlock
]

{ #category : #accessing }
ViennaTrapStatementNode >> handlerStatement [

	^ self at: 2
]

{ #category : #accessing }
ViennaTrapStatementNode >> handlerStatement: aViennaStatementNode [

	self at: 2 put: aViennaStatementNode
]

{ #category : #testing }
ViennaTrapStatementNode >> isViennaTrapStatementNode [

	^ true
]

{ #category : #accessing }
ViennaTrapStatementNode >> label [

	^ 'TrapStatement'
]

{ #category : #'accessing-definitions' }
ViennaTrapStatementNode >> lookupIdentifier: aString [

	^ (self pattern bindsIdentifier: aString)
		  ifTrue: [ self ]
		  ifFalse: [ nil ]
]

{ #category : #typechecking }
ViennaTrapStatementNode >> maximalType [

	self pattern typecheck.
	^ self handlerStatement typecheck + self statement typecheck
]

{ #category : #accessing }
ViennaTrapStatementNode >> narrowestStatementWithFreeIdentifiers: anArrayOfString [

	| s1 s2 |
	(self pattern uniqueBoundIdentifiers includesAnyOf: anArrayOfString)
		ifTrue: [
			^ (self uniqueFreeIdentifiers includesAnyOf: anArrayOfString)
				  ifTrue: [ self ]
				  ifFalse: [ nil ] ].
	s1 := self statement narrowestStatementWithFreeIdentifiers:
		      anArrayOfString.
	s2 := self handlerStatement narrowestStatementWithFreeIdentifiers:
		      anArrayOfString.
	^ s1 ifNotNil: [ s2 ifNotNil: [ self ] ifNil: [ s1 ] ] ifNil: [ s2 ]
]

{ #category : #accessing }
ViennaTrapStatementNode >> pattern [

	^ self at: 1
]

{ #category : #accessing }
ViennaTrapStatementNode >> pattern: aViennaPatternNode [

	self at: 1 put: aViennaPatternNode
]

{ #category : #accessing }
ViennaTrapStatementNode >> statement [

	^ self at: 3
]

{ #category : #accessing }
ViennaTrapStatementNode >> statement: aViennaStatementNode [

	self at: 3 put: aViennaStatementNode
]
