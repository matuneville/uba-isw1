!classDefinition: #TestDePerforación category: #'ISW1-2023-1C-Parcial-1'!
TestCase subclass: #TestDePerforación
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!TestDePerforación methodsFor: 'test' stamp: 'ARM 5/5/2023 17:58:53'!
test01CuandoExcavaSueloArenosoConMechaSoftRemueveCapaArenosa

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo arenoso.
			CapaDeSuelo tierra.
			CapaDeSuelo concretoConResistencia: 5 } .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaSoft.
	
	excavadora darGolpeDeTaladro.
	
	self assert: CapaDeSuelo tierra equals: excavadora capaDeSueloInmediata
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'ARM 5/5/2023 17:58:58'!
test02CuandoExcavaSueloTierraConMechaSoftNoModificaElSuelo

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo tierra.
			CapaDeSuelo concretoConResistencia: 5 } .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaSoft.
	
	excavadora darGolpeDeTaladro.
	
	self assert: CapaDeSuelo tierra equals: excavadora capaDeSueloInmediata
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'ARM 5/5/2023 18:02:52'!
test03CuandoExcavaConcretoConMechaSoftSeRompeLaMecha

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo concretoConResistencia: 5.
			CapaDeSuelo tierra.} .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaSoft.
	
	self should: [excavadora darGolpeDeTaladro]
		raise: Error
		withExceptionDo: [:unError |
			self assert: 'Se rompió' equals: unError messageText.
			self assert: excavadora conMechaRota.].
	! !

!TestDePerforación methodsFor: 'test' stamp: 'ARM 5/5/2023 17:59:05'!
test04CuandoExcavaSueloArenosoConMechaWidiaRemueveCapaArenosa

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo arenoso.
			CapaDeSuelo tierra.
			CapaDeSuelo concretoConResistencia: 5 } .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaWidia.
	
	excavadora darGolpeDeTaladro.
	
	self assert: CapaDeSuelo tierra equals: excavadora capaDeSueloInmediata
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'ARM 5/5/2023 17:59:09'!
test05CuandoExcavaSueloTierraConMechaWidiaEnDosImpactosTransformaLaCapaEnArenoso

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo tierra.
			CapaDeSuelo concretoConResistencia: 5 } .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaWidia.
	
	excavadora darGolpeDeTaladro.
	excavadora darGolpeDeTaladro.	
	
	self assert: CapaDeSuelo arenoso equals: excavadora capaDeSueloInmediata
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'ARM 5/5/2023 18:02:45'!
test06CuandoExcavaSueloConcretoConMechaWidiaEnTresImpactosRompeLaMecha

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo concretoConResistencia: 5.	
			CapaDeSuelo tierra.
} .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaWidia.
	
	excavadora darGolpeDeTaladro.
	excavadora darGolpeDeTaladro.	
	
	self should: [excavadora darGolpeDeTaladro]
		raise: Error
		withExceptionDo: [:unError |
			self assert: 'Se rompió' equals: unError messageText.
			self assert: excavadora conMechaRota.].
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'ARM 5/5/2023 18:03:00'!
test07CuandoExcavaSueloArenosoConMechaDiamanteRompeLaMecha

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo arenoso.
			CapaDeSuelo tierra.
			CapaDeSuelo concretoConResistencia: 5 } .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaDiamante.
	
	self should: [excavadora darGolpeDeTaladro]
		raise: Error
		withExceptionDo: [:unError |
			self assert: 'Se rompió' equals: unError messageText.
			self assert: excavadora conMechaRota ].
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'ARM 5/8/2023 13:10:43'!
test08CuandoExcavaSueloTierraConMechaDiamanteRemueveCapa

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo tierra.
			CapaDeSuelo concretoConResistencia: 5 } .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaDiamante.
	
	excavadora darGolpeDeTaladro.
	
	self assert: (CapaDeSuelo concretoConResistencia: 5) equals: excavadora capaDeSueloInmediata

	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'ARM 5/8/2023 13:10:48'!
