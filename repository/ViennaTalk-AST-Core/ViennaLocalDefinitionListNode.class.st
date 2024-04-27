Class {
	#name : #ViennaLocalDefinitionListNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #private }
ViennaLocalDefinitionListNode >> boundIdentifiersDo: aBlock [

	self do: [ :localDefinition |
		localDefinition boundIdentifiersDo: aBlock ]
]

{ #category : #'pretty printing' }
ViennaLocalDefinitionListNode >> formatWith: aViennaAbstractFormatter [

	| localDefinitions |
	localDefinitions := aViennaAbstractFormatter formatAll: self.
	^ (aViennaAbstractFormatter anyNeedsIndent: localDefinitions)
		  ifTrue: [
			  aViennaAbstractFormatter
				  join:
				  aViennaAbstractFormatter empty ++ ','
				  ++ aViennaAbstractFormatter cr
				  withAll: localDefinitions ]
		  ifFalse: [
		  aViennaAbstractFormatter join: ', ' withAll: localDefinitions ]
]

{ #category : #private }
ViennaLocalDefinitionListNode >> freeIdentifiersExcept: aSet do: aBlock [

	self do: [ :localDefinition |
		localDefinition freeIdentifiersExcept: aSet do: aBlock ]
]

{ #category : #testing }
ViennaLocalDefinitionListNode >> isViennaLocalDefinitionListNode [

	^ true
]

{ #category : #accessing }
ViennaLocalDefinitionListNode >> label [

	^ 'LocalDefinitionList'
]

{ #category : #private }
ViennaLocalDefinitionListNode >> listDelimiter [

	^ ',' , String cr
]

{ #category : #typechecking }
ViennaLocalDefinitionListNode >> maximalType [

	self do: #typecheck.
	^ ViennaType unit
]
