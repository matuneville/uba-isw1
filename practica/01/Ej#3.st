!classDefinition: #Falso category: #'Ej 3'!
DenotativeObject subclass: #Falso
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ej 3'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Falso class' category: #'Ej 3'!
Falso class
	instanceVariableNames: ''!

!Falso class methodsFor: '-- all --' stamp: 'N 3/21/2025 19:52:49'!
no
	  ^Verdadero! !

!Falso class methodsFor: '-- all --' stamp: 'N 3/21/2025 19:48:03'!
o: unBooleano
	^unBooleano! !

!Falso class methodsFor: '-- all --' stamp: 'N 3/21/2025 20:20:08'!
siFalso: unaAccionARealizarOIgnorar
	unaAccionARealizarOIgnorar value! !

!Falso class methodsFor: '-- all --' stamp: 'N 3/21/2025 20:20:18'!
siVerdadero: unaAccionARealizarOIgnorar
	! !

!Falso class methodsFor: '-- all --' stamp: 'N 3/21/2025 19:59:40'!
y: unBooleano
	^self! !


!classDefinition: #TestsBooleans category: #'Ej 3'!
DenotativeObject subclass: #TestsBooleans
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ej 3'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TestsBooleans class' category: #'Ej 3'!
TestsBooleans class
	instanceVariableNames: ''!

!TestsBooleans class methodsFor: '-- all --' stamp: 'N 3/21/2025 19:35:45'!
testFalsoOFalsoIgualFalso
	Assert
		that: (Falso o: Falso) isEqualTo: Falso ! !

!TestsBooleans class methodsFor: '-- all --' stamp: 'N 3/21/2025 19:50:34'!
testFalsoOVerdaderoIgualVerdadero
	Assert
	that: (Falso o: Verdadero)
	isEqualTo: Verdadero! !

!TestsBooleans class methodsFor: '-- all --' stamp: 'N 3/21/2025 20:21:03'!
testFalsoSiFalsoHaceAccion
	|unNumero|
	unNumero := 0.
	Falso siFalso: [unNumero := 13].
	Assert 
		that: unNumero isEqualTo: 13.! !

!TestsBooleans class methodsFor: '-- all --' stamp: 'N 3/21/2025 20:21:08'!
testFalsoSiVerdaderoNoHaceAccion
	|unNumero|
	unNumero := 0.
	Falso siVerdadero: [unNumero := 13].
	Assert 
		that: unNumero isEqualTo: 0.! !

!TestsBooleans class methodsFor: '-- all --' stamp: 'N 3/21/2025 19:58:14'!
testFalsoYFalsoIgualFalso
	Assert
	that: (Falso y: Falso)
	isEqualTo: Falso! !

!TestsBooleans class methodsFor: '-- all --' stamp: 'N 3/21/2025 19:57:11'!
testFalsoYVerdaderoIgualFalso
	Assert
	that: (Falso y: Verdadero)
	isEqualTo: Falso! !

!TestsBooleans class methodsFor: '-- all --' stamp: 'N 3/21/2025 20:03:32'!
testNoFalso
	Assert
	that: Falso no
	isEqualTo: Verdadero! !

!TestsBooleans class methodsFor: '-- all --' stamp: 'N 3/21/2025 19:54:06'!
testNoVerdadero
	Assert
	that: Verdadero no
	isEqualTo: Falso! !

!TestsBooleans class methodsFor: '-- all --' stamp: 'N 3/21/2025 19:51:50'!
testVerdaderoOFalsoIgualVerdadero
	Assert
	that: (Verdadero o: Falso)
	isEqualTo: Verdadero! !

!TestsBooleans class methodsFor: '-- all --' stamp: 'N 3/21/2025 19:50:57'!
testVerdaderoOVerdaderoIgualVerdadero
	Assert
	that: (Verdadero o: Verdadero)
	isEqualTo: Verdadero! !

!TestsBooleans class methodsFor: '-- all --' stamp: 'N 3/21/2025 20:21:12'!
testVerdaderoSiFalsoNoHaceAccion
	|unNumero|
	unNumero := 0.
	Verdadero siFalso: [unNumero := 13].
	Assert 
		that: unNumero isEqualTo: 0.! !

!TestsBooleans class methodsFor: '-- all --' stamp: 'N 3/21/2025 20:21:17'!
testVerdaderoSiVerdaderoHaceAccion
	|unNumero|
	unNumero := 0.
	Verdadero siVerdadero: [unNumero := 13].
	Assert 
		that: unNumero isEqualTo: 13.! !

!TestsBooleans class methodsFor: '-- all --' stamp: 'N 3/21/2025 19:56:54'!
testVerdaderoYFalsoIgualFalso
	Assert
	that: (Verdadero y: Falso)
	isEqualTo: Falso! !

!TestsBooleans class methodsFor: '-- all --' stamp: 'N 3/21/2025 19:58:42'!
testVerdaderoYVerdaderoIgualFalso
	Assert
	that: (Verdadero y: Verdadero)
	isEqualTo: Verdadero! !


!classDefinition: #Verdadero category: #'Ej 3'!
DenotativeObject subclass: #Verdadero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ej 3'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Verdadero class' category: #'Ej 3'!
Verdadero class
	instanceVariableNames: ''!

!Verdadero class methodsFor: '-- all --' stamp: 'N 3/21/2025 20:01:44'!
no
	^Falso! !

!Verdadero class methodsFor: '-- all --' stamp: 'N 3/21/2025 19:49:20'!
o: unBooleano
	^self! !

!Verdadero class methodsFor: '-- all --' stamp: 'N 3/21/2025 20:19:42'!
siFalso: unaAccionARealizarOIgnorar
	! !

!Verdadero class methodsFor: '-- all --' stamp: 'N 3/21/2025 20:19:16'!
siVerdadero: unaAccionARealizarOIgnorar
	unaAccionARealizarOIgnorar value! !

!Verdadero class methodsFor: '-- all --' stamp: 'N 3/21/2025 20:02:08'!
y: unBooleano
	^unBooleano! !
