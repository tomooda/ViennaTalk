formatting-expressions
mapDomainRestrictedBy: aViennaNode
	^ self print: (self format: aViennaNode first) infix: self domainRestrictedBy arg: (self format: aViennaNode second)