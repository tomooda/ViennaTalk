Class {
	#name : 'ViennaRenameModule',
	#superclass : 'ViennaRename',
	#category : 'ViennaTalk-Refactoring-Core',
	#package : 'ViennaTalk-Refactoring-Core'
}

{ #category : 'operations' }
ViennaRenameModule >> check [
	^ self definitionNode notNil
]

{ #category : 'accessing' }
ViennaRenameModule >> construct [
	^ 'module'
]

{ #category : 'operations' }
ViennaRenameModule >> execute [

	self definitionNode ifNil: [ ^ nil ].
	self newName ifNil: [ ^ nil ].
	self oldName = self newName ifTrue: [ ^ nil ].
	self definitionNode at: 1 put: self newName.
	self definitionNode document do: [ :module |
		module interface importDefinitionList ifNotNil: [ :importList |
			importList do: [ :importDefinition |
				importDefinition first = self oldName ifTrue: [
					importDefinition moduleIdentifier: self newName ] ] ].
		module moduleBody allDescendantsDo: [ :node |
			(node isViennaGlobalNameNode and: [
				 node moduleIdentifier = self oldName ]) ifTrue: [
				node moduleIdentifier: self newName ] ] ].
	^ self definitionNode
]

{ #category : 'accessing' }
ViennaRenameModule >> findDefinitionNode [

	ast ifNil: [ ^ nil ].
	ast isViennaModuleNode ifTrue: [ ^ ast ].
	^ nil
]

{ #category : 'accessing' }
ViennaRenameModule >> findNewName [

	^ super findNewName ifNotNil: [ :name | 
		  (ast document moduleNamed: name)
			  ifNotNil: [ 
				  UIManager default alert:
					  'The ' , name , ' module already exists.'.
				  nil ]
			  ifNil: [ name ] ]
]

{ #category : 'accessing' }
ViennaRenameModule >> findOldName [

	ast ifNotNil: [ ast isViennaModuleNode ifTrue: [ ^ ast identifier ] ].
	^ nil
]

{ #category : 'accessing' }
ViennaRenameModule >> sortingOrder [
	^ 1.2
]
