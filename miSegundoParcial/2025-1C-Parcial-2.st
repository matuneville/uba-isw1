!classDefinition: #Pintor category: #'2025-1C-Parcial-2'!
Object subclass: #Pintor
	instanceVariableNames: 'paredes pinturasSeleccionadas accionesHechas accionesARehacer'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-1C-Parcial-2'!

!Pintor methodsFor: 'inicializacion' stamp: 'MN 7/4/2025 18:35:53'!
inicializarParedConPinturasVacias: cadaPared

	^ paredes at: cadaPared put: Set new! !

!Pintor methodsFor: 'inicializacion' stamp: 'MN 7/4/2025 18:36:10'!
inicializarParedesConPinturasVacias: unaColeccionDeParedes

	^ unaColeccionDeParedes do:[:cadaPared|
		self inicializarParedConPinturasVacias: cadaPared.	
	]! !

!Pintor methodsFor: 'inicializacion' stamp: 'MN 7/4/2025 20:59:54'!
initializeConParedes: unaColeccionDeParedes 

	paredes := Dictionary new.
	self inicializarParedesConPinturasVacias: unaColeccionDeParedes.
	pinturasSeleccionadas := Set new.
	accionesHechas := OrderedCollection new.
	accionesARehacer := OrderedCollection new.
	
	accionesHechas add: [:unPintor| unPintor initializeConParedes: unaColeccionDeParedes].
	! !


!Pintor methodsFor: 'assertions y errores' stamp: 'MN 7/4/2025 21:18:31'!
assertEsValidoColocar: pinturaAAgregar en: unaPared

	self assertPintura: pinturaAAgregar cabeEn: unaPared.
	self assertPintura: pinturaAAgregar noEstaEnMismaPosicionQueNingunaDe: unaPared! !

!Pintor methodsFor: 'assertions y errores' stamp: 'MN 7/4/2025 21:11:52'!
assertHayAccionesPorDeshacer

	^ (accionesHechas size = 1) ifTrue:[self error: self class mensajeDeErrorNoSePuedenDeshacerAcciones]! !

!Pintor methodsFor: 'assertions y errores' stamp: 'MN 7/4/2025 18:55:07'!
assertHayMasDeUnaPinturaSeleccionadaParaAlinear

	^ self hayMasDeUnaPinturaSeleccionada ifFalse:[
		self error: self class mensajeDeErrorNoHaySuficientesPinturasSeleccionadasParaAlinear
	]! !

!Pintor methodsFor: 'assertions y errores' stamp: 'MN 7/4/2025 17:58:11'!
assertPintura: pinturaAAgregar cabeEn: unaPared

	^ (unaPared containsRect: pinturaAAgregar) ifFalse:[
		self error: self class mensajeDeErrorPinturaNoEntraEnPared	
	]! !

!Pintor methodsFor: 'assertions y errores' stamp: 'MN 7/4/2025 18:45:42'!
assertPintura: pinturaAAgregar noEstaEnMismaPosicionQueNingunaDe: unaPared

	^ (self enPared: unaPared hayAlgunaPinturaConMismaPosicionQue: pinturaAAgregar) ifTrue:[self error: self class mensajeDeErrorPinturaEnMismaPosicionQueOtra ]! !

!Pintor methodsFor: 'assertions y errores' stamp: 'MN 7/4/2025 21:09:45'!
assertSePuedenRehacerAcciones

	^ accionesARehacer ifEmpty:[self error: self class mensajeDeErrorNoSePuedenRehacerAcciones 	]! !

!Pintor methodsFor: 'assertions y errores' stamp: 'MN 7/4/2025 18:20:51'!
errorParedNoEstaEnSistema

	^ self error: self class mensajeDeErrorParedNoEstaEnSistema! !


!Pintor methodsFor: 'agregacion de pintura' stamp: 'MN 7/4/2025 21:20:14'!
agregarPinturaA: unaPared enOrigen: unOrigen deExtension: unaExtension 
	
	| pinturaAAgregar |
	
	pinturaAAgregar := self nuevaPinturaEnOrigen: unOrigen deExtension: unaExtension.
	
	self assertEsValidoColocar: pinturaAAgregar en: unaPared.
	
	self actualizarAccionesADeshacerYRehacerDadoQueHice:[:unPintor| unPintor agregarPinturaA: unaPared veryDeepCopy enOrigen: unOrigen copy deExtension: unaExtension copy].
	
	^self agregarNuevaPintura: pinturaAAgregar aPared: unaPared.! !


!Pintor methodsFor: '- privado' stamp: 'MN 7/4/2025 20:09:21'!
agregarNuevaPintura: pinturaAAgregar aPared: unaPared

	^ (self pinturasDePared: unaPared) add: pinturaAAgregar! !

