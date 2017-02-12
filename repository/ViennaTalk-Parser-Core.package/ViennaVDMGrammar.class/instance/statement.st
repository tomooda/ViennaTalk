parsers-statements
statement
	^ self letStatement / self letBeStatement / self defStatement / self identityStatement / self blockStatement
		/ self generalAssignStatement / self callStatement / self ifStatement / self casesStatement / self sequenceForLoop
		/ self setForLoop / self indexForLoop / self whileLoop / self nondeterministicStatement / self returnStatement / self alwaysStatement / self exitStatement / self trapStatement / self tixeStatement