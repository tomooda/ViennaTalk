accessing
name
	^ 'inmap ' , (keytype nameInPrecedence: self class precedence) , ' to '
		, (valuetype nameInPrecedence: self class precedence)