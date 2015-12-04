accessing
translator
	^ translator
		ifNil: [ 
			| t |
			t := self translatorClass new.
			translator := (t document , (t expression / t statement)) end ==> [ :pair | pair first , pair second ] ]