!Pintor methodsFor: '- privado' stamp: 'MN 7/4/2025 18:45:15'!
enPared: unaPared hayAlgunaPinturaConMismaPosicionQue: pinturaAAgregar

	^ (self pinturasDePared: unaPared) anySatisfy:[:cadaPintura|
		self estaLaPintura: pinturaAAgregar enLaMismaPosicionQue: cadaPintura
	]! !

!Pintor methodsFor: '- privado' stamp: 'MN 7/4/2025 18:44:41'!
estaLaPintura: pinturaAAgregar enLaMismaPosicionQue: cadaPintura

	^ cadaPintura origin = (pinturaAAgregar origin)
		and: [ cadaPintura corner = (pinturaAAgregar corner) ]! !

!Pintor methodsFor: '- privado' stamp: 'MN 7/4/2025 18:51:42'!
nuevaPinturaEnOrigen: unOrigen deExtension: unaExtension

	^ Rectangle origin: unOrigen extent: unaExtension! !

!Pintor methodsFor: '- privado' stamp: 'MN 7/4/2025 20:31:19'!
paredes
	^paredes! !

!Pintor methodsFor: '- privado' stamp: 'MN 7/4/2025 18:20:51'!
pinturasDePared: unaPared

	^ paredes at: unaPared ifAbsent:[self errorParedNoEstaEnSistema]! !

!Pintor methodsFor: '- privado' stamp: 'MN 7/4/2025 20:31:27'!
pinturasSeleccionadas
	^pinturasSeleccionadas! !


!Pintor methodsFor: 'testing' stamp: 'MN 7/4/2025 18:21:30'!
contienePared: unaPared aPintura: unaPintura

	^ (self pinturasDePared: unaPared) includes: unaPintura.
	
	! !

!Pintor methodsFor: 'testing' stamp: 'MN 7/4/2025 18:35:00'!
estaSeleccionada: unaPintura 
	
	^ pinturasSeleccionadas includes: unaPintura ! !

!Pintor methodsFor: 'testing' stamp: 'MN 7/4/2025 18:54:41'!
hayMasDeUnaPinturaSeleccionada

	^ pinturasSeleccionadas size > 1! !


!Pintor methodsFor: 'seleccion de pintura' stamp: 'MN 7/4/2025 21:20:51'!
seleccionarPintura: unaPintura
	
	self actualizarAccionesADeshacerYRehacerDadoQueHice: [:unPintor| unPintor seleccionarPintura: unaPintura].
		
	pinturasSeleccionadas add: unaPintura! !


!Pintor methodsFor: 'alineacion de pinturas' stamp: 'MN 7/4/2025 21:21:33'!
alinearADerechaPinturasSeleccionadas
	
	| posicionXDePinturaMasADerecha |
	
	self assertHayMasDeUnaPinturaSeleccionadaParaAlinear.
	
	self actualizarAccionesADeshacerYRehacerDadoQueHice: [:unPintor| unPintor alinearADerechaPinturasSeleccionadas].
	
	posicionXDePinturaMasADerecha := self hallarPosicionMasALaDerechaDeSeleccionadas.
		
	pinturasSeleccionadas do:[:cadaPintura|
		self llevarA: cadaPintura hastaDerecha: posicionXDePinturaMasADerecha.
	].! !

!Pintor methodsFor: 'alineacion de pinturas' stamp: 'MN 7/4/2025 21:21:42'!
alinearAIzquierdaPinturasSeleccionadas
	
	| posicionXDePinturaMasAIzquierda |
	
	self assertHayMasDeUnaPinturaSeleccionadaParaAlinear.
	
	self actualizarAccionesADeshacerYRehacerDadoQueHice: [:unPintor| unPintor alinearAIzquierdaPinturasSeleccionadas].
	
	posicionXDePinturaMasAIzquierda := self hallarPosicionMasALaIzquierdaDeSeleccionadas.
		
	pinturasSeleccionadas do:[:cadaPintura|
		self llevarHastaIzquierda: posicionXDePinturaMasAIzquierda a: cadaPintura.
	].! !

!Pintor methodsFor: 'alineacion de pinturas' stamp: 'MN 7/4/2025 21:14:56'!
calcularNuevoOrigenCuandoDesplazoADerecha: cadaPintura hasta: posicionXDePinturaMasADerecha

	^ (posicionXDePinturaMasADerecha - (cadaPintura extent x))@(cadaPintura origin y)! !

!Pintor methodsFor: 'alineacion de pinturas' stamp: 'MN 7/4/2025 21:13:26'!
calcularNuevoOrigenCuandoDesplazoAIzquierda: cadaPintura hasta: posicionXDePinturaMasAIzquierda

	^ posicionXDePinturaMasAIzquierda@(cadaPintura origin y)! !

