accessing
translator
	^ translator
		ifNil: [ 
			| t |
			t := self translatorClass new.
			translator := (t document , t expression) end ==> [ :pair | pair first , pair second ] ]