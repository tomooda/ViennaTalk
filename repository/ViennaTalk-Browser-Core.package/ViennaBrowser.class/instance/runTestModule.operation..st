test pane menu
runTestModule: module operation: operation
	testResult := testResult copyWith: (self basicRunTestModule: module operation: operation).
	self changed: #testList