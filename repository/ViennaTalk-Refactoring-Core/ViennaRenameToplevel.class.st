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
	super execute.
	self executeOnImports
]

{ #category : #operations }
ViennaRenameToplevel >> executeOnGlobalNames [
	^ ast document
		allDescendantsDo: [ :node | 
			(node label = 'GlobalName'
				and: [ node first = self definitionNode module first
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
