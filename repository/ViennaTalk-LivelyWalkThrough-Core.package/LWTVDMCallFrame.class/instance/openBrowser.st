interface opening
openBrowser
	| module |
	module := (callee indexOf: $`)
				in: [:index | index > 0
						ifTrue: [callee copyFrom: 1 to: index - 1]
						ifFalse: ['DEFAULT']].
	^ ViennaBrowser open model selectModuleNamed: module