editing keys
template
	template := ViennaSyntaxTemplate current.
	self selection ifEmpty: [ self selectWord ].
	self replaceSelectionWith: (template at: self selection asString ifAbsent: [ ^ nil ])