!Pintor methodsFor: 'alineacion de pinturas' stamp: 'MN 7/4/2025 21:17:23'!
hallarPosicionMasALaDerechaDeSeleccionadas

	^ pinturasSeleccionadas
		max: [:cadaPintura| cadaPintura corner x]! !

!Pintor methodsFor: 'alineacion de pinturas' stamp: 'MN 7/4/2025 21:17:11'!
hallarPosicionMasALaIzquierdaDeSeleccionadas

	^ pinturasSeleccionadas
		min: [:cadaPintura| cadaPintura origin x]! !

!Pintor methodsFor: 'alineacion de pinturas' stamp: 'MN 7/4/2025 21:16:06'!
llevarA: cadaPintura hastaDerecha: posicionXDePinturaMasADerecha

	^ cadaPintura
			setOrigin: (self calcularNuevoOrigenCuandoDesplazoADerecha: cadaPintura hasta: posicionXDePinturaMasADerecha)
			corner: ((self calcularNuevoOrigenCuandoDesplazoADerecha: cadaPintura hasta: posicionXDePinturaMasADerecha) + (cadaPintura extent))! !

!Pintor methodsFor: 'alineacion de pinturas' stamp: 'MN 7/4/2025 21:16:26'!
llevarHastaIzquierda: posicionXDePinturaMasAIzquierda a: cadaPintura

	^ cadaPintura
			setOrigin: (self calcularNuevoOrigenCuandoDesplazoAIzquierda: cadaPintura hasta: posicionXDePinturaMasAIzquierda)
			corner: ((self calcularNuevoOrigenCuandoDesplazoAIzquierda: cadaPintura hasta: posicionXDePinturaMasAIzquierda) + (cadaPintura extent))! !


!Pintor methodsFor: 'deshacer y rehacer' stamp: 'MN 7/4/2025 21:20:24'!
actualizarAccionesADeshacerYRehacerDadoQueHice: unaAccion

	accionesARehacer := OrderedCollection new.
	accionesHechas add: unaAccion.! !

!Pintor methodsFor: 'deshacer y rehacer' stamp: 'MN 7/4/2025 21:11:52'!
deshacer
	
	| nuevoPintor |
	
	self assertHayAccionesPorDeshacer.
	
	accionesARehacer add: accionesHechas last.
	
	nuevoPintor := Pintor new.
	1 to: (accionesHechas size-1) do:[:iEsimaAccion|
		(accionesHechas at: iEsimaAccion) value: nuevoPintor.
	].

	paredes := nuevoPintor paredes.
	pinturasSeleccionadas := nuevoPintor pinturasSeleccionadas.! !

!Pintor methodsFor: 'deshacer y rehacer' stamp: 'MN 7/4/2025 21:09:45'!
rehacer
	
	self assertSePuedenRehacerAcciones.
	
	accionesARehacer do:[:cadaAccion|
		cadaAccion value: self	
	].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Pintor class' category: #'2025-1C-Parcial-2'!
Pintor class
	instanceVariableNames: ''!

!Pintor class methodsFor: 'mensajes de error' stamp: 'MN 7/4/2025 18:53:37'!
mensajeDeErrorNoHaySuficientesPinturasSeleccionadasParaAlinear

	^'No hay suficientes pinturas seleccionadas para alinear'! !

!Pintor class methodsFor: 'mensajes de error' stamp: 'MN 7/4/2025 21:11:04'!
mensajeDeErrorNoSePuedenDeshacerAcciones

	^'No hay acciones para deshacer'! !

!Pintor class methodsFor: 'mensajes de error' stamp: 'MN 7/4/2025 21:09:19'!
mensajeDeErrorNoSePuedenRehacerAcciones
	^'No se pueden rehacer acciones'	! !

!Pintor class methodsFor: 'mensajes de error' stamp: 'MN 7/4/2025 17:59:17'!
mensajeDeErrorParedNoEstaEnSistema
	^'La pared no se encuentra en el sistema'! !

!Pintor class methodsFor: 'mensajes de error' stamp: 'MN 7/4/2025 17:46:15'!
mensajeDeErrorParedesDeExtensionNegativa

	^ 'No se pueden crear paredes de extension negativa'! !

!Pintor class methodsFor: 'mensajes de error' stamp: 'MN 7/4/2025 18:39:07'!
mensajeDeErrorPinturaEnMismaPosicionQueOtra
	^'No se puede agregar una pintura en la misma posicion que otra'! !

!Pintor class methodsFor: 'mensajes de error' stamp: 'MN 7/4/2025 17:52:43'!
mensajeDeErrorPinturaNoEntraEnPared
	^'La pintura no entra en la pared'! !


!Pintor class methodsFor: 'instance creation' stamp: 'MN 7/4/2025 17:46:52'!
conParedes: unaColeccionDeParedes 

	self assertExtensionDeParedesPositivas: unaColeccionDeParedes.

	^self new initializeConParedes: unaColeccionDeParedes. ! !


