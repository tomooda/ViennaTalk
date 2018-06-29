Extension { #name : #GLMCompositePresentation }

{ #category : #'*ViennaTalk-Parser-Code Generators' }
GLMCompositePresentation >> vdmSource [
	^ self
		custom:
			(GLMRubricHighlightedTextPresentation new
				editingMode:
					(GLMHighlighterTextRubEditingMode
						withParserStyler: ViennaVDMHighlighter new);
				yourself)
]
