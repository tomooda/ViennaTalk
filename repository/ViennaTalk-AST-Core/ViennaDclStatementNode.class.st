Class {
	#name : #ViennaDclStatementNode,
	#superclass : #ViennaStatementNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #private }
ViennaDclStatementNode >> boundIdentifiersDo: aBlock [

	self do: [ :assignmentDefinition |
		assignmentDefinition boundIdentifiersDo: aBlock ]
]

{ #category : #'accessing-definitions' }
ViennaDclStatementNode >> definitionOfLocalName: aString [

	^ self
		  detect: [ :assignmentDefinition |
		  assignmentDefinition identifier = aString ]
		  ifNone: [
		  parent ifNotNil: [ parent definitionOfLocalName: aString ] ]
]

{ #category : #'pretty printing' }
ViennaDclStatementNode >> formatWith: aViennaAbstractFormatter [

	| assigns |
	assigns := aViennaAbstractFormatter formatAll: self.
	^ (aViennaAbstractFormatter keyword: 'dcl')
	  , ((aViennaAbstractFormatter anyNeedsIndent: assigns)
			   ifTrue: [
				   aViennaAbstractFormatter cr , aViennaAbstractFormatter indent
				   ,
				   (aViennaAbstractFormatter
					    indentAllStrings: assigns
					    withSeparator: ',') ]
			   ifFalse: [
				   aViennaAbstractFormatter space
				   , (aViennaAbstractFormatter join: ', ' withAll: assigns) ])
]

{ #category : #private }
ViennaDclStatementNode >> freeIdentifiersExcept: aSet do: aBlock [

	| boundIdentifiers |
	boundIdentifiers := aSet.
	self do: [ :assignmentDefinition |
		boundIdentifiers := boundIdentifiers
		                    , assignmentDefinition uniqueBoundIdentifiers.
		assignmentDefinition
			freeIdentifiersExcept: boundIdentifiers
			do: aBlock ]
]

{ #category : #testing }
ViennaDclStatementNode >> isViennaDclStatementNode [

	^ true
]

{ #category : #accessing }
ViennaDclStatementNode >> label [

	^ 'DclStatement'
]

{ #category : #typechecking }
ViennaDclStatementNode >> maximalType [

	self do: #typecheck.
	^ ViennaType unit
]
