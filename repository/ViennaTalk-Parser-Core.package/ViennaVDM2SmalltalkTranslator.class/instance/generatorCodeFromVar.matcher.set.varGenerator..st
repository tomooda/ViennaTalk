utilities
generatorCodeFromVar: vars matcher: matcherString set: set varGenerator: aVarGeneratorBlock
	| tmp |
	tmp := aVarGeneratorBlock value.
	^ set , ' do: [:' , tmp , '||' , (' ' join: vars) , '|'
		, (self binder: matcherString with: tmp vars: vars) , ' ifFalse: [ViennaNoMatch signal].'