test09CuandoExcavaSueloConcretoConMechaDiamanteBajaUnDecimoDeResistencia

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo concretoConResistencia: 5.
			CapaDeSuelo tierra.
			} .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaDiamante.
	
	excavadora darGolpeDeTaladro.
	excavadora darGolpeDeTaladro.	
	
	self assert: (CapaDeSuelo concretoConResistencia: 4) equals: excavadora capaDeSueloInmediata

	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'MN 5/4/2025 16:19:50'!
test10CuandoRemueveLaCapaYHayPiedrasLasRecolectaEnSuContainer

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo arenoso.
			CapaDePiedras nuevaDe: 'Mica'.
			CapaDePiedras nuevaDe: 'Marmol'
			} .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaSoft.
	
	excavadora darGolpeDeTaladro.
	
	self assert: {	'Mica'. 'Marmol'} equals: excavadora elementsInContainer
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'HAW 5/3/2023 22:34:18'!
test11CuandoRemueveLaCapaYNoHayNadaNoRecogeNada

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo arenoso.
			} .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaSoft.
	
	excavadora darGolpeDeTaladro.
	
	self assert: excavadora elementsInContainer isEmpty
	! !

!TestDePerforación methodsFor: 'test' stamp: 'ARM 5/5/2023 18:03:09'!
test12NoPuedePerforarSinMecha

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo arenoso.
			} .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
		
	self should: [excavadora darGolpeDeTaladro]
		raise: Error
		withExceptionDo: [:unError |
			self assert: 'No puede perforar' equals: unError messageText.
			self assert: (CapaDeSuelo arenoso) equals: excavadora capaDeSueloInmediata ].	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'MN 5/4/2025 12:14:44'!
test13PuedeCalcularProfundidadDelSuelo

	| excavadora sueloAExcavar |
	
	sueloAExcavar := { CapaDeSuelo arenosoDeAltura: 2. CapaDeSuelo tierraDeAltura: 40. CapaDeSuelo arenoso} .
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	self assert: 42 equals: excavadora calcularProfundidadDelSuelo.

	! !

!TestDePerforación methodsFor: 'test' stamp: 'MN 5/4/2025 16:51:11'!
test14PuedeContarLasCapasDeTipoArenoso

	| excavadora sueloAExcavar |
	
	sueloAExcavar := { CapaDeSuelo arenosoDeAltura: 2. CapaDeSuelo tierraDeAltura: 40. CapaDeSuelo arenoso. CapaDeSuelo concretoConResistencia: 10 }.
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	self assert: 2 equals: (excavadora contarCapas: SueloArenoso).

	! !

!TestDePerforación methodsFor: 'test' stamp: 'MN 5/4/2025 16:51:14'!
test15PuedeContarLasCapasDeTipoTierra

	| excavadora sueloAExcavar |
	
	sueloAExcavar := { CapaDeSuelo arenosoDeAltura: 2. CapaDeSuelo tierraDeAltura: 40. CapaDeSuelo arenoso. CapaDeSuelo concretoConResistencia: 10 }.
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	self assert: 1 equals: (excavadora contarCapas: SueloTierra).

	! !

!TestDePerforación methodsFor: 'test' stamp: 'MN 5/4/2025 16:51:17'!
test16PuedeContarLasCapasDeTipoConcreto

	| excavadora sueloAExcavar |
	
	sueloAExcavar := { CapaDeSuelo arenosoDeAltura: 2. CapaDeSuelo tierraDeAltura: 40. CapaDeSuelo arenoso. CapaDeSuelo concretoConResistencia: 10 }.
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	self assert: 1 equals: (excavadora contarCapas: SueloConcreto).

	! !

