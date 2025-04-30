!classDefinition: #TestMyA category: #'2024-2C-Parcial-1'!
TestCase subclass: #TestMyA
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!TestMyA methodsFor: 'tests' stamp: 'NR 9/27/2024 03:49:05'!
test01UnMonstruoAtacaAUnAventureroUsandoSusPVs

	| guerrero |
	
	guerrero := self crearGuerrero.
	
	self crearGoblin atacarA: guerrero.
	
	self assert: (guerrero tienePuntosDeVida: 10 * pv - (5 * pv))! !

!TestMyA methodsFor: 'tests' stamp: 'NR 9/27/2024 04:09:06'!
test02UnAventureroPuedeUsarItemsDeDefensaParaProtegerse

	| guerrero |
	
	guerrero := self crearGuerrero.
	guerrero equiparItemDeDefensa: self crearEscudoMagico.
	guerrero equiparItemDeDefensa: self crearArmadura.
	
	self crearOgro atacarA: guerrero.
	
	self assert: (guerrero tienePuntosDeVida: 10 * pv - (15 * pv - (5 * pv) - (3 * pv)))! !

!TestMyA methodsFor: 'tests' stamp: 'NR 9/27/2024 04:08:35'!
test03LosItemsDeDefensaNoPuedenAumentarLosPuntosDeVidaDelAventurero

	| guerrero |
	
	guerrero := self crearGuerrero.
	guerrero equiparItemDeDefensa: self crearArmadura.
	guerrero equiparItemDeDefensa: self crearArmadura.
	
	self crearGoblin atacarA: guerrero.
	
	self assert: (guerrero tienePuntosDeVida: 10 * pv)! !

!TestMyA methodsFor: 'tests' stamp: 'HAW 9/27/2024 09:04:39'!
test04UnAventureroNoPuedeAtacarSinItemsEquipados

	| guerrero ogro espada |
	
	guerrero := self crearGuerrero.
	ogro := self crearOgro.
	espada := self crearEspadaPara: ogro.
	
	self should: [ guerrero atacarA: ogro con: (espada) ] 
		raise: Error-MessageNotUnderstood 
		withExceptionDo: [ :anException |
			self assert: anException messageText equals: guerrero itemNoDisponibleMensajeDeError.
			self assert: (ogro tienePuntosDeVida: 15 * pv)
	]
	! !

!TestMyA methodsFor: 'tests' stamp: 'LL 9/27/2024 10:48:15'!
test05UnGuerreroConEspadaProvocaDañoSegunSuFuerza

	| guerrero ogro itemDeAtaque otroItemDeAtaque otroOgro |
	
	guerrero := self crearGuerrero.
	ogro := self crearOgro.
	itemDeAtaque := self crearEspadaPara: ogro.
	guerrero equiparItemDeAtaque: itemDeAtaque.
	otroOgro := self crearOgro.
	otroItemDeAtaque := self crearEspadaPara: otroOgro.
	guerrero equiparItemDeAtaque: otroItemDeAtaque.
	
	guerrero atacarA: ogro con: itemDeAtaque.
	guerrero atacarA: otroOgro con: otroItemDeAtaque.
	
	self assert: (ogro tienePuntosDeVida: 15 * pv - (4 * pv)).
	self assert: (otroOgro tienePuntosDeVida: 15 * pv - (4 * pv)).
	self assert: (guerrero tienePuntosDeVida: 10 * pv)! !

!TestMyA methodsFor: 'tests' stamp: 'HAW 9/27/2024 09:46:06'!
test06UnGuerreroConEspadaNoProvocaDañoAOtroMonstruoQueNoSeaElDeLaEspada

	| guerrero ogroNoObjetivoDeAtaque itemDeAtaque ogroObjetivoDeAtaque |
	
	guerrero := self crearGuerrero.
	ogroObjetivoDeAtaque := self crearOgro.
	itemDeAtaque := self crearEspadaPara: ogroObjetivoDeAtaque.
	guerrero equiparItemDeAtaque: itemDeAtaque.
	ogroNoObjetivoDeAtaque := self crearOgro.
	
	guerrero atacarA: ogroNoObjetivoDeAtaque con: itemDeAtaque.
	
	self assert: (ogroNoObjetivoDeAtaque tienePuntosDeVida: 15 * pv)! !

