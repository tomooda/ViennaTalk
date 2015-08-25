testing
isInstalled
	^ self vdmjPath exists and: [ self json4vdmjPath exists and: [ self jsonicPath exists ] ]