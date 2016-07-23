accessing
stateVariablesDo: aBlock
	(self parentLabelled: 'DefinitionBlock' ifAbsent: [ ^ self ]) parent
		do: [ :node | 
			node first label = 'StateDefinition'
				ifTrue: [ node first second do: [ :field | aBlock value: field first ] ] ]