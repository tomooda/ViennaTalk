Class {
	#name : #ViennaSectionNode,
	#superclass : #ViennaNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #testing }
ViennaSectionNode class >> isAbstract [

	^ self = ViennaSectionNode
]

{ #category : #private }
ViennaSectionNode >> boundIdentifiersDo: aBlock [

	self do: [ :node | node boundIdentifiersDo: aBlock ]
]

{ #category : #'pretty printing' }
ViennaSectionNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter
		  indentString: self sectionName
		  insertCr: (aViennaAbstractFormatter
				   join: ';' , String cr , String cr
				   withAll: (aViennaAbstractFormatter formatAll: self))
			  , (self isEmpty
					   ifTrue: [ '' ]
					   ifFalse: [ ';' , String cr ])
]

{ #category : #private }
ViennaSectionNode >> freeIdentifiersExcept: aSet do: aBlock [

	self do: [ :node | node freeIdentifiersExcept: aSet do: aBlock ]
]

{ #category : #testing }
ViennaSectionNode >> isViennaSectionNode [

	^ true
]

{ #category : #typechecking }
ViennaSectionNode >> maximalType [

	self do: #typecheck.
	^ ViennaType unit
]

{ #category : #accessing }
ViennaSectionNode >> parser [

	^ ViennaVDMParser new definitionBlock end
]

{ #category : #private }
ViennaSectionNode >> remove [

	self parent remove: self
]

{ #category : #private }
ViennaSectionNode >> removeIfEmpty [

	self ifEmpty: [ self remove ]
]

{ #category : #'pretty printing' }
ViennaSectionNode >> sectionName [

	^ self subclassResponsibility
]

{ #category : #accessing }
ViennaSectionNode >> shortName [

	^ self sectionName
]

{ #category : #enumerating }
ViennaSectionNode >> toplevelDefinitionsDo: aBlock [

	self do: aBlock
]