!TestDePerforación methodsFor: 'test' stamp: 'MN 5/4/2025 16:40:56'!
test17PuedeCalcularProfundidadHastaPrimerCapaDeTipoArenoso

	| excavadora sueloAExcavar |
	
	sueloAExcavar := { CapaDeSuelo arenosoDeAltura: 2. CapaDeSuelo tierraDeAltura: 40. CapaDeSuelo arenoso. CapaDeSuelo concretoConResistencia: 10 }.
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	self assert: 0 equals: (excavadora calcularProfundidadDelSueloHasta: SueloArenoso).

	! !

!TestDePerforación methodsFor: 'test' stamp: 'MN 5/4/2025 16:41:01'!
test18PuedeCalcularProfundidadHastaPrimerCapaDeTipoTierra

	| excavadora sueloAExcavar |
	
	sueloAExcavar := { CapaDeSuelo arenosoDeAltura: 2. CapaDeSuelo tierraDeAltura: 40. CapaDeSuelo arenoso. CapaDeSuelo concretoConResistencia: 10 }.
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	self assert: 2 equals: (excavadora calcularProfundidadDelSueloHasta: SueloTierra).

	! !

!TestDePerforación methodsFor: 'test' stamp: 'MN 5/4/2025 16:41:07'!
test19PuedeCalcularProfundidadHastaPrimerCapaDeTipoConcreto

	| excavadora sueloAExcavar |
	
	sueloAExcavar := { CapaDeSuelo arenosoDeAltura: 2. CapaDeSuelo tierraDeAltura: 40. CapaDeSuelo arenoso. CapaDeSuelo concretoConResistencia: 10 }.
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	self assert: 42 equals: (excavadora calcularProfundidadDelSueloHasta: SueloConcreto).

	! !


!classDefinition: #CapaDeSuelo category: #'ISW1-2023-1C-Parcial-1'!
Object subclass: #CapaDeSuelo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!CapaDeSuelo methodsFor: 'excavation' stamp: 'MN 5/4/2025 16:12:58'!
aPerforarCon: unaPerforadora

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CapaDeSuelo class' category: #'ISW1-2023-1C-Parcial-1'!
CapaDeSuelo class
	instanceVariableNames: ''!

!CapaDeSuelo class methodsFor: 'instance creation' stamp: 'MN 5/4/2025 12:19:41'!
arenoso

	^ SueloArenoso new inicializarDeAltura: 0! !

!CapaDeSuelo class methodsFor: 'instance creation' stamp: 'MN 5/4/2025 12:18:43'!
arenosoDeAltura: unaAltura

	^ SueloArenoso new inicializarDeAltura: unaAltura! !

!CapaDeSuelo class methodsFor: 'instance creation' stamp: 'MN 5/4/2025 11:25:26'!
concretoConResistencia: resistencia 

	^ SueloConcreto new inicializarCon: resistencia ! !

!CapaDeSuelo class methodsFor: 'instance creation' stamp: 'MN 5/4/2025 12:19:47'!
tierra

	^ SueloTierra new inicializarDeAltura: 0! !

!CapaDeSuelo class methodsFor: 'instance creation' stamp: 'MN 5/4/2025 12:18:46'!
tierraDeAltura: unaAltura

	^ SueloTierra new inicializarDeAltura: unaAltura! !


!classDefinition: #CapaDePiedras category: #'ISW1-2023-1C-Parcial-1'!
CapaDeSuelo subclass: #CapaDePiedras
	instanceVariableNames: 'nombreDePiedra'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!CapaDePiedras methodsFor: 'excavation' stamp: 'MN 5/4/2025 16:14:12'!
aPerforarCon: unaPerforadora
	
	unaPerforadora perforaCapaDePiedras! !


!CapaDePiedras methodsFor: 'initialize' stamp: 'MN 5/4/2025 16:23:52'!
inicializarDe: elNombreDeUnaPiedra

	nombreDePiedra := elNombreDeUnaPiedra ! !


!CapaDePiedras methodsFor: 'accessing' stamp: 'MN 5/4/2025 16:27:18'!
nombreDePiedra
	^ nombreDePiedra ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CapaDePiedras class' category: #'ISW1-2023-1C-Parcial-1'!
