testing
isInitialLetter: aCharacter
	| code codeCategory |
	aCharacter = $$
		ifTrue: [ ^ true ].
	code := aCharacter charCode.
	codeCategory := GeneralCategory at: code + 1 ifAbsent: [  ].
	^ code < 16r100
		ifTrue: [ 
			{Ll.
			Lm.
			Lo.
			Lt.
			Lu} includes: codeCategory ]
		ifFalse: [ 
			({Cc.
			Zl.
			Zp.
			Zs.
			Cs.
			Cn.
			Nd.
			Pc} includes: codeCategory) not ]