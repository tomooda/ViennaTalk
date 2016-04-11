formatting-expressions
mapDomainRestrictedTo: aViennaNode
	^ self print: (self format: aViennaNode first) infix: self domainRestrictedTo arg: (self format: aViennaNode second)