!TestMyA methodsFor: 'tests' stamp: 'NR 9/27/2024 04:08:52'!
test07UnAventureroNoGuerreroPierdeTodosSusPuntosDeVidaSiUsaLaEspada

	| ogro mago itemDeAtaque |
	
	mago := self crearMago.
	ogro := self crearOgro.
	itemDeAtaque := self crearEspadaPara: ogro.
	mago equiparItemDeAtaque: itemDeAtaque.
	
	mago atacarA: ogro con: itemDeAtaque.
	
	self assert: (ogro tienePuntosDeVida: 15 * pv).
	self assert: (mago tienePuntosDeVida: 0)! !

!TestMyA methodsFor: 'tests' stamp: 'NR 9/27/2024 04:08:49'!
test08ElMagoUsandoElBaculoMataAlGoblin

	| mago goblin itemDeAtaque |
	
	mago := self crearMago.
	itemDeAtaque := self crearBaculo.
	mago equiparItemDeAtaque: itemDeAtaque.
	goblin :=  self crearGoblin.
	
	mago atacarA: goblin con: itemDeAtaque.
	
	self assert: (goblin tienePuntosDeVida: 0)! !

!TestMyA methodsFor: 'tests' stamp: 'NR 9/27/2024 04:42:13'!
test09ElMagoUsandoElBaculoDañaAOtrosMonstruosSegunSuFuerza

	| mago ogro itemDeAtaque |
	
	mago := self crearMago.
	itemDeAtaque := self crearBaculo.
	mago equiparItemDeAtaque: itemDeAtaque.
	ogro := self crearOgro.
	
	mago atacarA: ogro con: itemDeAtaque.
	
	self assert: (ogro tienePuntosDeVida: 15 * pv - (2 * pv))! !

!TestMyA methodsFor: 'tests' stamp: 'NR 9/27/2024 04:08:45'!
test10UnAventureroNoMagoEsPenalizadoAlUsarElBaculoDuplicandoPVDeGoblins

	| guerrero goblin itemDeAtaque |
	
	guerrero := self crearGuerrero.
	itemDeAtaque := self crearBaculo.
	guerrero equiparItemDeAtaque: itemDeAtaque.
	goblin := self crearGoblin.
	
	guerrero atacarA: goblin con: itemDeAtaque.
	
	self assert: (goblin tienePuntosDeVida: 5 * pv * 2)! !

!TestMyA methodsFor: 'tests' stamp: 'NR 9/27/2024 04:08:38'!
test11UnAventureroNoMagoUsandoElBaculoDañaSegunSuFuerzaAOtrosMonstruos

	| guerrero ogro itemDeAtaque |
	
	guerrero := self crearGuerrero.
	itemDeAtaque := self crearBaculo.
	guerrero equiparItemDeAtaque: itemDeAtaque.
	ogro := self crearOgro.
	
	guerrero atacarA: ogro con: itemDeAtaque.
	
	self assert: (ogro tienePuntosDeVida: 15 * pv - (4 * pv))! !

!TestMyA methodsFor: 'tests' stamp: 'NR 9/27/2024 04:29:01'!
test12UnaEspadaNuncaPuedeSerUsadaEnMonstruosDeMenosDeUnMetro

	| goblin |
	
	goblin := self crearGoblin.
	
	self should: [ self crearEspadaPara: goblin ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anException |
		self assert: anException messageText equals: Espada noSePuedeAtacarAMonstruoMenorAUnMetroDeAlturaMensajeDeError
	]
	! !


!TestMyA methodsFor: 'crear items' stamp: 'MN 4/29/2025 20:11:36'!
crearArmadura

	^ ItemDeDefensa nuevaArmadura ! !

!TestMyA methodsFor: 'crear items' stamp: 'MN 4/29/2025 20:56:16'!
crearBaculo
	
	^ ItemDeAtaque nuevoBaculo! !

!TestMyA methodsFor: 'crear items' stamp: 'MN 4/29/2025 20:11:50'!
crearEscudoMagico

	^ ItemDeDefensa nuevoEscudoMagico ! !

!TestMyA methodsFor: 'crear items' stamp: 'MN 4/29/2025 20:57:20'!
crearEspadaPara: monstruo

	^ ItemDeAtaque nuevaEspadaPara: monstruo 
! !


!TestMyA methodsFor: 'crear combatientes' stamp: 'MN 4/29/2025 20:07:40'!
crearGoblin

	^ Monstruo nuevoGoblin 
! !

!TestMyA methodsFor: 'crear combatientes' stamp: 'MN 4/29/2025 20:07:50'!
crearGuerrero
	
	^ Aventurero nuevoGuerrero ! !