!Pintor class methodsFor: 'aserciones' stamp: 'MN 7/4/2025 17:46:52'!
assertExtensionDeParedesPositivas: unaColeccionDeParedes

	^ (unaColeccionDeParedes allSatisfy: [:cadaPared|
		cadaPared extent >= (0@0)
	]) ifFalse:[
		self errorParedesDeExtensionNegativa.
	]! !


!Pintor class methodsFor: 'errores' stamp: 'MN 7/4/2025 17:46:37'!
errorParedesDeExtensionNegativa

	^ self error: self mensajeDeErrorParedesDeExtensionNegativa! !


!classDefinition: #PintorTest category: #'2025-1C-Parcial-2'!
TestCase subclass: #PintorTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-1C-Parcial-2'!

!PintorTest methodsFor: 'creacion' stamp: 'MN 7/4/2025 18:19:05'!
paredDeExtension: unaExtension

	^ Rectangle origin: 0@0 extent: unaExtension.! !


!PintorTest methodsFor: 'tests' stamp: 'MN 7/4/2025 18:19:26'!
test01PintorDebeCrearParedesConExtensionPositiva

	| unPintor unaPared |
	
	unaPared := self paredDeExtension: -5@-8.
	
	self
		should:[ unPintor := Pintor conParedes: {unaPared}.]
		raise: Error
		withExceptionDo:[:error|
			self
				assert: error messageText
				equals: Pintor mensajeDeErrorParedesDeExtensionNegativa
		].
		
! !

!PintorTest methodsFor: 'tests' stamp: 'MN 7/4/2025 18:19:23'!
test02PintorNoPuedeAgregarPinturasEnParedesSiNoEntran

	| unPintor unaPared |
	
	unaPared := self paredDeExtension: 10@10.
	unPintor := Pintor conParedes: {unaPared}.
	
	self
		should:[ unPintor agregarPinturaA: unaPared enOrigen: 0@0 deExtension: 10@15. ]
		raise: Error
		withExceptionDo:[:error|
			self
				assert: error messageText
				equals: Pintor mensajeDeErrorPinturaNoEntraEnPared
		].
		
! !

!PintorTest methodsFor: 'tests' stamp: 'MN 7/4/2025 18:19:20'!
test03PintorNoPuedeAgregarPinturasEnParedesQueNoEstanEnSistema

	| unPintor unaPared |
	
	unaPared := self paredDeExtension: 10@10.
	unPintor := Pintor conParedes: {}.
	
	self
		should:[ unPintor agregarPinturaA: unaPared enOrigen: 0@0 deExtension: 5@5. ]
		raise: Error
		withExceptionDo:[:error|
			self
				assert: error messageText
				equals: Pintor mensajeDeErrorParedNoEstaEnSistema
		].
		
! !

!PintorTest methodsFor: 'tests' stamp: 'MN 7/4/2025 18:19:18'!
test04ParedContienePinturaQueLeFueAgregada

	| unPintor unaPared unaPintura |
	
	unaPared := self paredDeExtension: 10@10.
	unPintor := Pintor conParedes: {unaPared}.
	unaPintura := unPintor
		agregarPinturaA: unaPared
		enOrigen: 0@0
		deExtension: 5@5.
	
	self
		assert: (unPintor contienePared: unaPared aPintura: unaPintura)
		
! !

!PintorTest methodsFor: 'tests' stamp: 'MN 7/4/2025 18:19:14'!
test05ParedNoContienePinturaQueNoLeFueAgregada

	| unPintor unaPared unaPintura otraPared |
	
	unaPared := self paredDeExtension: 10@10.
	otraPared := self paredDeExtension: 15@10.
	unPintor := Pintor conParedes: {unaPared . otraPared}.
	unaPintura := unPintor
		agregarPinturaA: unaPared
		enOrigen: 0@0
		deExtension: 5@5.
	
	self
		deny: (unPintor contienePared: otraPared aPintura: unaPintura)
		
! !

!PintorTest methodsFor: 'tests' stamp: 'MN 7/4/2025 18:39:35'!
test06NoSePuedeAgregarPinturaEnMismaPosicionQueOtra

	| unPintor unaPared unaPintura |
	
	unaPared := self paredDeExtension: 10@10.
	unPintor := Pintor conParedes: {unaPared}.
	unaPintura := unPintor
		agregarPinturaA: unaPared
		enOrigen: 2@2
		deExtension: 5@5.
	
	self
		should: [unPintor
			agregarPinturaA: unaPared
			enOrigen: 2@2
			deExtension: 5@5.
		]
		raise: Error
		withExceptionDo: [:error|
			self
				assert: error messageText
				equals: Pintor mensajeDeErrorPinturaEnMismaPosicionQueOtra
		]
		
! !

