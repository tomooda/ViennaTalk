Class {
	#name : #ViennaRenameStateVariable,
	#superclass : #ViennaRenameToplevel,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #testing }
ViennaRenameStateVariable >> acceptsDefinitionNode: aViennaNode [

	^ aViennaNode isViennaStateDefinitionNode and: [
		  aViennaNode fieldList asArray anySatisfy: [ :field |
			  field identifier = self oldName ] ]
]

{ #category : #accessing }
ViennaRenameStateVariable >> construct [
	^ 'state variable'
]

{ #category : #operations }
ViennaRenameStateVariable >> executeOnDefinition [

	self definitionNode ifNotNil: [ :stateDefinition |
		stateDefinition fieldList do: [ :field |
			field identifier = self oldName ifTrue: [
				field identifier: self newName ] ] ]
]

{ #category : #operations }
ViennaRenameStateVariable >> executeOnImports [
]

{ #category : #accessing }
ViennaRenameStateVariable >> sortingOrder [
	^ 1.22
]
