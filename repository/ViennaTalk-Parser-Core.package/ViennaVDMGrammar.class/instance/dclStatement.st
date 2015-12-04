parsers-statements
dclStatement
	^ ((self reserved: 'dcl') , (self assignmentDefinition separatedBy: comma) withoutSeparators , semicolon) ==> #second