Class {
	#name : 'ViennaNodeDiffSet',
	#superclass : 'Object',
	#instVars : [
		'changes',
		'changedGlobalNames'
	],
	#category : 'ViennaTalk-Browser-Core-Diff',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'Diff'
}

{ #category : 'instance creation' }
ViennaNodeDiffSet class >> from: aViennaModularDocumentNode to: anotherViennaModularDocumentNode [

	^ self new
		  from: aViennaModularDocumentNode
		  to: anotherViennaModularDocumentNode
]

{ #category : 'instance creation' }
ViennaNodeDiffSet class >> fromNodeChanges: aCollectionOfViennaAbstractNodeChange [

	^ self new
		  setChanges:
			  (OrderedCollection withAll: aCollectionOfViennaAbstractNodeChange);
		  yourself
]

{ #category : 'accessing' }
ViennaNodeDiffSet >> changedGlobalNames [

	^ changedGlobalNames ifNil: [
		  changedGlobalNames := self computeChangedGlobalNames ]
]

{ #category : 'private' }
ViennaNodeDiffSet >> changes [

	^ changes
]

{ #category : 'enumerating' }
ViennaNodeDiffSet >> changesDo: aBlock [

	changes do: aBlock
]

{ #category : 'accessing' }
ViennaNodeDiffSet >> computeChangedGlobalNames [

	| globalNames |
	globalNames := Set new.
	self changesDo: [ :change |
		change changedGlobalNamesDo: [ :name | globalNames add: name ] ].
	^ globalNames
]

{ #category : 'operations' }
ViennaNodeDiffSet >> condenseChanges [

	| newChanges |
	newChanges := OrderedCollection new.
	changes do: [ :change |
		(newChanges
			 detect: [ :oldChange | change overwrites: oldChange ]
			 ifNone: [ nil ])
			ifNotNil: [ :oldChange |
				newChanges
					at: (newChanges indexOf: oldChange)
					put: oldChange , change ]
			ifNil: [ newChanges addLast: change ] ].
	^ changes := newChanges
]

{ #category : 'operations' }
ViennaNodeDiffSet >> from: aViennaModularDocumentNode to: anotherViennaModularDocumentNode [

	(aViennaModularDocumentNode moduleNames
	 , anotherViennaModularDocumentNode moduleNames) asSet sorted do: [
		:moduleName |
		| module1 module2 |
		module1 := aViennaModularDocumentNode moduleNamed: moduleName.
		module2 := anotherViennaModularDocumentNode moduleNamed: moduleName.
		module1 ~= module2 ifTrue: [
			changes add: (ViennaModuleNodeChange from: module1 to: module2).
			((module1 ifNotNil: #toplevelIdentifiers ifNil: [ #(  ) ])
			 , (module2 ifNotNil: #toplevelIdentifiers ifNil: [ #(  ) ])) asSet
				sorted do: [ :identifier |
				| definition1 definition2 |
				definition1 := module1 ifNotNil: [
					               module1 resolveIdentifier: identifier ].
				definition2 := module2 ifNotNil: [
					               module2 resolveIdentifier: identifier ].
				definition1 ~= definition2 ifTrue: [
					changes add:
						(ViennaTopLevelDefinitionNodeChange
							 from: definition1
							 to: definition2) ] ] ] ]
]

{ #category : 'initialization' }
ViennaNodeDiffSet >> initialize [

	super initialize.
	changes := OrderedCollection new
]

{ #category : 'private' }
ViennaNodeDiffSet >> setChanges: anOrderedCollectionOfViennaAbstractNodeChange [

	changes := anOrderedCollectionOfViennaAbstractNodeChange.
	changedGlobalNames := nil
]
