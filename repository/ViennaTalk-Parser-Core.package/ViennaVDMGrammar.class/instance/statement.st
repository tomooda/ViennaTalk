parsers-statements
statement
	^ self letStatement / self letBeStatement / self defStatement / self identityStatement / self blockStatement
		/ self generalAssignStatement