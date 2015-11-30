tests
testValue
	| content |
	content := 'abc'.
	(token value: content)
		in: [ :t | 
			self assert: t equals: (ViennaToken with: content).
			self assert: t value equals: content ].
	self assert: (token applyTo: (Array with: content)) equals: (ViennaToken with: content).
	self should: [ token applyTo: Array new ] raise: Error.
	self should: [ token applyTo: (Array with: content with: content) ] raise: Error