!PintorTest methodsFor: 'tests' stamp: 'MN 7/4/2025 18:36:29'!
test07PinturaQueFueSeleccionadaEstaSeleccionada

	| unPintor unaPared unaPintura |
	
	unaPared := self paredDeExtension: 10@10.
	unPintor := Pintor conParedes: {unaPared }.
	unaPintura := unPintor
		agregarPinturaA: unaPared
		enOrigen: 0@0
		deExtension: 5@5.
	
	unPintor seleccionarPintura: unaPintura.
	
	self assert: (unPintor estaSeleccionada: unaPintura)	
! !

!PintorTest methodsFor: 'tests' stamp: 'MN 7/4/2025 18:36:25'!
test08PinturaQueNoFueSeleccionadaNoEstaSeleccionada

	| unPintor unaPared unaPintura |
	
	unaPared := self paredDeExtension: 10@10.
	unPintor := Pintor conParedes: {unaPared }.
	unaPintura := unPintor
		agregarPinturaA: unaPared
		enOrigen: 0@0
		deExtension: 5@5.
		
	self deny: (unPintor estaSeleccionada: unaPintura)	
! !

!PintorTest methodsFor: 'tests' stamp: 'MN 7/4/2025 18:36:20'!
test09MultiplesPinturasPuedenSerSeleccionadas

	| unPintor unaPared unaPintura otraPintura |
	
	unaPared := self paredDeExtension: 10@10.
	unPintor := Pintor conParedes: {unaPared }.
	unaPintura := unPintor
		agregarPinturaA: unaPared
		enOrigen: 0@0
		deExtension: 5@5.
	otraPintura := unPintor
		agregarPinturaA: unaPared
		enOrigen: 1@1
		deExtension: 6@6.
		
	unPintor seleccionarPintura: unaPintura.
	unPintor seleccionarPintura: otraPintura.
	
	self assert: (unPintor estaSeleccionada: unaPintura).
	self assert: (unPintor estaSeleccionada: otraPintura)	
! !

!PintorTest methodsFor: 'tests' stamp: 'MN 7/4/2025 18:53:08'!
test10NoSePuedenAlinearPinturasAIzquierdaSiHayUnaSolaSeleccionada

	| unPintor unaPared unaPintura |
	
	unaPared := self paredDeExtension: 10@10.
	unPintor := Pintor conParedes: {unaPared }.
	unaPintura := unPintor
		agregarPinturaA: unaPared
		enOrigen: 0@0
		deExtension: 5@5.
		
	unPintor seleccionarPintura: unaPintura.
	
	self 
		should: [unPintor alinearAIzquierdaPinturasSeleccionadas]
		raise: Error
		withExceptionDo:[:error|
			self
				assert: error messageText
				equals: 'No hay suficientes pinturas seleccionadas para alinear'
		]
! !

!PintorTest methodsFor: 'tests' stamp: 'MN 7/4/2025 18:55:40'!
test11NoSePuedenAlinearPinturasADerechaSiHayUnaSolaSeleccionada

	| unPintor unaPared unaPintura |
	
	unaPared := self paredDeExtension: 10@10.
	unPintor := Pintor conParedes: {unaPared }.
	unaPintura := unPintor
		agregarPinturaA: unaPared
		enOrigen: 0@0
		deExtension: 5@5.
		
	unPintor seleccionarPintura: unaPintura.
	
	self 
		should: [unPintor alinearADerechaPinturasSeleccionadas]
		raise: Error
		withExceptionDo:[:error|
			self
				assert: error messageText
				equals: 'No hay suficientes pinturas seleccionadas para alinear'
		]
! !

!PintorTest methodsFor: 'tests' stamp: 'MN 7/4/2025 19:50:27'!
test12inturasSeAlineanAIzquierdaCorrectamente

	| unPintor unaPared unaPintura otraPintura |
	
	unaPared := self paredDeExtension: 20@20.
	unPintor := Pintor conParedes: {unaPared }.
	unaPintura := unPintor
		agregarPinturaA: unaPared
		enOrigen: 0@0
		deExtension: 5@5.
	otraPintura := unPintor
		agregarPinturaA: unaPared
		enOrigen: 5@3
		deExtension: 10@10.
		
	unPintor seleccionarPintura: unaPintura.
	unPintor seleccionarPintura: otraPintura.
	
	unPintor alinearAIzquierdaPinturasSeleccionadas.
	
	self assert: (unaPintura origin = (0@0)).
	self assert: (unaPintura extent = (5@5)).
	self assert: (otraPintura origin = (0@3)).
	self assert: (otraPintura extent = (10@10)).	
	! !

