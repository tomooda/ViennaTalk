Extension { #name : #GLMCompositePresentation }

{ #category : #'*ViennaTalk-Transpiler-Debugger' }
GLMCompositePresentation >> vdmSource [
	^ self
		custom:
			(GLMRubricHighlightedTextPresentation new
				editingMode:
					(GLMHighlighterTextRubEditingMode
						withParserStyler: ViennaVDMHighlighter new);
				yourself)
]
