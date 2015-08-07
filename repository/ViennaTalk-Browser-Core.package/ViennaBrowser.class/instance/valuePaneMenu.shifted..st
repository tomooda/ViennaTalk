value pane menu
valuePaneMenu: aMenu shifted: aBoolean
	aMenu addList: (aBoolean = true 
		ifTrue:[{
			#-.
			{'save contents to file...' translated.		#saveContentsInFile}.
			{'send contents to printer' translated.		#sendContentsToPrinter}.
			{'printer setup' translated.				#printerSetup}.
			#-.
		}.]
		ifFalse:[{
			{'set font... (k)' translated.				#offerFontMenu}.
			{'set style... (K)' translated.				#changeStyle}.
			{'set alignment... (u)' translated.		#chooseAlignment}.
			#-.
			{'make project link (P)' translated.	#makeProjectLink}.
			#-.
			{'find...(f)' translated.					#find}.
			{'find again (g)' translated.				#findAgain}.
			{'set search string (h)' translated.		#setSearchString}.
			#-.
			{'do again (j)' translated.				#again}.
			{'undo (z)' translated.					#undo}.
			#-.
			{'copy (c)' translated.					#copySelection}.
			{'cut (x)' translated.						#cut}.
			{'paste (v)' translated.					#paste}.
			{'paste...' translated.					#pasteRecent}.
			#-.
			{'do it (d)' translated.		#valuePaneDoIt}.			     
			{'print it (p)' translated.		#valuePanePrintIt}.
			#-.
			{'accept (s)' translated.					#valuePaneAccept}.
			{'cancel (l)' translated.					#valuePaneCancel}.
			#-.
			{'copy html' translated.					#copyHtml}.
			#-.
			{'more...' translated.					#shiftedTextPaneMenuRequest}.
		}]).
	^aMenu