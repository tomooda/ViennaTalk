Class {
	#name : #ViennaEqualDefinitionListNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #private }
ViennaEqualDefinitionListNode >> boundIdentifiersDo: aBlock [

	self do: [ :equalDefinition |
		equalDefinition boundIdentifiersDo: aBlock ]
]

{ #category : #'accessing-definitions' }
ViennaEqualDefinitionListNode >> definitionOfLocalName: aString for: aViennaNode [

	(self indexOf: aViennaNode ifAbsent: [ nil ]) ifNotNil: [ :until |
		until - 1 to: 1 do: [ :index |
			(self at: index) patternOrBind
				allDescendantsSuchThat: [ :n |
				n isViennaPatternIdentifierNode: aString ]
				do: [ :n | ^ n ] ].
		^ parent ifNotNil: [
			  parent definitionOfLocalName: aString for: aViennaNode ] ].
	^ self definitionOfLocalName: aString
]

{ #category : #'pretty printing' }
ViennaEqualDefinitionListNode >> formatWith: aViennaAbstractFormatter [

	| defs |
	defs := aViennaAbstractFormatter formatAll: self.
	^ (aViennaAbstractFormatter
		   join:
		   aViennaAbstractFormatter empty , ';'
		   , aViennaAbstractFormatter cr
		   withAll: defs) , ';'
]

{ #category : #private }
ViennaEqualDefinitionListNode >> freeIdentifiersExcept: aSet do: aBlock [

	| boundIdentifiers |
	boundIdentifiers := aSet.
	self do: [ :equalDefinition |
		equalDefinition patternOrBind
			freeIdentifiersExcept: boundIdentifiers
			do: aBlock.
		boundIdentifiers := boundIdentifiers
		                    ,
		                    equalDefinition patternOrBind
			                    uniqueBoundIdentifiers.
		equalDefinition expression
			freeIdentifiersExcept: boundIdentifiers
			do: aBlock ]
]

{ #category : #accessing }
ViennaEqualDefinitionListNode >> indexOf: aViennaNode ifAbsent: errorBlock [

	1 to: self size do: [ :index |
	aViennaNode == (self at: index) ifTrue: [ ^ index ] ].
	^ errorBlock value
]

{ #category : #testing }
ViennaEqualDefinitionListNode >> isViennaEqualDefinitionListNode [

	^ true
]

{ #category : #accessing }
ViennaEqualDefinitionListNode >> label [

	^ 'EqualDefinitionList'
]

{ #category : #private }
ViennaEqualDefinitionListNode >> listDelimiter [

	^ ';' , String cr
]

{ #category : #typechecking }
ViennaEqualDefinitionListNode >> maximalType [

	self do: #typecheck.
	^ ViennaType unit
]
