Class {
	#name : #ViennaRenameToplevel,
	#superclass : #ViennaRename,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #testing }
ViennaRenameToplevel class >> isAbstract [
	^ self = ViennaRenameToplevel
]

{ #category : #operations }
ViennaRenameToplevel >> execute [

	self newName ifNil: [ ^ nil ].
	self
		executeOnDefinition;
		freeOccurrencesOf: self oldName
		in: ast module
		do: [ :node | self execute: node ].
	self executeOnImports.
	self executeOnGlobalNames.
	^ nil
]

{ #category : #operations }
ViennaRenameToplevel >> execute: aViennaNode [
	| selector |
	aViennaNode isViennaNode
		ifFalse: [ ^ self ].
	selector := ('execute' , aViennaNode label , ':') asSymbol.
	(self respondsTo: selector)
		ifTrue: [ self perform: selector with: aViennaNode ]
		ifFalse: [ self refactoringError: aViennaNode ]
]

{ #category : #operations }
ViennaRenameToplevel >> executeLocalName: aViennaNode [
	aViennaNode at: 1 put: self newName
]

{ #category : #operations }
ViennaRenameToplevel >> executeOldName: aViennaNode [
	aViennaNode at: 1 put: self newName
]

{ #category : #operations }
ViennaRenameToplevel >> executeOnDefinition [

	^ self subclassResponsibility
]

{ #category : #operations }
ViennaRenameToplevel >> executeOnGlobalNames [
	^ ast root
		allDescendantsDo: [ :node | 
			(node label = 'GlobalName'
				and: [ node first = self definitionNode module name
						and: [ node second = self oldName ] ])
				ifTrue: [ node at: 2 put: self newName ] ]
]

{ #category : #operations }
ViennaRenameToplevel >> executeOnImports [
	| moduleName |
	moduleName := ast module first.
	ast
		modulesDo: [ :module | 
			module second first
				ifNotNil: [ :importDefinitionList | 
					importDefinitionList
						do: [ :importDefinition | 
							importDefinition first = moduleName
								ifTrue: [ self
										freeOccurrencesOf: self oldName
										in: importDefinition second
										do: [ :node | self execute: node ] ] ] ] ]
]
