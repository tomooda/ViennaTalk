test pane menu
runTestModule: module operation: operation
	| header |
	header := 'Runtime: Error 4129: Exit '.
	[ [ animation
		plainEvaluate: operation , '()'
		in: module
		ifError: [ :msg | 
			(msg size > header size and: [ (msg copyFrom: 1 to: header size) = header ])
				ifTrue: [ ViennaException
						expression: (ViennaReader new parse: (msg copyFrom: header size + 1 to: msg size)) ]
				ifFalse: [ Error signal: msg ] ] ]
		on: ViennaException
		do: [ :exception | 
			exception expression
				in: [ :expr | 
					(expr isViennaComposite and: [ expr constructor = 'UnitTesting`AssertFailure' ])
						ifTrue: [ ^ {false.
							('assertion failed: ' , (expr at: 1) asString)} ].
					(expr isViennaComposite
						and: [ expr constructor = 'UnitTesting`AssertEqualsFailure' ])
						ifTrue: [ ^ {false.
							('assertion failed: ' , (expr at: 3) asString , ' expected: '
								, (expr at: 2) viennaString , ' actual: ' , (expr at: 1) viennaString)} ].
					^ {(nil , 'assertion failed: error ' , expr viennaString)} ] ] ]
		on: Error
		do: [ :exception | ^ {(nil , exception messageText)} ].
	^ {(true , 'OK')}