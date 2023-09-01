Class {
	#name : #ViennaRenameToplevel,
	#superclass : #ViennaRename,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #testing }
ViennaRenameToplevel class >> isAbstract [
	^ self = ViennaRenameToplevel
]

{ #category : #testing }
ViennaRenameToplevel >> acceptsDefinitionNode: aViennaNode [

	^ self subclassResponsibility
]

{ #category : #operations }
ViennaRenameToplevel >> check [
	^ self definitionNode notNil
]

{ #category : #operations }
ViennaRenameToplevel >> execute [

	self newName ifNil: [ ^ nil ].
	self definitionNode ifNil: [ ^ nil ].
	self
		executeOnReferences;
		executeOnImports;
		executeOnGlobalNames;
		executeOnDefinition.
	^ nil
]

{ #category : #operations }
ViennaRenameToplevel >> executeOnDefinition [

	self definitionNode ifNotNil: [ :definition |
		definition identifier: self newName ]
]

{ #category : #operations }
ViennaRenameToplevel >> executeOnGlobalNames [

	^ ast root allDescendantsDo: [ :node |
		  (node
			   isViennaGlobalNameNode: self definitionNode module identifier
			   identifier: self oldName) ifTrue: [
			  node identifier: self newName ] ]
]

{ #category : #operations }
ViennaRenameToplevel >> executeOnImports [

	self ast document modulesDo: [ :module |
		(module
			 importAtModuleIdentifier: self ast module identifier
			 identifier: self oldName) ifNotNil: [ :import |
			import identifier: self newName ] ]
]

{ #category : #operations }
ViennaRenameToplevel >> executeOnReferences [

	self ast document
		allDescendantsSuchThat: [ :node |
			node isViennaNameNode and: [
				node identifier = self oldName and: [
					node localResolve == self definitionNode ] ] ]
		do: [ :node | node identifier: self newName ]
]

{ #category : #accessing }
ViennaRenameToplevel >> findDefinitionNode [

	self oldName ifNil: [ ^ nil ].
	^ (ast module resolveIdentifier: self oldName) ifNotNil: [
		  :definition |
		  (self acceptsDefinitionNode: definition)
			  ifTrue: [ definition ]
			  ifFalse: [ nil ] ]
]

{ #category : #accessing }
ViennaRenameToplevel >> findOldName [

	^ (ast respondsTo: #identifier)
		  ifTrue: [ ast identifier ]
		  ifFalse: [ nil ]
]
