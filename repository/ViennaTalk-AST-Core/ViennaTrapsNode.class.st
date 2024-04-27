Class {
	#name : #ViennaTrapsNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #private }
ViennaTrapsNode >> boundIdentifiersDo: aBlock [

	
]

{ #category : #'pretty printing' }
ViennaTrapsNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter empty , '{' , (self
		   ifNotEmpty: [
			   aViennaAbstractFormatter
				   join: ',' , aViennaAbstractFormatter cr
				   withAll: ((1 to: self size by: 2) collect: [ :index |
						    (aViennaAbstractFormatter format: (self at: index))
						    , ' |-> ' , (aViennaAbstractFormatter indentString:
							     (aViennaAbstractFormatter format: (self at: index + 1))) ]) ]
		   ifEmpty: [ aViennaAbstractFormatter empty ]) , '}'
]

{ #category : #private }
ViennaTrapsNode >> freeIdentifiersExcept: aSet do: aBlock [

	self patternsAndStatementsDo: [ :pattern :statement |
		pattern freeIdentifiersExcept: aSet do: aBlock.
		statement
			freeIdentifiersExcept: aSet , pattern uniqueBoundIdentifiers
			do: aBlock ]
]

{ #category : #testing }
ViennaTrapsNode >> isViennaTrapsNode [

	^ true
]

{ #category : #accessing }
ViennaTrapsNode >> label [

	^ 'Traps'
]

{ #category : #typechecking }
ViennaTrapsNode >> maximalType [

	| type |
	type := ViennaType unit.
	self patternsAndStatementsDo: [ :patternBind :statement |
		patternBind typecheck.
		type := type + statement typecheck ].
	^ type
]

{ #category : #accessing }
ViennaTrapsNode >> patterns [

	^ Array streamContents: [ :stream |
		  self patternsAndStatementsDo: [ :pattern :statement |
			  stream nextPut: pattern ] ]
]

{ #category : #enumerating }
ViennaTrapsNode >> patternsAndStatementsDo: aBlock [

	1 to: self size by: 2 do: [ :index |
		| pattern statement |
		pattern := self at: index.
		statement := self at: index + 1.
		aBlock value: pattern value: statement ]
]

{ #category : #accessing }
ViennaTrapsNode >> statements [

	^ Array streamContents: [ :stream |
		  self patternsAndStatementsDo: [ :pattern :statement |
			  stream nextPut: statement ] ]
]
