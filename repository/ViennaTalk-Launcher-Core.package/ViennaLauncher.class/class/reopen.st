user interface
reopen
	Current
		ifNotNil: [ 
			Current delete.
			Current := nil ].
	^ self current openInWorld