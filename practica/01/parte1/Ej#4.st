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

!I class methodsFor: '-- all --' stamp: 'Matias 3/27/2025 09:51:49'!
* multiplicand
	^multiplicand! !

!I class methodsFor: '-- all --' stamp: 'Matias 3/27/2025 09:46:16'!
+ anAdder
	^anAdder next! !

!I class methodsFor: '-- all --' stamp: 'Matias 3/27/2025 09:53:12'!
- sustrahend
	^Error! !

!I class methodsFor: '-- all --' stamp: 'Matias 3/27/2025 09:59:02'!
/ dividend
	^I! !

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

!II class methodsFor: 'operacionesMatematicas' stamp: 'Matias 3/27/2025 10:44:20'!
* multiplicand
	^multiplicand + (multiplicand * self previous)! !

!II class methodsFor: 'operacionesMatematicas' stamp: 'Matias 3/27/2025 09:46:01'!
+ anAdder
	^self previous + anAdder next.! !

!II class methodsFor: 'operacionesMatematicas' stamp: 'Matias 3/27/2025 10:12:37'!
- sustrahend
	"si es X - I, devuelvo el padre (o sea, X-1)"
	(sustrahend  = I) ifTrue: [^self previous].
	
	"si es X - Y, para Y >= X, Error"
	((sustrahend = self) or: (sustrahend name >= self name)) ifTrue: [^self error: 'descripcionDeErrorDeNumerosNegativosNoSoportados'].
	
	"si no, devuelvo X-1 - (Y-1)"
	^self previous - sustrahend previous! !

!II class methodsFor: 'operacionesMatematicas' stamp: 'Matias 3/27/2025 10:08:26'!
/ divisor
	"X / 1   ->   X"
	(divisor = I) ifTrue: [^self]. 
	
	"X/X    ->    1"
	(divisor = self) ifTrue: [^I].
	
	"si no, paso recursivo"
	^ I + ((self - divisor) / divisor).! !


!II class methodsFor: 'operacionesMatematicas' stamp: 'Matias 3/27/2025 10:44:20'!
* multiplicand
	^multiplicand + (multiplicand * self previous)! !

!II class methodsFor: 'operacionesMatematicas' stamp: 'Matias 3/27/2025 09:46:01'!
+ anAdder
	^self previous + anAdder next.! !

!II class methodsFor: 'operacionesMatematicas' stamp: 'Matias 3/27/2025 10:12:37'!
- sustrahend
	"si es X - I, devuelvo el padre (o sea, X-1)"
	(sustrahend  = I) ifTrue: [^self previous].
	
	"si es X - Y, para Y >= X, Error"
	((sustrahend = self) or: (sustrahend name >= self name)) ifTrue: [^self error: 'descripcionDeErrorDeNumerosNegativosNoSoportados'].
	
	"si no, devuelvo X-1 - (Y-1)"
	^self previous - sustrahend previous! !

!II class methodsFor: 'operacionesMatematicas' stamp: 'Matias 3/27/2025 10:08:26'!
/ divisor
	"X / 1   ->   X"
	(divisor = I) ifTrue: [^self]. 
	
	"X/X    ->    1"
	(divisor = self) ifTrue: [^I].
	
	"si no, paso recursivo"
	^ I + ((self - divisor) / divisor).! !

!II class methodsFor: '-- all --' stamp: 'N 3/21/2025 21:32:41'!
establecemeComoPadre: numeroDelPadre
	padre := numeroDelPadre! !

!II class methodsFor: '--** private fileout/in **--' stamp: 'Matias 3/29/2025 12:44:10'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	padre := I.! !

!II class methodsFor: '-- all --' stamp: 'Matias 3/24/2025 16:22:37'!
next
	^(II createChildNamed: (self name, 'I')) establecemeComoPadre: self! !

!II class methodsFor: '-- all --' stamp: 'N 3/21/2025 21:29:52'!
previous
	^padre! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'Matias 3/29/2025 12:44:10'!
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

!III class methodsFor: '--** private fileout/in **--' stamp: 'Matias 3/29/2025 12:44:10'!
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

!IIII class methodsFor: '--** private fileout/in **--' stamp: 'Matias 3/29/2025 12:44:10'!
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

!IIIII class methodsFor: '--** private fileout/in **--' stamp: 'Matias 3/29/2025 12:44:10'!
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

!IIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Matias 3/29/2025 12:44:10'!
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

!IIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Matias 3/29/2025 12:44:10'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	padre := IIIIII.! !


!classDefinition: #IIIIIIII category: #'Ej 4'!
II subclass: #IIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ej 4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIII class' category: #'Ej 4'!
IIIIIIII class
	instanceVariableNames: ''!

!IIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Matias 3/29/2025 12:44:10'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	padre := IIIIIII.! !


!classDefinition: #IIIIIIIII category: #'Ej 4'!
II subclass: #IIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ej 4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIII class' category: #'Ej 4'!
IIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Matias 3/29/2025 12:44:10'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	padre := IIIIIIII.! !


!classDefinition: #IIIIIIIIII category: #'Ej 4'!
II subclass: #IIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ej 4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIII class' category: #'Ej 4'!
IIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Matias 3/29/2025 12:44:10'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	padre := IIIIIIIII.! !


!classDefinition: #IIIIIIIIIII category: #'Ej 4'!
II subclass: #IIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ej 4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIII class' category: #'Ej 4'!
IIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Matias 3/29/2025 12:44:10'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	padre := IIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIII category: #'Ej 4'!
II subclass: #IIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ej 4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIII class' category: #'Ej 4'!
IIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Matias 3/29/2025 12:44:10'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	padre := IIIIIIIIIII.! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!
IIIII initializeAfterFileIn!
IIIIII initializeAfterFileIn!
IIIIIII initializeAfterFileIn!
IIIIIIII initializeAfterFileIn!
IIIIIIIII initializeAfterFileIn!
IIIIIIIIII initializeAfterFileIn!
IIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIII initializeAfterFileIn!