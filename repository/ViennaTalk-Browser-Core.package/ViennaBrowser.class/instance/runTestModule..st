test pane menu
runTestModule: aString
	| testModuleName |
	testModuleName := aString.
	(testModuleName endsWith: 'Test')
		ifFalse: [ testModuleName := testModuleName , 'Test' ].
	testProcess ifNotNil: [ testProcess terminate ].
	testProcess := [ | ast |
	testResult := Array new.
	self changed: #testList.
	ast := ViennaVDMParser new parse: animation specification.
	ast isPetitFailure
		ifTrue: [ ^ nil ].
	ast isEmpty
		ifTrue: [ ^ self ].
	(ast at: 1) label = 'Module'
		ifTrue: [ ast
				do: [ :moduleNode | 
					| moduleName |
					moduleName := moduleNode first.
					moduleName = testModuleName
						ifTrue: [ moduleNode third
								do: [ :definitionBlockNode | 
									definitionBlockNode first label = 'OperationDefinitions'
										ifTrue: [ definitionBlockNode first
												do: [ :accessOperationDefinitionNode | 
													| operationName |
													operationName := accessOperationDefinitionNode second first first.
													(operationName size > 4 and: [ (operationName copyFrom: 1 to: 4) = 'test' ])
														ifTrue: [ self runTestModule: moduleName operation: operationName ] ] ] ] ] ] ]
		ifFalse: [  ] ] forkAt: Processor userBackgroundPriority