!TestMyA methodsFor: 'crear combatientes' stamp: 'MN 4/29/2025 20:08:03'!
crearMago

	^ Aventurero nuevoMago 
! !

!TestMyA methodsFor: 'crear combatientes' stamp: 'MN 4/29/2025 20:08:18'!
crearOgro

	 ^ Monstruo nuevoOgro ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TestMyA class' category: #'2024-2C-Parcial-1'!
TestMyA class
	instanceVariableNames: ''!

!TestMyA class methodsFor: 'initialization' stamp: 'LL 9/26/2024 20:21:50'!
initialize

	Smalltalk at: #pv put: (BaseUnit named: 'pv' sign: 'pv')! !


!classDefinition: #Aventurero category: #'2024-2C-Parcial-1'!
Object subclass: #Aventurero
	instanceVariableNames: 'fuerza PV proteccion itemsDeAtaque'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!Aventurero methodsFor: 'inicializacion' stamp: 'MN 4/30/2025 13:08:23'!
inicializarCon: unaCantidadDeVida
	
	PV := unaCantidadDeVida.
	proteccion := 0 * pv.
	itemsDeAtaque := Set new.! !


!Aventurero methodsFor: 'ataque' stamp: 'MN 4/30/2025 13:06:18'!
atacarA: unMonstruo con: unItemDeAtaque

	self subclassResponsibility ! !

!Aventurero methodsFor: 'ataque' stamp: 'MN 4/30/2025 13:06:25'!
equiparItemDeAtaque: unItemDeAtaque

	itemsDeAtaque add: unItemDeAtaque.! !

!Aventurero methodsFor: 'ataque' stamp: 'MN 4/30/2025 13:06:40'!
fuerza
	
	self subclassResponsibility ! !


!Aventurero methodsFor: 'defensa' stamp: 'MN 4/30/2025 13:06:57'!
equiparItemDeDefensa: unItemDeDefensa

	proteccion := proteccion + unItemDeDefensa proteccion! !

!Aventurero methodsFor: 'defensa' stamp: 'MN 4/30/2025 15:46:50'!
esAtacadoPor: unMonstruo conFuerza: fuerzaDeAtaque 

	PV := PV - (0 max: (fuerzaDeAtaque - proteccion))! !


!Aventurero methodsFor: 'acceso' stamp: 'MN 4/30/2025 13:07:02'!
tienePuntosDeVida: unPV

	^ PV = unPV! !

!Aventurero methodsFor: 'acceso' stamp: 'MN 4/29/2025 21:13:38'!
tipo
	^ tipo! !


!Aventurero methodsFor: 'assertions' stamp: 'MN 4/29/2025 20:51:03'!
assertTieneEquipadoItemDeAtaque: unItemDeAtaque
	(itemsDeAtaque includes: unItemDeAtaque) ifFalse: [
		self error: self itemNoDisponibleMensajeDeError.
	]
! !


!Aventurero methodsFor: 'mensajes de error' stamp: 'MN 4/29/2025 20:51:41'!
itemNoDisponibleMensajeDeError
	^'No tiene disponible el item para usar'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Aventurero class' category: #'2024-2C-Parcial-1'!
Aventurero class
	instanceVariableNames: ''!

!Aventurero class methodsFor: 'instance creation' stamp: 'MN 4/30/2025 13:08:35'!
nuevoGuerrero
	^ Guerrero new inicializarCon: 10 * pv.! !

!Aventurero class methodsFor: 'instance creation' stamp: 'MN 4/30/2025 13:08:53'!
nuevoMago

	^ Mago new inicializarCon: 15 * pv.! !


!classDefinition: #Guerrero category: #'2024-2C-Parcial-1'!
Aventurero subclass: #Guerrero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!Guerrero methodsFor: 'ataque' stamp: 'MN 4/30/2025 16:31:06'!
atacarA: unMonstruo con: unItemDeAtaque

	self assertTieneEquipadoItemDeAtaque: unItemDeAtaque.

	unMonstruo
		esAtacadoPorGuerrero: self
		con: unItemDeAtaque	
		yFuerza: self fuerza
! !

!Guerrero methodsFor: 'ataque' stamp: 'MN 4/30/2025 13:04:42'!
fuerza
	^ 4 * pv! !


!classDefinition: #Mago category: #'2024-2C-Parcial-1'!
Aventurero subclass: #Mago
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!Mago methodsFor: 'ataque' stamp: 'MN 4/30/2025 16:31:28'!
atacarA: unMonstruo con: unItemDeAtaque

	self assertTieneEquipadoItemDeAtaque: unItemDeAtaque.

	unMonstruo
		esAtacadoPorMago: self
		con: unItemDeAtaque	
		yFuerza: self fuerza! !

