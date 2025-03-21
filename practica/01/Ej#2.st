!classDefinition: #Bill category: #'Ej 2'!
DenotativeObject subclass: #Bill
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ej 2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Bill class' category: #'Ej 2'!
Bill class
	instanceVariableNames: 'diasDeVida'!

!Bill class methodsFor: '-- all --' stamp: 'N 3/21/2025 20:45:15'!
caminar: unaCantidadDeKilometros
	diasDeVida := diasDeVida - unaCantidadDeKilometros - 3! !

!Bill class methodsFor: '-- all --' stamp: 'N 3/21/2025 20:44:25'!
comer: unaCantidadDeKilosDeCerebro
	diasDeVida := 4 * unaCantidadDeKilosDeCerebro + diasDeVida! !

!Bill class methodsFor: '-- all --' stamp: 'N 3/21/2025 20:42:53'!
initialize
			diasDeVida := 28! !

!Bill class methodsFor: '--** private fileout/in **--' stamp: 'N 3/21/2025 20:50:22'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	diasDeVida := 28.! !


!Bill class methodsFor: '--** private fileout/in **--' stamp: 'N 3/21/2025 20:50:22'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	diasDeVida := 28.! !

Bill initialize!
Bill initializeAfterFileIn!