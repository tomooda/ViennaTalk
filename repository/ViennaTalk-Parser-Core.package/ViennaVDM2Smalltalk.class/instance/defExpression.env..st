code generation-expressions
defExpression: aViennaNode env: aDictionary
	| defs expr vars |
	defs := self generate: aViennaNode first env: aDictionary.
	expr := self generate: aViennaNode second env: aDictionary.
	vars := Array new: defs size streamContents: [ :stream | defs do: [ :def | stream nextPutAll: def first first ] ].
	^ '[|' , (' ' join: vars) , '|'
		,
			('.'
				join:
					(defs
						collect: [ :def | 
							| left right |
							left := def first.
							right := def second.
							self binder: left second with: right vars: left first ])) , ' ifFalse: [ViennaNoMatch signal].' , expr
		, '] value'