!Mago methodsFor: 'ataque' stamp: 'MN 4/30/2025 13:06:42'!
fuerza
	^ 2 * pv! !


!Mago methodsFor: 'defensa' stamp: 'MN 4/30/2025 16:32:16'!
pierdeTodaSuVida
	PV := 0.! !


!classDefinition: #ItemDeAtaque category: #'2024-2C-Parcial-1'!
Object subclass: #ItemDeAtaque
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!ItemDeAtaque methodsFor: 'ataque' stamp: 'MN 4/30/2025 16:19:40'!
calcularDañoCuandoAtacaGuerrero: unGuerrero conFuerza: fuerzaDeAtaque aGoblin: unGoblin
	
	self subclassResponsibility ! !

!ItemDeAtaque methodsFor: 'ataque' stamp: 'MN 4/30/2025 16:23:27'!
calcularDañoCuandoAtacaGuerrero: unGuerrero conFuerza: fuerzaDeAtaque aOgro: unOgro conVida: vidaDeOgro 
	
	self subclassResponsibility ! !

!ItemDeAtaque methodsFor: 'ataque' stamp: 'MN 4/30/2025 16:24:02'!
calcularDañoCuandoAtacaMago: unMago conFuerza: fuerzaDeAtaque aGoblin: unGoblin conVida: vidaDeGoblin 
	
	self subclassResponsibility ! !

!ItemDeAtaque methodsFor: 'ataque' stamp: 'MN 4/30/2025 16:24:20'!
calcularDañoCuandoAtacaMago: unMago conFuerza: fuerzaDeAtaque aOgro: unOgro conVida: vidaDeOgro 
	
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ItemDeAtaque class' category: #'2024-2C-Parcial-1'!
ItemDeAtaque class
	instanceVariableNames: ''!

!ItemDeAtaque class methodsFor: 'instance creation' stamp: 'MN 4/30/2025 16:38:32'!
nuevaEspadaPara: unMonstruo
	unMonstruo altura < (100 * centimeter) ifTrue: [
		self error: self noSePuedeAtacarAMonstruoMenorAUnMetroDeAlturaMensajeDeError
	].

	^ Espada new inicializarConMonstruoObjetivo: unMonstruo! !

!ItemDeAtaque class methodsFor: 'instance creation' stamp: 'MN 4/30/2025 16:34:46'!
nuevoBaculo
	^ Baculo new! !


!ItemDeAtaque class methodsFor: 'mensajes de error' stamp: 'MN 4/30/2025 16:36:35'!
noSePuedeAtacarAMonstruoMenorAUnMetroDeAlturaMensajeDeError

	^ 'No se puede atacar con Espada a monstruos de menos de 1m de altura'! !


!classDefinition: #Baculo category: #'2024-2C-Parcial-1'!
ItemDeAtaque subclass: #Baculo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!Baculo methodsFor: 'ataque' stamp: 'MN 4/30/2025 16:22:39'!
calcularDañoCuandoAtacaGuerrero: unGuerrero conFuerza: fuerzaDeAtaque aGoblin: unGoblin conVida: vidaDeGoblin

	| puntosDeDaño |

	puntosDeDaño := vidaDeGoblin * (-1). "Daño negativo = Sumar vida. Tiene sentido..."

	^ puntosDeDaño! !

!Baculo methodsFor: 'ataque' stamp: 'MN 4/30/2025 16:23:27'!
calcularDañoCuandoAtacaGuerrero: unGuerrero conFuerza: fuerzaDeAtaque aOgro: unOgro conVida: vidaDeOgro 

	| puntosDeDaño |

	puntosDeDaño := fuerzaDeAtaque.

	^ puntosDeDaño! !

!Baculo methodsFor: 'ataque' stamp: 'MN 4/30/2025 16:25:58'!
calcularDañoCuandoAtacaMago: unMago conFuerza: fuerzaDeAtaque aGoblin: unGoblin conVida: vidaDeGoblin 

	| puntosDeDaño |
	
	puntosDeDaño := vidaDeGoblin.

	^ puntosDeDaño! !

!Baculo methodsFor: 'ataque' stamp: 'MN 4/30/2025 16:24:20'!
calcularDañoCuandoAtacaMago: unMago conFuerza: fuerzaDeAtaque aOgro: unOgro conVida: vidaDeOgro 

	| puntosDeDaño |
	
	puntosDeDaño := fuerzaDeAtaque.

	^ puntosDeDaño! !


