test pane menu
jumpToSpec
	| results |
	results := self testList.
	(self testSelectionIndex between: 1 and: results size)
		ifTrue: [ (results at: self testSelectionIndex)
				in: [ :result | 
					self selectModuleNamed: result module.
					(codePane textMorph text asString findString: result operation , '() ==')
						in: [ :start | 
							start > 0
								ifTrue: [ codePane
										selectFrom: start to: start + result operation size - 1;
										scrollSelectionIntoView ] ].
					lowerTabPane selectedPageIndex: 1 ] ]