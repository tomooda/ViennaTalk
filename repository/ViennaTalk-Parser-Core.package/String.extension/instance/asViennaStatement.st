*ViennaTalk-Parser-Core
asViennaStatement
	^ Compiler new
		evaluate: (ViennaVDM2SmalltalkScript new generate: self asViennaStatementAst)
		in: thisContext sender
		to: thisContext sender receiver
		notifying: nil
		ifFail: nil
		logged: false