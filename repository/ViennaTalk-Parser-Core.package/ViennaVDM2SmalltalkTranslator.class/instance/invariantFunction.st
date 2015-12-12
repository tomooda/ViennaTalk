parsers-types
invariantFunction
	^ super invariantFunction
		==> [ :pair | 
			| pat patVars patMatcher expr valVar |
			pat := pair first.
			patVars := pat first.
			patMatcher := pat second.
			expr := pair second.
			valVar := (self
				varNameGenerator: 'value'
				uniqueIn:
					{(pat second).
					expr}) value.
			'[:' , valVar , '||' , (' ' join: patVars) , '|' , (self binder: pat second with: valVar vars: pat first) , ' and: ['
				, expr , ']]' ]