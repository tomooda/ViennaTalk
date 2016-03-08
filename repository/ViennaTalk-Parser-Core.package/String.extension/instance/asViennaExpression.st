*ViennaTalk-Parser-Core
asViennaExpression
	^ Compiler new
		evaluate: (ViennaVDM2SmalltalkScript new generate: self asViennaExpressionAst)
		in: thisContext sender
		to: thisContext sender receiver
		notifying: nil
		ifFail: nil
		logged: false