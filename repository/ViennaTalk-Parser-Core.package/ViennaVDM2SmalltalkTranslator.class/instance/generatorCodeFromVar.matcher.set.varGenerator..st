utilities
generatorCodeFromVar: vars matcher: matcherString set: set varGenerator: aVarGeneratorBlock
	| tmp |
	tmp := aVarGeneratorBlock value.
	^ set , ' do: [:' , tmp , '||' , (' ' join: vars) , '|'
		, (ViennaRuntimeUtil binder: matcherString with: tmp vars: vars) , '.'