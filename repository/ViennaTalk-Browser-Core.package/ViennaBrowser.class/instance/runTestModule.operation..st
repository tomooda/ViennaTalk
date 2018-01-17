test pane menu
runTestModule: module operation: operation
	testResult addLast: (self basicRunTestModule: module operation: operation).
	self changed: #testList