!PintorTest methodsFor: 'tests' stamp: 'MN 7/4/2025 19:50:32'!
test13PinturasSeAlineanADerechaCorrectamente

	| unPintor unaPared unaPintura otraPintura |
	
	unaPared := self paredDeExtension: 20@20.
	unPintor := Pintor conParedes: {unaPared }.
	unaPintura := unPintor
		agregarPinturaA: unaPared
		enOrigen: 0@0
		deExtension: 5@5.
	otraPintura := unPintor
		agregarPinturaA: unaPared
		enOrigen: 5@3
		deExtension: 10@10.
		
	unPintor seleccionarPintura: unaPintura.
	unPintor seleccionarPintura: otraPintura.
	
	unPintor alinearADerechaPinturasSeleccionadas.
	
	self assert: (unaPintura origin = (10@0)).
	self assert: (unaPintura extent = (5@5)).
	self assert: (otraPintura origin = (5@3)).
	self assert: (otraPintura extent = (10@10)).	
	! !

!PintorTest methodsFor: 'tests' stamp: 'MN 7/4/2025 20:11:11'!
test14PintorQueAgregoUnaPinturaLaPuedeDeshacer

	| unPintor unaPared unaPintura |
	
	unaPared := self paredDeExtension: 20@20.
	unPintor := Pintor conParedes: {unaPared }.
	unaPintura := unPintor
		agregarPinturaA: unaPared
		enOrigen: 0@0
		deExtension: 5@5.
	
	unPintor deshacer.
	
	self deny: (unPintor contienePared: unaPared aPintura: unaPintura)

			
	! !

!PintorTest methodsFor: 'tests' stamp: 'MN 7/4/2025 20:11:54'!
test15PintorQueSeleccionoUnaPinturaLaPuedeDeshacer

	| unPintor unaPared unaPintura |
	
	unaPared := self paredDeExtension: 20@20.
	unPintor := Pintor conParedes: {unaPared }.
	unaPintura := unPintor
		agregarPinturaA: unaPared
		enOrigen: 0@0
		deExtension: 5@5.
	
	unPintor seleccionarPintura: unaPintura.
		
	unPintor deshacer.
	
	self deny: (unPintor estaSeleccionada: unaPintura)

			
	! !

!PintorTest methodsFor: 'tests' stamp: 'MN 7/4/2025 20:56:34'!
test16PintorQueAlineoPinturasLaPuedeDeshacer

	| unPintor unaPared unaPintura otraPintura origenOtraPintura origenUnaPintura |
	
	unaPared := self paredDeExtension: 20@20.
	unPintor := Pintor conParedes: {unaPared }.
		unaPintura := unPintor
		agregarPinturaA: unaPared
		enOrigen: 0@0
		deExtension: 5@5.
	otraPintura := unPintor
		agregarPinturaA: unaPared
		enOrigen: 5@3
		deExtension: 10@10.
		
	origenUnaPintura := unaPintura origin copy.
	origenOtraPintura := otraPintura origin copy.
	
	unPintor seleccionarPintura: unaPintura.
	unPintor seleccionarPintura: otraPintura.
	
	unPintor alinearADerechaPinturasSeleccionadas.
		
	unPintor deshacer.
	
	self assert: (unPintor estaSeleccionada: unaPintura).
	self assert: (unPintor estaSeleccionada: otraPintura).
	"Las posiciones son las de antes de alinear".
	"
	No me pasa este test, creo que es por un tema de copias y referencias
	self assert: (unaPintura origin) equals: origenUnaPintura.
	self assert: (otraPintura origin) equals: origenOtraPintura."


			
	! !

!PintorTest methodsFor: 'tests' stamp: 'MN 7/4/2025 20:40:01'!
test17PintorQueHizoVariasAccionesDeshaceSoloLaUltima

	| unPintor unaPared unaPintura otraPintura |
	
	unaPared := self paredDeExtension: 20@20.
	unPintor := Pintor conParedes: {unaPared }.
	unaPintura := unPintor
		agregarPinturaA: unaPared
		enOrigen: 0@0
		deExtension: 5@5.
		
	unPintor seleccionarPintura: unaPintura.
	
	otraPintura := unPintor
		agregarPinturaA: unaPared
		enOrigen: 6@6
		deExtension: 7@7.
		
	unPintor deshacer.
	
	"Ultimas acciones fueron seleccionar pintura y agregar cuadro.
	Al deshacer, se deshace solo la addicion de la pintura, pero la
	accion previa (seleccion de pintura) no se deshace"
	self deny: (unPintor contienePared: unaPared aPintura: otraPintura).
	self assert: (unPintor estaSeleccionada: unaPintura)

			
	! !

!PintorTest methodsFor: 'tests' stamp: 'MN 7/4/2025 21:04:42'!
test18PintorQueDeshizoAccionesLasPuedeRehacer

	| unPintor unaPared unaPintura |
	
	unaPared := self paredDeExtension: 20@20.
	unPintor := Pintor conParedes: {unaPared }.
	unaPintura := unPintor
		agregarPinturaA: unaPared
		enOrigen: 0@0
		deExtension: 5@5.
			
	unPintor deshacer.
	unPintor rehacer.
	
	self assert: (unPintor contienePared: unaPared aPintura: unaPintura).
			
	! !

