*ViennaTalk-Transpiler-Debugger
specificationContext
	| context |
	context := self.
	[ ((context receiver isKindOf: ViennaTranspiledObject)
		and: [ context receiver class includesSpecificationFor: context selector ])
		ifTrue: [ ^ context ].
	context := context sender.
	context notNil ] whileTrue.
	^ nil