Class {
	#name : #ViennaTraceDefinitionListNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #private }
ViennaTraceDefinitionListNode >> boundIdentifiersDo: aBlock [

	self do: [ :node | node boundIdentifiersDo: aBlock ]
]

{ #category : #'pretty printing' }
ViennaTraceDefinitionListNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter
		  join: ';' ++ aViennaAbstractFormatter cr
		  withAll: (aViennaAbstractFormatter formatAll: self)
]

{ #category : #private }
ViennaTraceDefinitionListNode >> freeIdentifiersExcept: aSet do: aBlock [

	self do: [ :node | node freeIdentifiersExcept: aSet do: aBlock ]
]

{ #category : #accessing }
ViennaTraceDefinitionListNode >> label [

	^ 'TraceDefinitionList'
]

{ #category : #private }
ViennaTraceDefinitionListNode >> listDelimiter [

	^ ';', String cr
]

{ #category : #typechecking }
ViennaTraceDefinitionListNode >> maximalType [

	self do: #typecheck.
	^ ViennaType unit
]
