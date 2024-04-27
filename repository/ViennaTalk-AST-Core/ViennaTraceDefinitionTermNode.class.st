Class {
	#name : #ViennaTraceDefinitionTermNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #private }
ViennaTraceDefinitionTermNode >> boundIdentifiersDo: aBlock [

	self do: [ :node | node boundIdentifiersDo: aBlock ]
]

{ #category : #'pretty printing' }
ViennaTraceDefinitionTermNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter
		  join: ' |' ++ aViennaAbstractFormatter cr
		  withAll: (aViennaAbstractFormatter formatAll: self)
]

{ #category : #private }
ViennaTraceDefinitionTermNode >> freeIdentifiersExcept: aSet do: aBlock [

	self do: [ :node | node freeIdentifiersExcept: aSet do: aBlock ]
]

{ #category : #accessing }
ViennaTraceDefinitionTermNode >> label [

	^ 'TraceDefinitionTerm'
]

{ #category : #typechecking }
ViennaTraceDefinitionTermNode >> maximalType [

	self do: #typecheck.
	^ ViennaType unit
]
