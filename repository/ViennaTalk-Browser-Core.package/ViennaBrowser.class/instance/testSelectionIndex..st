test pane
testSelectionIndex: anInteger
	| results |
	results := self testList.
	testSelectionIndex := anInteger.
	(anInteger between: 1 and: results size)
		ifTrue: [ (results at: anInteger)
				in: [ :result | 
					self selectModuleNamed: result module.
					(codePane textMorph text asString findString: result operation , '() ==')
						in: [ :start | 
							start > 0
								ifTrue: [ codePane
										selectFrom: start to: start + result operation size - 1;
										scrollSelectionIntoView ] ].
					lowerTabPane selectedPageIndex: 1 ] ]