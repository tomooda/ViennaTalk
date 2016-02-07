*ViennaTalk-Parser-Core
asViennaStatement
	| ast |
	ast := ViennaVDMParser new statement end parse: self.
	^ Compiler evaluate: (ViennaVDM2Smalltalk new generate: ast)