CapaDePiedras class
	instanceVariableNames: ''!

!CapaDePiedras class methodsFor: 'instance creation' stamp: 'MN 5/4/2025 16:18:56'!
nuevaDe: elNombreDeUnaPiedra
	^self new inicializarDe: elNombreDeUnaPiedra ! !


!classDefinition: #CapaDeSueloPerforable category: #'ISW1-2023-1C-Parcial-1'!
CapaDeSuelo subclass: #CapaDeSueloPerforable
	instanceVariableNames: 'altura'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!CapaDeSueloPerforable methodsFor: 'accessing' stamp: 'MN 5/4/2025 16:06:59'!
altura

	^ altura.! !


!CapaDeSueloPerforable methodsFor: 'scan' stamp: 'MN 5/4/2025 16:43:03'!
scan
	^ self class scan! !


!CapaDeSueloPerforable methodsFor: 'excavation' stamp: 'MN 5/4/2025 16:13:15'!
aPerforarCon: unaPerforadora
	
	unaPerforadora perforaCapaDeSuelo ! !

!CapaDeSueloPerforable methodsFor: 'excavation' stamp: 'MN 5/4/2025 16:08:27'!
darGolpeCon: unaPerforadora y: unaMecha

	self subclassResponsibility! !


!CapaDeSueloPerforable methodsFor: 'bajar resistencia' stamp: 'MN 5/4/2025 16:08:58'!
sinResistencia

	self subclassResponsibility! !


!CapaDeSueloPerforable methodsFor: 'comparing' stamp: 'MN 5/4/2025 16:09:11'!
= unaCapaDeSuelo

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CapaDeSueloPerforable class' category: #'ISW1-2023-1C-Parcial-1'!
CapaDeSueloPerforable class
	instanceVariableNames: ''!

!CapaDeSueloPerforable class methodsFor: 'scan' stamp: 'MN 5/4/2025 16:41:34'!
scan

	self subclassResponsibility ! !


!classDefinition: #SueloArenoso category: #'ISW1-2023-1C-Parcial-1'!
CapaDeSueloPerforable subclass: #SueloArenoso
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!SueloArenoso methodsFor: 'excavation' stamp: 'MN 5/4/2025 11:20:23'!
darGolpeCon: unaPerforadora y: unaMecha

	^ unaMecha darGolpeSobreSueloArenoso ! !


!SueloArenoso methodsFor: 'initialization' stamp: 'MN 5/4/2025 12:16:17'!
inicializarDeAltura: unaAltura

	altura := unaAltura. ! !



!SueloArenoso methodsFor: 'comparing' stamp: 'MN 5/4/2025 12:03:52'!
= unaCapaDeSuelo

	^(unaCapaDeSuelo isKindOf: self class)! !


!SueloArenoso methodsFor: 'bajar resistencia' stamp: 'MN 5/4/2025 12:08:29'!
sinResistencia
	true! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SueloArenoso class' category: #'ISW1-2023-1C-Parcial-1'!
SueloArenoso class
	instanceVariableNames: ''!

!SueloArenoso class methodsFor: 'scan' stamp: 'MN 5/4/2025 16:41:42'!
scan
	
	^ 7! !


!classDefinition: #SueloConcreto category: #'ISW1-2023-1C-Parcial-1'!
CapaDeSueloPerforable subclass: #SueloConcreto
	instanceVariableNames: 'resistencia'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!SueloConcreto methodsFor: 'excavation' stamp: 'MN 5/4/2025 11:20:31'!
darGolpeCon: unaPerforadora y: unaMecha

	^ unaMecha darGolpeSobreSueloConcreto ! !


!SueloConcreto methodsFor: 'initialization' stamp: 'MN 5/4/2025 12:00:59'!
inicializarCon: resistenciaInicial

	resistencia := resistenciaInicial.
	altura := nil.! !



