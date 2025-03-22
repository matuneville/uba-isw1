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

!II class methodsFor: '-- all --' stamp: 'N 3/21/2025 21:32:41'!
establecemeComoPadre: numeroDelPadre
	padre := numeroDelPadre! !

!II class methodsFor: '--** private fileout/in **--' stamp: 'N 3/21/2025 21:36:54'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	padre := I.! !

!II class methodsFor: '-- all --' stamp: 'N 3/21/2025 21:34:38'!
next
	^(self createChildNamed: (self name, 'I')) establecemeComoPadre: self! !

!II class methodsFor: '-- all --' stamp: 'N 3/21/2025 21:29:52'!
previous
	^padre! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'N 3/21/2025 21:36:54'!
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

!III class methodsFor: '--** private fileout/in **--' stamp: 'N 3/21/2025 21:36:54'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	padre := II.! !


!classDefinition: #IIII category: #'Ej 4'!
III subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ej 4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: #'Ej 4'!
IIII class
	instanceVariableNames: ''!

!IIII class methodsFor: '--** private fileout/in **--' stamp: 'N 3/21/2025 21:36:54'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	padre := III.! !


!classDefinition: #IIIII category: #'Ej 4'!
IIII subclass: #IIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ej 4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIII class' category: #'Ej 4'!
IIIII class
	instanceVariableNames: ''!

!IIIII class methodsFor: '--** private fileout/in **--' stamp: 'N 3/21/2025 21:36:54'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	padre := IIII.! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!
IIIII initializeAfterFileIn!