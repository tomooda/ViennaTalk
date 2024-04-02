Class {
	#name : #ViennaNodeDiffSet,
	#superclass : #Object,
	#instVars : [
		'changes'
	],
	#category : #'ViennaTalk-Browser-Core-Diff'
}

{ #category : #'instance creation' }
ViennaNodeDiffSet class >> from: aViennaModularDocumentNode to: anotherViennaModularDocumentNode [

	^ self new
		  from: aViennaModularDocumentNode
		  to: anotherViennaModularDocumentNode
]

{ #category : #enumerating }
ViennaNodeDiffSet >> changesDo: aBlock [

	changes do: aBlock
]

{ #category : #operations }
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

{ #category : #initialization }
ViennaNodeDiffSet >> initialize [

	super initialize.
	changes := OrderedCollection new
]
