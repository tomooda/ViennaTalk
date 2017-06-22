*ViennaTalk-Parser-Code Generators
vdmSource
	^ self
		custom:
			(GLMRubricHighlightedTextPresentation new
				editingMode:
					(GLMHighlighterTextRubEditingMode
						withParserStyler: ViennaVDMHighlighter new);
				yourself)