code generation-definitions
noCheckAssignment: aVarName be: aValString
	^ 'self instVarNamed: ' , aVarName storeString , ' put: ' , aValString