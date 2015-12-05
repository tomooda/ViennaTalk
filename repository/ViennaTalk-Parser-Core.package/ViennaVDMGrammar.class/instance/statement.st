parsers-statements
statement
	^ self letStatement / self letBeStatement / self defStatement / self identityStatement / self blockStatement
		/ self generalAssignStatement / self ifStatement / self casesStatement / self sequenceForLoop / self setForLoop
		/ self indexForLoop / self whileLoop / self nondeterministicStatement / self callStatement / self returnStatement