!SueloConcreto methodsFor: 'comparing' stamp: 'MN 5/4/2025 12:03:43'!
= unaCapaDeSuelo

	^(unaCapaDeSuelo isKindOf: self class) and:[resistencia = unaCapaDeSuelo resistencia]! !


!SueloConcreto methodsFor: 'bajar resistencia' stamp: 'MN 5/4/2025 12:07:18'!
bajaUnDecimoDeResistencia
	resistencia := resistencia - 1! !

!SueloConcreto methodsFor: 'bajar resistencia' stamp: 'MN 5/4/2025 12:08:21'!
sinResistencia
	^resistencia = 0! !


!SueloConcreto methodsFor: 'accessing' stamp: 'MN 5/4/2025 12:07:31'!
resistencia

	^ resistencia.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SueloConcreto class' category: #'ISW1-2023-1C-Parcial-1'!
SueloConcreto class
	instanceVariableNames: ''!

!SueloConcreto class methodsFor: 'scan' stamp: 'MN 5/4/2025 16:41:45'!
scan
	
	^ 50! !


!classDefinition: #SueloTierra category: #'ISW1-2023-1C-Parcial-1'!
CapaDeSueloPerforable subclass: #SueloTierra
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!SueloTierra methodsFor: 'excavation' stamp: 'MN 5/4/2025 11:20:38'!
darGolpeCon: unaPerforadora y: unaMecha

	^ unaMecha darGolpeSobreSueloTierra ! !


!SueloTierra methodsFor: 'initialization' stamp: 'MN 5/4/2025 12:16:46'!
inicializarDeAltura: unaAltura

	altura := unaAltura . ! !



!SueloTierra methodsFor: 'comparing' stamp: 'MN 5/4/2025 12:05:14'!
= unaCapaDeSuelo

	^(unaCapaDeSuelo isKindOf: self class)! !


!SueloTierra methodsFor: 'bajar resistencia' stamp: 'MN 5/4/2025 12:08:41'!
sinResistencia
	true! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SueloTierra class' category: #'ISW1-2023-1C-Parcial-1'!
SueloTierra class
	instanceVariableNames: ''!

!SueloTierra class methodsFor: 'scan' stamp: 'MN 5/4/2025 16:41:49'!
scan
	
	^ 10! !


!classDefinition: #Mecha category: #'ISW1-2023-1C-Parcial-1'!
Object subclass: #Mecha
	instanceVariableNames: 'perforadora'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!Mecha methodsFor: 'initializing' stamp: 'MN 5/4/2025 10:21:41'!
inicializarPara: unaPerforadora 

	perforadora := unaPerforadora ! !


!Mecha methodsFor: 'excavation' stamp: 'MN 5/4/2025 11:07:37'!
darGolpe

	self subclassResponsibility! !


!Mecha methodsFor: 'testing' stamp: 'MN 5/4/2025 17:00:27'!
estaRota

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Mecha class' category: #'ISW1-2023-1C-Parcial-1'!
Mecha class
	instanceVariableNames: ''!

!Mecha class methodsFor: 'instance creation' stamp: 'MN 5/4/2025 10:21:12'!
nuevaPara: unaPerforadora
	
	^ self new inicializarPara: unaPerforadora ! !


!classDefinition: #MechaInutilizable category: #'ISW1-2023-1C-Parcial-1'!
Mecha subclass: #MechaInutilizable
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!MechaInutilizable methodsFor: 'testing' stamp: 'MN 5/4/2025 17:00:57'!
estaRota

	self subclassResponsibility! !


!classDefinition: #MechaRota category: #'ISW1-2023-1C-Parcial-1'!
MechaInutilizable subclass: #MechaRota
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!MechaRota methodsFor: 'testing' stamp: 'MN 5/4/2025 17:01:05'!
estaRota
	^ true ! !


!classDefinition: #SinMecha category: #'ISW1-2023-1C-Parcial-1'!
MechaInutilizable subclass: #SinMecha
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!


!SinMecha methodsFor: 'excavation' stamp: 'MN 5/4/2025 11:08:08'!
darGolpe
	
	perforadora darGolpeSinMecha ! !