!classDefinition: #Espada category: #'2024-2C-Parcial-1'!
ItemDeAtaque subclass: #Espada
	instanceVariableNames: 'monstruoObjetivo'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!Espada methodsFor: 'acceso' stamp: 'MN 4/30/2025 15:51:35'!
monstruoObjetivo

	^ monstruoObjetivo ! !


!Espada methodsFor: 'ataque' stamp: 'MN 4/30/2025 16:48:36'!
calcularDañoCuandoAtacaGuerrero: unGuerrero conFuerza: fuerzaDeAtaque aGoblin: unGoblin

	| puntosDeDaño |

	puntosDeDaño := self
		si: unGoblin
		esMiObjetivoEntoncesElDañoEs: fuerzaDeAtaque
		siNoEs: 0.
	
	^ puntosDeDaño! !

!Espada methodsFor: 'ataque' stamp: 'MN 4/30/2025 16:48:45'!
calcularDañoCuandoAtacaGuerrero: unGuerrero conFuerza: fuerzaDeAtaque aOgro: unOgro conVida: vidaDeOgro 

	| puntosDeDaño |

	puntosDeDaño := self
		si: unOgro
		esMiObjetivoEntoncesElDañoEs: fuerzaDeAtaque
		siNoEs: 0.

	^ puntosDeDaño! !

!Espada methodsFor: 'ataque' stamp: 'MN 4/30/2025 16:51:59'!
calcularDañoCuandoAtacaMago: unMago conFuerza: fuerzaDeAtaque aGoblin: unGoblin conVida: vidaDeGoblin 

	^ self noInfligeDañoYPierdeTodaSuVida: unMago.! !

!Espada methodsFor: 'ataque' stamp: 'MN 4/30/2025 16:51:35'!
calcularDañoCuandoAtacaMago: unMago conFuerza: fuerzaDeAtaque aOgro: unOgro conVida: vidaDeOgro 

	^ self noInfligeDañoYPierdeTodaSuVida: unMago.! !

!Espada methodsFor: 'ataque' stamp: 'MN 4/30/2025 16:51:53'!
noInfligeDañoYPierdeTodaSuVida: unMago

	| puntosDeDaño |
	
	"Como Mago no puede atacar con Espada, a fines practicos, es como
	si intentara atacar, fallara en el intento e infligiera 0 de daño"
	
	unMago pierdeTodaSuVida.
	
	puntosDeDaño := 0.
	
	^ puntosDeDaño. ! !

!Espada methodsFor: 'ataque' stamp: 'MN 4/30/2025 16:47:44'!
si: unGoblin esMiObjetivoEntoncesElDañoEs: fuerzaDeAtaque siNoEs: otraFuerzaDeAtaque
	
	monstruoObjetivo == unGoblin ifTrue: [
		^ fuerzaDeAtaque.
	] ifFalse: [
		^ otraFuerzaDeAtaque.
	].
! !


!Espada methodsFor: 'inicializacion' stamp: 'MN 4/30/2025 16:34:39'!
inicializarConMonstruoObjetivo: unMonstruo

	monstruoObjetivo := unMonstruo.! !


!classDefinition: #ItemDeDefensa category: #'2024-2C-Parcial-1'!
Object subclass: #ItemDeDefensa
	instanceVariableNames: 'tipo proteccion'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!ItemDeDefensa methodsFor: 'inicializacion' stamp: 'MN 4/29/2025 21:12:59'!
inicializarArmadura
	tipo := #Armadura.
	proteccion := 5 * pv.! !

!ItemDeDefensa methodsFor: 'inicializacion' stamp: 'MN 4/29/2025 21:12:59'!
inicializarEscudoMagico
	tipo := #EscudoMagico.
	proteccion := 3 * pv.! !


!ItemDeDefensa methodsFor: 'acceso' stamp: 'MN 4/29/2025 20:23:20'!
proteccion
	^ proteccion ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ItemDeDefensa class' category: #'2024-2C-Parcial-1'!
ItemDeDefensa class
	instanceVariableNames: ''!

!ItemDeDefensa class methodsFor: 'instance creation' stamp: 'MN 4/29/2025 20:11:21'!
nuevaArmadura

	^ self new inicializarArmadura! !

!ItemDeDefensa class methodsFor: 'instance creation' stamp: 'MN 4/29/2025 20:10:59'!
nuevoEscudoMagico

	^ self new inicializarEscudoMagico! !


