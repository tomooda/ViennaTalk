Class {
	#name : #ViennaRenameModule,
	#superclass : #ViennaRename,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaRenameModule >> check [
	^ self definitionNode notNil
]

{ #category : #accessing }
ViennaRenameModule >> construct [
	^ 'module'
]

{ #category : #operations }
ViennaRenameModule >> execute [

	self definitionNode ifNil: [ ^ nil ].
	self newName ifNil: [ ^ nil ].
	self definitionNode at: 1 put: self newName.
	self definitionNode document do: [ :module | 
		module second first ifNotNil: [ :importList | 
			importList do: [ :importDefinition | 
				importDefinition first = self oldName ifTrue: [ 
					importDefinition at: 1 put: self newName ] ] ].
		module third allDescendantsDo: [ :node | 
			(node label = 'GlobalName' and: [ node first = self oldName ]) 
				ifTrue: [ node at: 1 put: self newName ] ] ]
]

{ #category : #accessing }
ViennaRenameModule >> findDefinitionNode [

	ast ifNil: [ ^ nil ].
	ast label = 'Module' ifTrue: [ ^ ast ].
	^ nil
]

{ #category : #accessing }
ViennaRenameModule >> findNewName [

	^ super findNewName ifNotNil: [ :name | 
		  (ast document moduleNamed: name)
			  ifNotNil: [ 
				  UIManager default alert:
					  'The ' , name , ' module already exists.'.
				  nil ]
			  ifNil: [ name ] ]
]

{ #category : #accessing }
ViennaRenameModule >> findOldName [

	ast ifNotNil: [ ast label = 'Module' ifTrue: [ ^ ast name ] ].
	^ nil
]

{ #category : #accessing }
ViennaRenameModule >> sortingOrder [
	^ 1.2
]
