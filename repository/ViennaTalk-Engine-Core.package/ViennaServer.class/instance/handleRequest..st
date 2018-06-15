request handling
handleRequest: aZnRequest
	| json |
	aZnRequest entity
		ifNotNil: [ :jsonString | 
			| source expression preStates result |
			json := NeoJSONReader fromString: jsonString.
			source := json at: 'source' ifAbsent: [ String new ].
			expression := json at: 'expression' ifAbsent: [ String new ].
			preStates := Dictionary new: json size.
			json
				keysAndValuesDo: [ :key :value | 
					(key includes: $`)
						ifTrue: [ | index module var |
							index := key indexOf: $`.
							module := key copyFrom: 1 to: index - 1.
							var := key copyFrom: index + 1 to: key size.
							(preStates at: module ifAbsentPut: [ Dictionary new ]) at: var put: value ] ].
			result := self
				evaluate: expression
				specification: source
				states: preStates
				vdm10: (json includesKey: 'classic') not
				rtc: (json includesKey: 'ignoreRuntimeChecking') not.
			json := Dictionary new.
			json
				at: 'source' put: source;
				at: 'expression' put: expression;
				at: 'value' put: (result first ifNil: [ String new ]);
				at: 'message' put: result third.
			result second
				keysAndValuesDo: [ :moduleName :bindings | 
					bindings
						keysAndValuesDo: [ :varName :value | json at: moduleName , '`' , varName put: value ] ].
			^ ZnResponse
				ok: (ZnEntity with: (self stringify: json) type: ZnMimeType applicationJson) ].
	^ ZnResponse notFound: aZnRequest url