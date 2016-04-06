parsers-statements
basicStateDesignator
	^ (( name) , (self fieldReferenceArg / self mapOrSequenceReferenceArg) star)
		==> [ :pair | 
			| nameDesig pairs |
			nameDesig := pair first.
			pairs := pair second.
			pairs
				inject: nameDesig
				into: [ :designator :selectorAndArg | 
					| selector refArg |
					selector := selectorAndArg first.
					refArg := selectorAndArg second.
					self perform: selector with: designator with: refArg ] ]