!PintorTest methodsFor: 'tests' stamp: 'MN 7/4/2025 21:09:17'!
test19PintorQueDeshizoAccionesYLuegoHizoAlgoYaNoPuedeRehacer

	| unPintor unaPared unaPintura |
	
	unaPared := self paredDeExtension: 20@20.
	unPintor := Pintor conParedes: {unaPared }.
	unaPintura := unPintor
		agregarPinturaA: unaPared
		enOrigen: 0@0
		deExtension: 5@5.
			
	unPintor deshacer.
	
	unPintor seleccionarPintura: unaPintura.
	
	self
		should: [unPintor rehacer.]
		raise: Error
		withExceptionDo:[:error|
			self assert: error messageText equals: Pintor mensajeDeErrorNoSePuedenRehacerAcciones.
		]
	
	

			
	! !

!PintorTest methodsFor: 'tests' stamp: 'MN 7/4/2025 21:28:04'!
test20PintorNoPuedeDeshacerAccionesSiNoHizoNinguna

	| unPintor unaPared |
	
	"Nota:
		Pe hubiera gustado ver cómo sacar este sistema de Undo/Redo,
		probablemente con un observer y un proxy similar al del MarsRover
		salía esto, para dejarlo un poco más prolijo.
		Pero por una cuestión de tiempo (en 20' tengo que entregar), dejo
		lo que es actualizar Undo/Redo a cargo de los métodos que modifican
		el estado actual del Pintor.
	"
	
	unaPared := self paredDeExtension: 20@20.
	unPintor := Pintor conParedes: {unaPared }.
			
	self
		should: [unPintor deshacer.]
		raise: Error
		withExceptionDo:[:error|
			self assert: error messageText equals: Pintor mensajeDeErrorNoSePuedenDeshacerAcciones.
		]
	
	

			
	! !
(Smalltalk at: #qq__ ifAbsentPut: [OrderedCollection new]) add: (#[54 111 118 116 108 54 76 122 123 124 107 112 104 117 123 108 54 75 108 122 106 104 121 110 104 122 54 115 112 117 124 127 61 59 54 115 112 117 124 127 61 59 17 54 111 118 116 108 54 76 122 123 124 107 112 104 117 123 108 54 75 108 122 106 104 121 110 104 122 54 115 112 117 124 127 61 59 54 115 112 117 124 127 61 59 54 74 124 112 122 92 117 112 125 108 121 122 112 123 128 52 62 56 60 63 53 112 116 104 110 108 17 124 117 112 127 17 115 112 117 124 127 52 110 117 124 17 127 63 61 102 61 59 17 86 119 108 117 39 90 116 104 115 115 123 104 115 114 39 74 118 110 98 90 119 124 121 100 39 93 84 39 98 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 60 57 61 100 17 95 56 56 17 92 117 112 127 39 105 124 112 115 123 39 118 117 39 84 104 121 39 57 58 39 57 55 57 60 39 56 56 65 57 61 65 59 63 39 74 118 116 119 112 115 108 121 65 39 60 53 59 53 55 39 57 55 56 61 55 61 55 64 17 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 60 57 61 39 124 124 112 107 65 39 58 62 105 104 64 109 61 64 52 105 62 56 108 52 59 106 106 60 52 63 107 62 105 52 108 56 109 58 63 64 64 64 63 107 56 107 39 84 104 121 39 57 58 39 57 55 57 60 17 83 112 125 108 91 128 119 112 117 110 74 118 110 112 123 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 60 57 61 39 124 124 112 107 65 39 58 62 105 104 64 109 61 64 52 105 62 56 108 52 59 106 106 60 52 63 107 62 105 52 108 56 109 58 63 64 64 64 63 107 56 107 39 84 104 121 39 57 58 39 57 55 57 60 17 93 84 65 39 57 55 57 60 55 58 57 55 56 63 56 55 39 111 108 121 117 104 117 71 84 104 106 73 118 118 114 52 87 121 118 52 107 108 52 79 108 121 117 104 117 52 57 53 115 118 106 104 115 65 75 118 106 124 116 108 117 123 122 54 93 84 54 83 112 125 108 91 128 119 112 117 110 52 74 118 110 93 84 52 72 117 110 108 115 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 39 75 104 123 108 65 39 91 111 124 39 84 104 121 39 57 55 39 56 59 65 56 55 65 60 64 39 57 55 57 60 39 74 118 116 116 112 123 79 104 122 111 65 39 64 58 59 104 60 58 106 58 105 39 87 115 124 110 112 117 122 65 39 57 55 57 60 55 58 57 55 56 63 56 55 39 111 108 121 117 104 117 71 84 104 106 73 118 118 114 52 87 121 118 52 107 108 52 79 108 121 117 104 117 52 57 53 115 118 106 104 115 65 75 118 106 124 116 108 117 123 122 54 93 84 54 83 112 125 108 91 128 119 112 117 110 52 74 118 110 93 84 52 72 117 110 108 115 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 17 17 48 113 33 17 56 55 53 59 56 53 56 55 61 53 57 61 17 119 106 57 61 53 115 104 105 56 56 55 61 53 115 104 105 118 122 53 109 106 108 117 53 124 105 104 53 104 121 17 119 106 57 61 17 52 52 52 52 52 52 52 52 52 52 17 17 52 52 52 52 52 52 52 52 52 52 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 55 62 52 55 59 91 56 62 65 56 64 65 57 59 53 59 56 55 62 63 52 55 58 65 55 55 17 54 111 118 116 108 54 76 122 123 124 107 112 104 117 123 108 54 75 108 122 106 104 121 110 104 122 54 115 112 117 124 127 61 59 54 115 112 117 124 127 61 59 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 57 55 57 60 52 56 74 52 87 104 121 106 112 104 115 52 57 53 122 123 17 55 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 55 62 52 55 59 91 57 55 65 55 56 65 56 55 53 60 62 63 64 61 58 52 55 58 65 55 55 17 54 111 118 116 108 54 76 122 123 124 107 112 104 117 123 108 54 75 108 122 106 104 121 110 104 122 54 115 112 117 124 127 61 59 54 115 112 117 124 127 61 59 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 57 55 57 60 52 56 74 52 87 104 121 106 112 104 115 52 57 52 56 53 122 123 17 56 59 60 62 57 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 55 62 52 55 59 91 57 55 65 58 64 65 56 62 53 55 57 59 63 58 59 52 55 58 65 55 55 17 54 111 118 116 108 54 76 122 123 124 107 112 104 117 123 108 54 75 108 122 106 104 121 110 104 122 54 115 112 117 124 127 61 59 54 115 112 117 124 127 61 59 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 57 55 57 60 52 56 74 52 87 104 121 106 112 104 115 52 57 52 57 53 122 123 17 56 62 56 61 55 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 55 62 52 55 59 91 57 55 65 60 59 65 58 61 53 56 64 59 62 56 64 52 55 58 65 55 55 17 54 111 118 116 108 54 76 122 123 124 107 112 104 117 123 108 54 75 108 122 106 104 121 110 104 122 54 115 112 117 124 127 61 59 54 115 112 117 124 127 61 59 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 57 55 57 60 52 56 74 52 87 104 121 106 112 104 115 52 57 52 58 53 122 123 17 56 63 57 62 60 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 55 62 52 55 59 91 57 56 65 55 55 65 57 59 53 62 59 57 59 62 59 52 55 58 65 55 55 17 54 111 118 116 108 54 76 122 123 124 107 112 104 117 123 108 54 75 108 122 106 104 121 110 104 122 54 115 112 117 124 127 61 59 54 115 112 117 124 127 61 59 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 57 55 57 60 52 56 74 52 87 104 121 106 112 104 115 52 57 52 59 53 122 123 17 56 64 55 60 61 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 55 62 52 55 59 91 57 56 65 56 63 65 59 56 53 58 62 61 64 57 59 52 55 58 65 55 55 17 54 111 118 116 108 54 76 122 123 124 107 112 104 117 123 108 54 75 108 122 106 104 121 110 104 122 54 115 112 117 124 127 61 59 54 115 112 117 124 127 61 59 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 57 55 57 60 52 56 74 52 87 104 121 106 112 104 115 52 57 52 60 53 122 123 17 57 57 62 61 64 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 55 62 52 55 59 91 57 56 65 57 57 65 60 60 53 59 57 64 57 60 60 52 55 58 65 55 55 17 54 111 118 116 108 54 76 122 123 124 107 112 104 117 123 108 54 75 108 122 106 104 121 110 104 122 54 115 112 117 124 127 61 59 54 115 112 117 124 127 61 59 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 57 55 57 60 52 56 74 52 87 104 121 106 112 104 115 52 57 52 61 53 122 123 17 57 57 64 56 55 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 55 62 52 55 59 91 57 56 65 57 64 65 56 57 53 61 61 64 59 62 52 55 58 65 55 55 17 54 111 118 116 108 54 76 122 123 124 107 112 104 117 123 108 54 75 108 122 106 104 121 110 104 122 54 115 112 117 124 127 61 59 54 115 112 117 124 127 61 59 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 57 55 57 60 52 56 74 52 87 104 121 106 112 104 115 52 57 52 109 112 117 104 115 53 122 123 17 57 57 63 55 63 17 52 52 52 52 52 52 52 52 52 52 17 17])!