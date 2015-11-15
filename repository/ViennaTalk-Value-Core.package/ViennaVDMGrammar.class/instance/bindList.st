parsers-patterns
bindList
	^ (multipleBind separatedBy: (self operator: $,)) withoutSeparators