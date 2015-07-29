instance creation
new
	| process |
	process := super new.
	self register: process.
	^ process