!SinMecha methodsFor: 'testing' stamp: 'MN 5/4/2025 17:01:09'!
estaRota
	^ true ! !


!classDefinition: #MechaUtilizable category: #'ISW1-2023-1C-Parcial-1'!
Mecha subclass: #MechaUtilizable
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!MechaUtilizable methodsFor: 'excavation' stamp: 'MN 5/4/2025 11:07:52'!
darGolpe
	
	perforadora darGolpeConMechaExistente.! !

!MechaUtilizable methodsFor: 'excavation' stamp: 'MN 5/4/2025 11:06:38'!
darGolpeSobreSueloArenoso

	self subclassResponsibility! !

!MechaUtilizable methodsFor: 'excavation' stamp: 'MN 5/4/2025 11:06:56'!
darGolpeSobreSueloConcreto

	self subclassResponsibility! !

!MechaUtilizable methodsFor: 'excavation' stamp: 'MN 5/4/2025 11:07:02'!
darGolpeSobreSueloTierra

	self subclassResponsibility! !


!MechaUtilizable methodsFor: 'testing' stamp: 'MN 5/4/2025 17:00:34'!
estaRota
	^ false ! !


!classDefinition: #Diamante category: #'ISW1-2023-1C-Parcial-1'!
MechaUtilizable subclass: #Diamante
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!Diamante methodsFor: 'excavation' stamp: 'MN 5/4/2025 10:25:26'!
darGolpeSobreSueloArenoso

	^ perforadora darGolpeSobreSueloArenosoConMechaDiamante! !

!Diamante methodsFor: 'excavation' stamp: 'MN 5/4/2025 10:45:46'!
darGolpeSobreSueloConcreto

	^ perforadora darGolpeSobreSueloConcretoConMechaDiamante! !

!Diamante methodsFor: 'excavation' stamp: 'MN 5/4/2025 10:36:52'!
darGolpeSobreSueloTierra

	^ perforadora darGolpeSobreSueloTierraConMechaDiamante ! !



!classDefinition: #Soft category: #'ISW1-2023-1C-Parcial-1'!
MechaUtilizable subclass: #Soft
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!Soft methodsFor: 'excavation' stamp: 'MN 5/4/2025 10:25:37'!
darGolpeSobreSueloArenoso

	^ perforadora darGolpeSobreSueloArenosoConMechaSoft! !

!Soft methodsFor: 'excavation' stamp: 'MN 5/4/2025 10:46:16'!
darGolpeSobreSueloConcreto

	perforadora darGolpeSobreSueloConcretoConMechaSoft! !

!Soft methodsFor: 'excavation' stamp: 'MN 5/4/2025 10:37:02'!
darGolpeSobreSueloTierra

	^ perforadora darGolpeSobreSueloTierraConMechaSoft ! !


!classDefinition: #Widia category: #'ISW1-2023-1C-Parcial-1'!
MechaUtilizable subclass: #Widia
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!Widia methodsFor: 'excavation' stamp: 'MN 5/4/2025 10:25:49'!
darGolpeSobreSueloArenoso

	^ perforadora darGolpeSobreSueloArenosoConMechaWidia! !

!Widia methodsFor: 'excavation' stamp: 'MN 5/4/2025 10:46:36'!
darGolpeSobreSueloConcreto

	^ perforadora darGolpeSobreSueloConcretoConMechaWidia! !

!Widia methodsFor: 'excavation' stamp: 'MN 5/4/2025 10:37:10'!
darGolpeSobreSueloTierra

	^ perforadora darGolpeSobreSueloTierraConMechaWidia! !


!classDefinition: #Perforadora category: #'ISW1-2023-1C-Parcial-1'!
Object subclass: #Perforadora
	instanceVariableNames: 'tipoDeSuelo mechaPuesta vecesQueGolpeoCapaActual capasDeSueloDebajo container'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!Perforadora methodsFor: 'cambiar capa' stamp: 'MN 5/4/2025 16:15:02'!
