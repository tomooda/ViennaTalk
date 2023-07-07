Class {
	#name : #ViennaStateDefinitionNode,
	#superclass : #ViennaTopLevelDefinitionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaStateDefinitionNode class >> identifier: aString fieldList: aViennaFieldListNode inv: aViennaInvariantNode init: aViennaInitialisationNode [

	^ (self new: 4)
		  identifier: aString;
		  fieldList: aViennaFieldListNode;
		  inv: aViennaInvariantNode;
		  init: aViennaInitialisationNode;
		  yourself
]

{ #category : #private }
ViennaStateDefinitionNode >> boundIdentifiersDo: aBlock [

	aBlock cull: self identifier cull: self.
	self fieldList do: [ :field |
		aBlock cull: field identifier cull: self ]
]

{ #category : #accessing }
ViennaStateDefinitionNode >> fieldList [

	^ self at: 2
]

{ #category : #accessing }
ViennaStateDefinitionNode >> fieldList: aViennaFieldListNode [

	self at: 2 put: aViennaFieldListNode
]

{ #category : #'pretty printing' }
ViennaStateDefinitionNode >> formatWith: aViennaAbstractFormatter [

	| identifier stateFieldList invariant initialisation |
	identifier := aViennaAbstractFormatter format: self identifier.
	stateFieldList := aViennaAbstractFormatter
		                  join: String cr
		                  withAll:
		                  (aViennaAbstractFormatter formatAll:
			                   self fieldList).
	invariant := self inv
		             ifNil: [ '' ]
		             ifNotNil: [ :node |
		             String cr , (aViennaAbstractFormatter format: node) ].
	initialisation := self init
		                  ifNil: [ '' ]
		                  ifNotNil: [ :node |
		                  String cr
		                  , (aViennaAbstractFormatter format: node) ].
	^ 'state ' , identifier , ' of' , String cr
	  , aViennaAbstractFormatter indent
	  , (aViennaAbstractFormatter indentString: stateFieldList)
	  , invariant , initialisation , String cr , 'end'
]

{ #category : #private }
ViennaStateDefinitionNode >> freeIdentifiersExcept: aSet do: aBlock [

	self fieldList freeIdentifiersExcept: aSet do: aBlock.
	self inv ifNotNil: [ :inv |
		inv freeIdentifiersExcept: aSet do: aBlock ].
	self init ifNotNil: [ :init |
		init freeIdentifiersExcept: aSet do: aBlock ]
]

{ #category : #accessing }
ViennaStateDefinitionNode >> identifier [

	^ self at: 1
]

{ #category : #accessing }
ViennaStateDefinitionNode >> identifier: aString [

	self at: 1 put: aString
]

{ #category : #accessing }
ViennaStateDefinitionNode >> init [

	^ self at: 4
]

{ #category : #accessing }
ViennaStateDefinitionNode >> init: aViennaInitialisationNode [

	self at: 4 put: aViennaInitialisationNode
]

{ #category : #accessing }
ViennaStateDefinitionNode >> inv [

	^ self at: 3
]

{ #category : #accessing }
ViennaStateDefinitionNode >> inv: aViennaInvariantNode [

	self at: 3 put: aViennaInvariantNode
]

{ #category : #testing }
ViennaStateDefinitionNode >> isViennaExportableTopLevelDefinitionNode [

	^ false
]

{ #category : #testing }
ViennaStateDefinitionNode >> isViennaStateDefinitionNode [

	^ true
]

{ #category : #testing }
ViennaStateDefinitionNode >> label [

	^ 'StateDefinition'
]

{ #category : #'accessing-definitions' }
ViennaStateDefinitionNode >> shortName [

	^ self identifier
]
