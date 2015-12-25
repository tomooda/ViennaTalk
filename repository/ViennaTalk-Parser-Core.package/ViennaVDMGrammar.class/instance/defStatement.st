parsers-statements
defStatement
	^ ((self reserved: 'def') , self equalDefinitionList , (self reserved: 'in') , statement)
		==> [ :quatro | 
			| defs bodyStatement |
			defs := quatro second.
			bodyStatement := quatro fourth.
			{defs.
			bodyStatement} ]