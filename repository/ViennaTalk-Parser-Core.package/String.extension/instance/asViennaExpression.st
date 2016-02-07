*ViennaTalk-Parser-Core
asViennaExpression
	| ast |
	ast := ViennaVDMParser new expression end parse: self.
	^ Compiler evaluate: (ViennaVDM2Smalltalk new generate: ast)