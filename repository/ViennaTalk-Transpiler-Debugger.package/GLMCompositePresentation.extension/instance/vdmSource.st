*ViennaTalk-Transpiler-Debugger
vdmSource
	^ self
		custom:
			(GLMRubricHighlightedTextPresentation new
				editingMode:
					(GLMHighlighterTextRubEditingMode
						withParserStyler: ViennaVDMHighlighter new);
				yourself)