pasarAProximaCapa
	vecesQueGolpeoCapaActual := 0.
	capasDeSueloDebajo := capasDeSueloDebajo allButFirst.
	capasDeSueloDebajo ifEmpty: [^self]. 
	
	capasDeSueloDebajo first aPerforarCon: self.
! !

!Perforadora methodsFor: 'cambiar capa' stamp: 'MN 5/4/2025 16:24:05'!
perforaCapaDePiedras

	container addAll: (capasDeSueloDebajo collect: [:capaDePiedra | capaDePiedra nombreDePiedra ])! !

!Perforadora methodsFor: 'cambiar capa' stamp: 'MN 5/4/2025 16:15:08'!
perforaCapaDeSuelo! !

!Perforadora methodsFor: 'cambiar capa' stamp: 'ARM 4/27/2023 20:46:30'!
transformarCapaEnArenoso
	capasDeSueloDebajo :=
			capasDeSueloDebajo allButFirst asOrderedCollection
			addFirst: CapaDeSuelo arenoso;
			yourself! !


!Perforadora methodsFor: 'excavation' stamp: 'MN 5/4/2025 11:11:38'!
darGolpeDeTaladro
		
	mechaPuesta darGolpe.

! !


!Perforadora methodsFor: 'excavation-private' stamp: 'MN 5/4/2025 11:21:09'!
darGolpeConMechaExistente

	vecesQueGolpeoCapaActual := vecesQueGolpeoCapaActual + 1.
	
	^ capasDeSueloDebajo first darGolpeCon: self y: mechaPuesta.
	! !

!Perforadora methodsFor: 'excavation-private' stamp: 'MN 5/4/2025 11:10:21'!
darGolpeSinMecha

	^ self error: 'No puede perforar'! !

!Perforadora methodsFor: 'excavation-private' stamp: 'MN 5/4/2025 16:59:19'!
darGolpeSobreSueloArenosoConMechaDiamante

	mechaPuesta := MechaRota nuevaPara: self.
	self error: 'Se rompió'! !

!Perforadora methodsFor: 'excavation-private' stamp: 'MN 5/3/2025 17:11:54'!
darGolpeSobreSueloArenosoConMechaSoft

	^ self pasarAProximaCapa! !

!Perforadora methodsFor: 'excavation-private' stamp: 'MN 5/3/2025 17:12:19'!
darGolpeSobreSueloArenosoConMechaWidia

	^ self pasarAProximaCapa! !

!Perforadora methodsFor: 'excavation-private' stamp: 'MN 5/4/2025 10:44:43'!
darGolpeSobreSueloConcretoConMechaDiamante
 
	vecesQueGolpeoCapaActual even ifTrue: [ capasDeSueloDebajo first bajaUnDecimoDeResistencia].
	capasDeSueloDebajo first sinResistencia ifTrue: [ ^self transformarCapaEnArenoso].
	^vecesQueGolpeoCapaActual ! !

!Perforadora methodsFor: 'excavation-private' stamp: 'MN 5/4/2025 16:59:32'!
darGolpeSobreSueloConcretoConMechaSoft

	mechaPuesta := MechaRota nuevaPara: self.
	self error: 'Se rompió'! !

!Perforadora methodsFor: 'excavation-private' stamp: 'MN 5/4/2025 16:59:48'!
darGolpeSobreSueloConcretoConMechaWidia

	^ vecesQueGolpeoCapaActual = 3 ifTrue: [
		mechaPuesta := MechaRota nuevaPara: self.
		self error: 'Se rompió'
	]! !

!Perforadora methodsFor: 'excavation-private' stamp: 'MN 5/4/2025 10:36:06'!
darGolpeSobreSueloTierraConMechaDiamante

	^ self pasarAProximaCapa! !

!Perforadora methodsFor: 'excavation-private' stamp: 'MN 5/4/2025 10:28:33'!
darGolpeSobreSueloTierraConMechaSoft

	^ self! !

