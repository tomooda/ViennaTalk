stepping
step
	value := value + 1.
	self event: #ticked.
	self changed