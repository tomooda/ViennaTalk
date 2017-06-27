utilities
defineMethod: sourceString in: aClass protocol: protocol node: aViennaNode
	| sourceAST formattedSource formattedAST formatMap map selector |
	selector := aClass
		compile:
			(formattedSource := (sourceAST := RBParser parseMethod: sourceString asString)
				formattedCode)
		classified: protocol.
	formattedAST := (aClass compiledMethodAt: selector) methodNode.
	formatMap := IdentityDictionary new.
	formatMap at: sourceAST put: formattedAST.
	sourceAST allChildren
		with: formattedAST allChildren
		do: [ :sourceNode :formattedNode | formatMap at: sourceNode put: formattedNode ].
	map := IdentityDictionary new.
	formatMap
		keysAndValuesDo: [ :sourceNode :formattedNode | 
			| start end s e n |
			start := sourceNode start.
			end := sourceNode stop.
			s := 0.
			e := Float fmax.
			n := nil.
			sourceString asViennaTracingString sources
				do: [ :assoc | 
					| sourceRange vdmNode |
					sourceRange := assoc key.
					vdmNode := assoc value.
					(sourceRange first <= start and: [ sourceRange last >= end ])
						ifTrue: [ | first last |
							first := sourceRange first.
							last := sourceRange last.
							(s <= first and: [ e >= last ])
								ifTrue: [ s := first.
									e := last.
									n := vdmNode ] ] ].
			map at: formattedNode put: n ].
	aClass specificationAt: selector put: aViennaNode.
	aClass debuggerNodeMapAt: selector put: map