!Perforadora methodsFor: 'excavation-private' stamp: 'MN 5/4/2025 10:35:34'!
darGolpeSobreSueloTierraConMechaWidia

	^ vecesQueGolpeoCapaActual = 2 ifTrue: [ self transformarCapaEnArenoso ]! !


!Perforadora methodsFor: 'initialization' stamp: 'MN 5/4/2025 10:58:43'!
initializeSobreSuelo: capasDeSueloAExcavarInicialmente

	capasDeSueloDebajo := capasDeSueloAExcavarInicialmente.
	vecesQueGolpeoCapaActual := 0.
	container := OrderedCollection new.
	mechaPuesta := SinMecha nuevaPara: self! !


!Perforadora methodsFor: 'accessing' stamp: 'ARM 4/27/2023 20:17:21'!
capaDeSueloInmediata
	^capasDeSueloDebajo first! !

!Perforadora methodsFor: 'accessing' stamp: 'MN 5/4/2025 16:58:57'!
conMechaRota

	^ mechaPuesta estaRota! !

!Perforadora methodsFor: 'accessing' stamp: 'ARM 4/27/2023 21:12:20'!
elementsInContainer
	^container asArray! !

!Perforadora methodsFor: 'accessing' stamp: 'MN 5/4/2025 11:35:16'!
sinMecha

	^mechaPuesta = SinMecha nuevaPara: self! !


!Perforadora methodsFor: 'colocar mecha' stamp: 'MN 5/4/2025 10:20:09'!
ponerMechaDiamante
	mechaPuesta := Diamante nuevaPara: self! !

!Perforadora methodsFor: 'colocar mecha' stamp: 'MN 5/4/2025 10:20:13'!
ponerMechaSoft
	mechaPuesta := Soft nuevaPara: self! !

!Perforadora methodsFor: 'colocar mecha' stamp: 'MN 5/4/2025 10:20:15'!
ponerMechaWidia
	mechaPuesta := Widia nuevaPara: self! !


!Perforadora methodsFor: 'scan' stamp: 'MN 5/4/2025 16:31:55'!
calcularProfundidadDelSuelo
	
	^ capasDeSueloDebajo sum: [:capaDeSuelo |
		capaDeSuelo altura.
	]
	
	 ! !

!Perforadora methodsFor: 'scan' stamp: 'MN 5/4/2025 16:47:56'!
calcularProfundidadDelSueloHasta: tipoDeCapa
	
	| valorDeCapaLimite |
	
	valorDeCapaLimite := tipoDeCapa scan.	
	
	^ capasDeSueloDebajo
		inject: 0
		into: [ :profundidadActual :capaDeSuelo |
			capaDeSuelo scan = valorDeCapaLimite ifTrue: [^ profundidadActual ].
			profundidadActual + capaDeSuelo altura
		].
	
	 ! !

!Perforadora methodsFor: 'scan' stamp: 'MN 5/4/2025 16:53:06'!
contarCapas: tipoDeCapa
	
	"Cuenta las capas de tipo tipoDeCapa. Recordar que para identificar cada capa se utiliza el valor de scan que retorna. Por ej. un capa tipo Arenoso retorna 7 al scan"
	
	| valor |
	
	valor := tipoDeCapa scan.
	
	"^ capasDeSueloDebajo sum: [:capaDeSuelo |
		capaDeSuelo scan = valor ifTrue:[1] ifFalse:[0] 
	]"

	^ capasDeSueloDebajo count: [:capaDeSuelo |
		capaDeSuelo scan = valor
	]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Perforadora class' category: #'ISW1-2023-1C-Parcial-1'!
Perforadora class
	instanceVariableNames: ''!

!Perforadora class methodsFor: 'instance creation' stamp: 'ARM 4/27/2023 20:07:05'!
sobreSuelo: capasDeSueloAExcavar 

	^self new initializeSobreSuelo: capasDeSueloAExcavar ! !
