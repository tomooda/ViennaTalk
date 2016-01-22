private
testExpression: expression specification: specification states: states resultValue: resultValue resultStates: resultStates
	ViennaServer
		ensureServeIn: [ 
			(fixture
				evaluate: expression
				specification: specification
				states: states
				vdm10: true
				rtc: true)
				in: [ :triple | 
					self assert: resultValue equals: triple first.
					self assert: resultStates equals: triple second.
					self assert: resultValue isNil equals: triple third notEmpty ] ]