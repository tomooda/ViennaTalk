test pane menu
basicRunTestModule: module operation: operation
	| header testAnimation |
	header := 'Runtime: Error 4129: Exit '.
	testAnimation := animation copy
		state: Dictionary new;
		yourself.
	[ [ testAnimation
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
					(expr isViennaComposite and: [ expr constructorName = 'AssertFailure' ])
						ifTrue: [ ^ (ViennaTestFailureResultItem
								module: module
								operation: operation
								message: 'assertion failed: ' , (expr at: 1) asString)
								inform;
								yourself ].
					(expr isViennaComposite and: [ expr constructorName = 'AssertEqualsFailure' ])
						ifTrue: [ ^ (ViennaTestFailureResultItem
								module: module
								operation: operation
								message:
								'assertion failed: ' , (expr at: 3) asString , ' expected: ' , (expr at: 2) viennaString
								, ' actual: ' , (expr at: 1) viennaString)
								inform;
								yourself ].
					^ (ViennaTestErrorResultItem
						module: module
						operation: operation
						message: expr viennaString)
						inform;
						yourself ] ] ]
		on: Error
		do: [ :exception | 
			^ (ViennaTestErrorResultItem
				module: module
				operation: operation
				message: exception printString)
				inform;
				yourself ].
	^ ViennaTestSuccessResultItem module: module operation: operation message: 'OK'