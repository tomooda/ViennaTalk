accessing
translator
	^ translator
		ifNil: [ 
			| t |
			t := self translatorClass new.
			translator := (t document , (t expression / t statement) optional) end
				==> [ :pair | pair second ifNil: [ pair first ] ifNotNil: [ pair first , pair second ] ] ]