!classDefinition: #Monstruo category: #'2024-2C-Parcial-1'!
Object subclass: #Monstruo
	instanceVariableNames: 'PV'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!Monstruo methodsFor: 'inicializacion' stamp: 'MN 4/30/2025 15:47:05'!
inicializarConVida: unaCantidadDeVida

	PV := unaCantidadDeVida.
	! !


!Monstruo methodsFor: 'acceso' stamp: 'MN 4/30/2025 16:35:49'!
altura
	
	self subclassResponsibility ! !

!Monstruo methodsFor: 'acceso' stamp: 'MN 4/30/2025 15:38:51'!
tienePuntosDeVida: unPV

	^ PV = unPV! !


!Monstruo methodsFor: 'ataque' stamp: 'MN 4/30/2025 15:37:59'!
atacarA: unAventurero

	unAventurero esAtacadoPor: self conFuerza: PV! !


!Monstruo methodsFor: 'defensa' stamp: 'MN 4/30/2025 16:30:32'!
esAtacadoPorGuerrero: unGuerrero con: unItemDeAtaque yFuerza: fuerzaDeAtaque
	
	self subclassResponsibility ! !

!Monstruo methodsFor: 'defensa' stamp: 'MN 4/30/2025 16:30:38'!
esAtacadoPorMago: unMago con: unItemDeAtaque yFuerza: fuerzaDeAtaque
	
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Monstruo class' category: #'2024-2C-Parcial-1'!
Monstruo class
	instanceVariableNames: ''!

!Monstruo class methodsFor: 'instance creation' stamp: 'MN 4/30/2025 15:41:47'!
nuevoGoblin
	^ Goblin new inicializarConVida: 5 * pv ! !

!Monstruo class methodsFor: 'instance creation' stamp: 'MN 4/30/2025 15:40:37'!
nuevoOgro
	^ Ogro new inicializarConVida: 15 * pv ! !


!classDefinition: #Goblin category: #'2024-2C-Parcial-1'!
Monstruo subclass: #Goblin
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!Goblin methodsFor: 'defensa' stamp: 'MN 4/30/2025 16:28:42'!
esAtacadoPorGuerrero: unGuerrero con: unItemDeAtaque yFuerza: fuerzaDeAtaque
	
	| puntosDeDaño |
	
	puntosDeDaño := unItemDeAtaque
		calcularDañoCuandoAtacaGuerrero: unGuerrero
		conFuerza: fuerzaDeAtaque 
		aGoblin: self
		conVida: PV. 

	PV := PV - puntosDeDaño.! !

!Goblin methodsFor: 'defensa' stamp: 'MN 4/30/2025 16:27:42'!
esAtacadoPorMago: unMago con: unItemDeAtaque yFuerza: fuerzaDeAtaque
	
	| puntosDeDaño |
	
	puntosDeDaño := unItemDeAtaque
		calcularDañoCuandoAtacaMago: unMago
		conFuerza: fuerzaDeAtaque 
		aGoblin: self
		conVida: PV. 

	PV := PV - puntosDeDaño.! !


!Goblin methodsFor: 'acceso' stamp: 'MN 4/30/2025 15:42:05'!
altura

	^ 90 * centimeter! !


!classDefinition: #Ogro category: #'2024-2C-Parcial-1'!
Monstruo subclass: #Ogro
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!Ogro methodsFor: 'defensa' stamp: 'MN 4/30/2025 16:29:12'!
esAtacadoPorGuerrero: unGuerrero con: unItemDeAtaque yFuerza: fuerzaDeAtaque
	
	| puntosDeDaño |
	
	puntosDeDaño := unItemDeAtaque
		calcularDañoCuandoAtacaGuerrero: unGuerrero
		conFuerza: fuerzaDeAtaque 
		aOgro: self
		conVida: PV. 

	PV := PV - puntosDeDaño.! !

!Ogro methodsFor: 'defensa' stamp: 'MN 4/30/2025 16:29:37'!
esAtacadoPorMago: unMago con: unItemDeAtaque yFuerza: fuerzaDeAtaque
	
	| puntosDeDaño |
	
	puntosDeDaño := unItemDeAtaque
		calcularDañoCuandoAtacaMago: unMago
		conFuerza: fuerzaDeAtaque 
		aOgro: self
		conVida: PV.

	PV := PV - puntosDeDaño.! !


!Ogro methodsFor: 'acceso' stamp: 'MN 4/30/2025 15:38:39'!
altura

	^ 220 * centimeter! !

TestMyA initialize!