testing
isFollowingLetter: aCharacter
	| code codeCategory |
	(#($$ $_ $') includes: aCharacter)
		ifTrue: [ ^ true ].
	code := aCharacter charCode.
	codeCategory := GeneralCategory at: code + 1 ifAbsent: [  ].
	^ code < 16r100
		ifTrue: [ 
			{Ll.
			Lm.
			Lo.
			Lt.
			Lu.
			Nd} includes: codeCategory ]
		ifFalse: [ 
			({Cc.
			Zl.
			Zp.
			Zs.
			Cs.
			Cn} includes: codeCategory) not ]