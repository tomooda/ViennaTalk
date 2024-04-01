Class {
	#name : #ViennaNodeDiff,
	#superclass : #Object,
	#instVars : [
		'modules',
		'definitions'
	],
	#category : #'ViennaTalk-Browser-Core-Diff'
}

{ #category : #'instance creation' }
ViennaNodeDiff class >> key: aViennaModularDocumentNode value: anotherViennaModularDocumentNode [

	^ self new
		  key: aViennaModularDocumentNode
		  value: anotherViennaModularDocumentNode
]

{ #category : #accessing }
ViennaNodeDiff >> definitions [

	^ definitions
]

{ #category : #initialization }
ViennaNodeDiff >> initialize [

	super initialize.
	modules := OrderedCollection new.
	definitions := OrderedCollection new.
]

{ #category : #operations }
ViennaNodeDiff >> key: aViennaModularDocumentNode value: anotherViennaModularDocumentNode [

	(aViennaModularDocumentNode moduleNames
	 , anotherViennaModularDocumentNode moduleNames) asSet sorted do: [
		:moduleName |
		| module1 module2 |
		module1 := aViennaModularDocumentNode moduleNamed: moduleName.
		module2 := anotherViennaModularDocumentNode moduleNamed: moduleName.
		module1 ~= module2 ifTrue: [
			modules add: module1 -> module2.
			((module1 ifNotNil: #toplevelIdentifiers ifNil: [ #(  ) ])
			 , (module2 ifNotNil: #toplevelIdentifiers ifNil: [ #(  ) ])) asSet
				sorted do: [ :identifier |
				| definition1 definition2 |
				definition1 := module1 resolveIdentifier: identifier.
				definition2 := module2 resolveIdentifier: identifier.
				definition1 ~= definition2 ifTrue: [
					definitions add: definition1 -> definition2 ] ] ] ]
]

{ #category : #accessing }
ViennaNodeDiff >> modules [

	^ modules
]
