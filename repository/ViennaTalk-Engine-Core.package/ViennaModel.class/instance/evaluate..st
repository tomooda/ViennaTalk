evaluating
evaluate: aString
	lock
		critical: [ 
			| json response postState |
			json := Dictionary new.
			state keysAndValuesDo: [ :key :value | json at: key put: value ].
			json at: 'source' put: self specification.
			json at: 'expression' put: aString.
			http entity: (ZnEntity with: (self stringify: json) type: ZnMimeType applicationJson).
			response := http post.
			json := self parseJson: response.
			(json at: 'message') ifNotEmpty: [ :msg | ^ Error signal: msg ].
			postState := Dictionary new.
			json
				keysAndValuesDo: [ :key :value | 
					(key includes: $`)
						ifTrue: [ postState at: key put: value ] ].
			state := postState.
			^ reader parseOn: (json at: 'value') readStream ]