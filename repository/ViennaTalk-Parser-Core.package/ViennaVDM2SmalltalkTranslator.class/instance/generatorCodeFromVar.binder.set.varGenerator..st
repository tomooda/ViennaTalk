utilities
generatorCodeFromVar: vars binder: binder set: set varGenerator: aVarGeneratorBlock
	| tmp |
	tmp := aVarGeneratorBlock value.
	^ set , ' do: [:' , tmp , '||' , (' ' join: vars) , '|' , binder , ' value: ' , tmp , '.'