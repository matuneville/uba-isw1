!classDefinition: #I category: #'Ej 4'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ej 4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: #'Ej 4'!
I class
	instanceVariableNames: ''!

!I class methodsFor: '-- all --' stamp: 'Matias 3/25/2025 11:46:06'!
add: anAdder
	^anAdder next! !

!I class methodsFor: '-- all --' stamp: 'N 3/21/2025 21:31:25'!
next
	^II establecemeComoPadre: self
	
	! !


!classDefinition: #II category: #'Ej 4'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ej 4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: #'Ej 4'!
II class
	instanceVariableNames: 'padre'!

!II class methodsFor: 'operacionesMatematicas' stamp: 'Matias 3/25/2025 12:04:00'!
add: anAdder
	^self previous add: anAdder next! !

!II class methodsFor: 'operacionesMatematicas' stamp: 'Matias 3/26/2025 14:21:58'!
divide: divisor
	"X / 1   ->   X"
	^(divisor name isEqualTo: 'I') ifTrue: [^self]. 
	! !

!II class methodsFor: 'operacionesMatematicas' stamp: 'Matias 3/26/2025 14:17:35'!
subtract: sustrahend
	"si es X - I, devuelvo el padre (o sea, X-1)"
	(sustrahend name isEqualTo: 'I') ifTrue: [^self previous].
	
	"si no, devuelvo X-1 - (Y-1)"
	^self previous subtract: sustrahend previous! !


!II class methodsFor: 'operacionesMatematicas' stamp: 'Matias 3/25/2025 12:04:00'!
add: anAdder
	^self previous add: anAdder next! !

!II class methodsFor: 'operacionesMatematicas' stamp: 'Matias 3/26/2025 14:21:58'!
divide: divisor
	"X / 1   ->   X"
	^(divisor name isEqualTo: 'I') ifTrue: [^self]. 
	! !

!II class methodsFor: '-- all --' stamp: 'N 3/21/2025 21:32:41'!
establecemeComoPadre: numeroDelPadre
	padre := numeroDelPadre! !

!II class methodsFor: '--** private fileout/in **--' stamp: 'Matias 3/26/2025 15:31:05'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	padre := I.! !

!II class methodsFor: '-- all --' stamp: 'Matias 3/24/2025 16:22:37'!
next
	^(II createChildNamed: (self name, 'I')) establecemeComoPadre: self! !

!II class methodsFor: '-- all --' stamp: 'N 3/21/2025 21:29:52'!
previous
	^padre! !

!II class methodsFor: 'operacionesMatematicas' stamp: 'Matias 3/26/2025 14:17:35'!
subtract: sustrahend
	"si es X - I, devuelvo el padre (o sea, X-1)"
	(sustrahend name isEqualTo: 'I') ifTrue: [^self previous].
	
	"si no, devuelvo X-1 - (Y-1)"
	^self previous subtract: sustrahend previous! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'Matias 3/26/2025 15:31:05'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	padre := I.! !


!classDefinition: #III category: #'Ej 4'!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ej 4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: #'Ej 4'!
III class
	instanceVariableNames: ''!

!III class methodsFor: '--** private fileout/in **--' stamp: 'Matias 3/26/2025 15:31:05'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	padre := II.! !


!classDefinition: #IIII category: #'Ej 4'!
II subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ej 4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: #'Ej 4'!
IIII class
	instanceVariableNames: ''!

!IIII class methodsFor: '--** private fileout/in **--' stamp: 'Matias 3/26/2025 15:31:05'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	padre := III.! !


!classDefinition: #IIIII category: #'Ej 4'!
II subclass: #IIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ej 4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIII class' category: #'Ej 4'!
IIIII class
	instanceVariableNames: ''!

!IIIII class methodsFor: '--** private fileout/in **--' stamp: 'Matias 3/26/2025 15:31:05'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	padre := IIII.! !


!classDefinition: #IIIIII category: #'Ej 4'!
II subclass: #IIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ej 4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIII class' category: #'Ej 4'!
IIIIII class
	instanceVariableNames: ''!

!IIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Matias 3/26/2025 15:31:05'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	padre := IIIII.! !


!classDefinition: #IIIIIII category: #'Ej 4'!
II subclass: #IIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ej 4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIII class' category: #'Ej 4'!
IIIIIII class
	instanceVariableNames: ''!

!IIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Matias 3/26/2025 15:31:05'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	padre := IIIIII.! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!
IIIII initializeAfterFileIn!
IIIIII initializeAfterFileIn!
IIIIIII initializeAfterFileIn!