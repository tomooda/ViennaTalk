operations
changeStepTime
	(UIManager default request: 'Enter interval in msecs' initialAnswer: stepTime printString title: self name)
		ifNotNil: [ :answer | answer asInteger ifNotNil: [ :newTimeStep | self stepTime: newTimeStep ] ]