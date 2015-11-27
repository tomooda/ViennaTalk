accessing
name
	^ '*' join: (basetypes collect: [ :t | t nameInPrecedence: self class precedence ])