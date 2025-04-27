!classDefinition: #PenalesTest category: #Penales!
TestCase subclass: #PenalesTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Penales'!

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test01DelanteroNoPuedeApuntarHaciaAfueraDelPaloIzquierdo
	
	| arquero delantero juegoPenales pelota |
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 100.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	self 
		should: [ juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: -1@0 arqueroSeLanzaEnDirección: 0@0.] 
		raise: Error
		withExceptionDo: [ :error |
			self assert: Penales direccionTiroFueraDeRango equals: error messageText.
			self assert: 0 equals: juegoPenales puntajeDeDelantero.
			self assert: 0 equals: juegoPenales puntajeDeArquero.]
	! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test02DelanteroNoPuedeApuntarHaciaAfueraDelPaloDerecho
	
	| arquero delantero juegoPenales pelota |
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 100.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	self 
		should: [ juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 3@0 arqueroSeLanzaEnDirección: 0@0.] 
		raise: Error
		withExceptionDo: [ :error |
			self assert: Penales direccionTiroFueraDeRango equals: error messageText.
			self assert: 0 equals: juegoPenales puntajeDeDelantero.
			self assert: 0 equals: juegoPenales puntajeDeArquero.]
	! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:06'!
test03DelanteroNoPuedeApuntarHaciaAbajoDelArco
	
	| arquero delantero juegoPenales pelota |
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 100.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	self 
		should: [ juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@-1 arqueroSeLanzaEnDirección: 0@0.] 
		raise: Error
		withExceptionDo: [ :error |
			self assert: Penales direccionTiroFueraDeRango equals: error messageText.
			self assert: 0 equals: juegoPenales puntajeDeDelantero.
			self assert: 0 equals: juegoPenales puntajeDeArquero.]
	! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test04DelanteroNoPuedeApuntarHaciaArribaDelTravesaño
	
	| arquero delantero juegoPenales pelota |
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 100.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	self 
		should: [ juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@3 arqueroSeLanzaEnDirección: 0@0.] 
		raise: Error
		withExceptionDo: [ :error |
			self assert: Penales direccionTiroFueraDeRango equals: error messageText.
			self assert: 0 equals: juegoPenales puntajeDeDelantero.
			self assert: 0 equals: juegoPenales puntajeDeArquero.]
	! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test05ArqueroNoPuedePasarseDelPaloIzquierdo
	
	| arquero delantero juegoPenales pelota |
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 100.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	self 
		should: [ juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@0 arqueroSeLanzaEnDirección: -1@0.] 
		raise: Error
		withExceptionDo: [ :error |
			self assert: Penales direccionArqueroFueraDeRango equals: error messageText.
			self assert: 0 equals: juegoPenales puntajeDeDelantero.
			self assert: 0 equals: juegoPenales puntajeDeArquero.]
	! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test06ArqueroNoPuedePasarseDelPaloDerecho
	
	| arquero delantero juegoPenales pelota |
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 100.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	self 
		should: [ juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@0 arqueroSeLanzaEnDirección: 3@0.] 
		raise: Error
		withExceptionDo: [ :error |
			self assert: Penales direccionArqueroFueraDeRango equals: error messageText.
			self assert: 0 equals: juegoPenales puntajeDeDelantero.
			self assert: 0 equals: juegoPenales puntajeDeArquero.]
	! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:06'!
test07ArqueroNoPuedeMeterseAbajoDeLaTierra
	
	| arquero delantero juegoPenales pelota |
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 100.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	self 
		should: [ juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@0 arqueroSeLanzaEnDirección: 0@-1.] 
		raise: Error
		withExceptionDo: [ :error |
			self assert: Penales direccionArqueroFueraDeRango equals: error messageText.
			self assert: 0 equals: juegoPenales puntajeDeDelantero.
			self assert: 0 equals: juegoPenales puntajeDeArquero.]
	! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test08ArqueroNoPuedeSaltarPorEncimaDelTravesaño
	
	| arquero delantero juegoPenales pelota |
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 100.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	self 
		should: [ juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@0 arqueroSeLanzaEnDirección: 0@3.] 
		raise: Error
		withExceptionDo: [ :error |
			self assert: Penales direccionArqueroFueraDeRango equals: error messageText.
			self assert: 0 equals: juegoPenales puntajeDeDelantero.
			self assert: 0 equals: juegoPenales puntajeDeArquero.]
	! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test09DireccionesDiferentesGolDelantero
	
	| arquero delantero juegoPenales pelota |
	
	"Caso general del juego..."
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 100.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 2@2 arqueroSeLanzaEnDirección: 0@1.
	
	self assert: 1 equals: juegoPenales puntajeDeDelantero.
	self assert: 0 equals: juegoPenales puntajeDeArquero.
	self assert: 2@2 equals: juegoPenales varDireccionRemateResultante
	"varXXXX es por VAR, de 'Video Assistant Referee'"! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test10MismasDireccionesInsuficienteFuerzaGolDelantero
	
	| arquero delantero juegoPenales pelota |
	
	"Caso general del juego..."
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 10.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 2@2 arqueroSeLanzaEnDirección: 2@2.
	
	self assert: 1 equals: juegoPenales puntajeDeDelantero.
	self assert: 0 equals: juegoPenales puntajeDeArquero.
	self assert: 2@2 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test11MismasDireccionesSuficienteFuerzaAtajaArquero
	
	| arquero delantero juegoPenales pelota |
	
	"Caso general del juego..."
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 100.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 2@2 arqueroSeLanzaEnDirección: 2@2.
	
	self assert: 0 equals: juegoPenales puntajeDeDelantero.
	self assert: 1 equals: juegoPenales puntajeDeArquero.
	self assert: 2@2 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:42:08'!
test12DelanteroQueTiraAColocarPierde50PorcFuerza
	
	| arquero delantero juegoPenales pelota |
	
	"La fuerza del Delantero se reduce en 50% siempre que tira a colocar... (no importa pelota, ni arquero)"
	"(delantero sacrificia potencia para ganar mayor precisión)"
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 50.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 2@2 arqueroSeLanzaEnDirección: 2@2.
	
	self assert: 0 equals: juegoPenales puntajeDeDelantero.
	self assert: 1 equals: juegoPenales puntajeDeArquero.
	self assert: 2@2 equals: juegoPenales varDireccionRemateResultante.
	self assert: 50 equals: juegoPenales varFuerzaResultanteDeTiro.! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:42:34'!
test13ArqueroQueEligeAntesDeTiroVsJabulaniAColocarSuma50PorcFuerzaExtra
	
	| arquero delantero juegoPenales pelota |
	
	"La fuerza del Delantero se reduce en 50% siempre que tira a colocar... (no importa pelota, ni arquero)"
	"El Arquero que elige donde tirarse antes de un tiro a colocar de jabulani gana 50% de su fuerza extra..."
	"(el arquero llega más cómodo y aprovecha mejor su fuerza)"
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 34.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@2 arqueroSeLanzaEnDirección: 0@2.
	
	self assert: 0 equals: juegoPenales puntajeDeDelantero.
	self assert: 1 equals: juegoPenales puntajeDeArquero.
	self assert: 0@2 equals: juegoPenales varDireccionRemateResultante.
	self assert: 50 equals: juegoPenales varFuerzaResultanteDeTiro.
	self assert: 51 equals: juegoPenales varFuerzaResultanteDeAtajada.! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:42:34'!
test14FuerzaInsuficienteDeArqueroQueEligeAntesDeTiroVsJabulaniAColocar
	
	| arquero delantero juegoPenales pelota |
	
	"La fuerza del Delantero se reduce en 50% siempre que tira a colocar... (no importa pelota, ni arquero)"
	"El Arquero que elige adonde tirarse antes de un tiro a colocar de jabulani gana 50% de su fuerza extra..."
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 32.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@2 arqueroSeLanzaEnDirección: 0@2.
	
	self assert: 1 equals: juegoPenales puntajeDeDelantero.
	self assert: 0 equals: juegoPenales puntajeDeArquero.
	self assert: 0@2 equals: juegoPenales varDireccionRemateResultante.
	self assert: 50 equals: juegoPenales varFuerzaResultanteDeTiro.
	self assert: 48 equals: juegoPenales varFuerzaResultanteDeAtajada.! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test15ArqueroQueEsperaPorTiroYSeAdelantaVsJabulaniAColocarIgnoraAlturaTiro
	
	| arquero delantero juegoPenales pelota |
	
	"La fuerza del Delantero se reduce en 50% siempre que tira a colocar... (no importa pelota, ni arquero)"
	"El Arquero que espera y se adelanta ante un tiro de jabulani a colocar ignora la 2da coordenada (altura) al atajar..."	
	"(al adelanterse encara la pelota antes de que su elevación se transforme en un problema)"
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero  esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 50.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@2 arqueroSeLanzaEnDirección: 0@0.
	
	self assert: 0 equals: juegoPenales puntajeDeDelantero.
	self assert: 1 equals: juegoPenales puntajeDeArquero.
	self assert: 0@2 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:42:08'!
test16PelotaPlayeraUsadaAColocarLeHacePerder20PorcFuerzaExtraAlDelantero
	
	| arquero delantero juegoPenales pelota |
	
	"La fuerza del Delantero se reduce en 50% siempre que tira a colocar... (no importa pelota, ni arquero)"
	"La humilde pelota playera le hace perder un 20% de fuerza adicional al delantero que la use para colocar... (no importa el arquero)"
	"(no debería ser reglamentaria... al menos no es de trapo, nos responden)"
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota playeraLentaCostaAzul.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 1.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 1@2 arqueroSeLanzaEnDirección: 1@2.
	
	self assert: 1 equals: juegoPenales puntajeDeDelantero.
	self assert: 0 equals: juegoPenales puntajeDeArquero.
	self assert: 1@2 equals: juegoPenales varDireccionRemateResultante.
	self assert: 40 equals: juegoPenales varFuerzaResultanteDeTiro! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:42:34'!
test17ArqueroQueEligeAntesDeTiroVsPlayeraAColocarSuma100PorcFuerzaExtra
	
	| arquero delantero juegoPenales pelota |
	
	"La fuerza del Delantero se reduce en 50% siempre que tira a colocar... (no importa pelota, ni arquero)"
	"La humilde pelota playera le hace perder un 20% adicional de fuerza al delantero que la use para colocar... (no importa el arquero)"
	"Arquero que elige donde lanzarse antes de un remate de una pelota playera lenta a colocar, gana un 100% de su fuerza extra..."
	"(a quien madruga...)"
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota playeraLentaCostaAzul.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 20.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@0 arqueroSeLanzaEnDirección: 0@0.
	
	self assert: 0 equals: juegoPenales puntajeDeDelantero.
	self assert: 1 equals: juegoPenales puntajeDeArquero.
	self assert: 0@0 equals: juegoPenales varDireccionRemateResultante.
	self assert: 40 equals: juegoPenales varFuerzaResultanteDeTiro.
	self assert: 40 equals: juegoPenales varFuerzaResultanteDeAtajada! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:42:34'!
test18FuerzaInsuficienteDeArqueroQueEligeAntesDeTiroVsPlayeraAColocar
	
	| arquero delantero juegoPenales pelota |
	
	"La fuerza del Delantero se reduce en 50% siempre que tira a colocar... (no importa pelota, ni arquero)"
	"La humilde pelota playera le hace perder un 20% adicional de fuerza al delantero que la use para colocar... (no importa el arquero)"
	"Arquero que elige donde lanzarse antes de un remate de una pelota playera lenta a colocar, gana un 100% de su fuerza extra..."
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota playeraLentaCostaAzul.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 19.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@0 arqueroSeLanzaEnDirección: 0@0.
	
	self assert: 1 equals: juegoPenales puntajeDeDelantero.
	self assert: 0 equals: juegoPenales puntajeDeArquero.
	self assert: 0@0 equals: juegoPenales varDireccionRemateResultante.
	self assert: 40 equals: juegoPenales varFuerzaResultanteDeTiro.
	self assert: 38 equals: juegoPenales varFuerzaResultanteDeAtajada! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test19ArqueroQueEsperaPorTiroYSeAdelantaVsPlayeraAColocarEsDescubiertoYPuntoParaDelantero
	
	| arquero delantero juegoPenales pelota |
	
	"Arquero que espera y se adelanta ante tiro con la lenta pelota playera, siempre es descubierto por el Árbitro, y el punto se le otorga al Delantero..."
	"(lo que servía de ventaja ante la Jabulani rápida, acá es tan obvio por lo que tarda en llegar la pelota al arco, que marchás preso...)"
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota playeraLentaCostaAzul.
	arquero := Arquero  esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 200.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@0 arqueroSeLanzaEnDirección: 0@0.
	
	self assert: 1 equals: juegoPenales puntajeDeDelantero.
	self assert: 0 equals: juegoPenales puntajeDeArquero.
	self assert: 0@0 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:34:52'!
test20DelanteroTiraAMatarAlAnguloInferiorIzquierdoLaAlturaDelTiroPasaAMedio
	
	| arquero delantero juegoPenales pelota |
	
	"Si se tira 'a matar' a los ángulos, la 2da coordenada (altura) del remate pasa a 1 (altura media)... (no importa pelota, ni arquero)"	
	"(tirar a matar no es tan preciso como tirar a colocar, hay desvios de altura. Sin embargo se usa el 100% de fuerza del jugador)"
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 200.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@0 arqueroSeLanzaEnDirección: 0@0.
	.
	self assert: 0@1 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:34:47'!
test21DelanteroTiraAMatarAlAnguloSuperiorIzquierdoLaAlturaDelTiroPasaAMedio
	
	| arquero delantero juegoPenales pelota |
	
	"Si se tira 'a matar' a los ángulos, la 2da coordenada (altura) del remate pasa a 1 (altura media)... (no importa pelota, ni arquero)"	
	"(tirar a matar no es tan preciso como tirar a colocar, hay desvios de altura. Sin embargo se usa el 100% de fuerza del jugador)"
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 200.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@2 arqueroSeLanzaEnDirección: 0@2.
	
	self assert: 0@1 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:34:41'!
test22DelanteroTiraAMatarAlAnguloInferiorDerechoLaAlturaDelTiroPasaAMedio
	
	| arquero delantero juegoPenales pelota |
	
	"Si se tira 'a matar' a los ángulos, la 2da coordenada (altura) del remate pasa a 1 (altura media)... (no importa pelota, ni arquero)"	
	"(tirar a matar no es tan preciso como tirar a colocar, hay desvios de altura. Sin embargo se usa el 100% de fuerza del jugador)"
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 200.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 2@0 arqueroSeLanzaEnDirección: 2@0.
	
	self assert: 2@1 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:34:36'!
test23DelanteroTiraAMatarAlAnguloSuperiorDerechoLaAlturaDelTiroPasaAMedio
	
	| arquero delantero juegoPenales pelota |
	
	"Si se tira 'a matar' a los ángulos, la 2da coordenada (altura) del remate pasa a 1 (altura media)... (no importa pelota, ni arquero)"	
	"(tirar a matar no es tan preciso como tirar a colocar, hay desvios de altura. Sin embargo se usa el 100% de fuerza del jugador)"
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 200.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 2@2 arqueroSeLanzaEnDirección: 2@2.
	
	self assert: 2@1 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:34:29'!
test24DelanteroTiraAMatarNoAlAnguloMantieneDireccionTiro
	
	| arquero delantero juegoPenales pelota |
	
	"Si se tira 'a matar' a los ángulos, la 2da coordenada (altura) del remate pasa a 1 (altura media)... (no importa pelota, ni arquero)"	
	"(tirar a matar no es tan preciso como tirar a colocar, hay desvios de altura. Sin embargo se usa el 100% de fuerza del jugador)"
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 200.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 1@2 arqueroSeLanzaEnDirección: 1@1.

	self assert: 1@2 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:42:08'!
test25DelanteroTiraAMatarUsa100PorcFuerzaBase
	
	| arquero delantero juegoPenales pelota |
	
	"Si se tira 'a matar' a los ángulos, la 2da coordenada (altura) del remate pasa a 1 (altura media)... (no importa pelota, ni arquero)"	
	"(tirar a matar no es tan preciso como tirar a colocar, hay desvios de altura. Sin embargo se usa el 100% de fuerza del jugador)"
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:150.
	pelota := Pelota playeraLentaCostaAzul.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 200.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 2@0 arqueroSeLanzaEnDirección: 2@0.
	
	self assert: 1 equals: juegoPenales puntajeDeDelantero.
	self assert: 0 equals: juegoPenales puntajeDeArquero.
	self assert: 2@1 equals: juegoPenales varDireccionRemateResultante.
	self assert: 150 equals: juegoPenales varFuerzaResultanteDeTiro! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:42:08'!
test26DelanteroTiraAMatarConJabulaniGana20PorcFuerzaExtra
	
	| arquero delantero juegoPenales pelota |
	
	"Si se tira 'a matar' el Delantero usa el 100% de su fuerza... (no importa pelota, ni arquero)"
	"Si se tira 'a matar' a los ángulos, la 2da coordenada (altura) del remate pasa a 1 (altura media)... (no importa pelota, ni arquero)"	
	"Si se tira 'a matar' usando la jabulani rápida, el Delantero gana un 20% de fuerza extra... (no importa arquero)"
	"(Jabulani a matar es la elección de los guerreros Z)"
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 120.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 2@2 arqueroSeLanzaEnDirección: 2@1.
	
	self assert: 0 equals: juegoPenales puntajeDeDelantero.
	self assert: 1 equals: juegoPenales puntajeDeArquero.
	self assert: 2@1 equals: juegoPenales varDireccionRemateResultante.
	self assert: 120 equals: juegoPenales varFuerzaResultanteDeTiro.! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:42:08'!
test27FuerzaInsuficienteDeArqueroQueEligeAntesDeTiroVsJabulaniAMatar
	
	| arquero delantero juegoPenales pelota |
	
	"Si se tira 'a matar' el Delantero usa el 100% de su fuerza... (no importa pelota, ni arquero)"
	"Si se tira 'a matar' a los ángulos, la 2da coordenada (altura) del remate pasa a 1 (altura media)... (no importa pelota, ni arquero)"	
	"Si se tira 'a matar' usando la jabulani rápida, el Delantero gana un 20% de fuerza extra... (no importa arquero)"
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 119.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 2@2 arqueroSeLanzaEnDirección: 2@1.
	
	self assert: 1 equals: juegoPenales puntajeDeDelantero.
	self assert: 0 equals: juegoPenales puntajeDeArquero.
	self assert: 2@1 equals: juegoPenales varDireccionRemateResultante.
	self assert: 120 equals: juegoPenales varFuerzaResultanteDeTiro.! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:06'!
test28ArqueroQueEligeAntesDeTiroVsJabulaniAMatarIgnoraAlturaTiro
	
	| arquero delantero juegoPenales pelota |
	
	"El Arquero que elige donde tirarse antes de un tiro de jabulani a matar, ignora la 2da coordenada (altura) al atajar..."		
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 200.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@2 arqueroSeLanzaEnDirección: 0@0.
	
	self assert: 0 equals: juegoPenales puntajeDeDelantero.
	self assert: 1 equals: juegoPenales puntajeDeArquero.
	self assert: 0@1 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test29ArqueroQueEsperaPorTiroYSeAdelantaVsJabulaniAMatarNuncaAtaja
	
	| arquero delantero juegoPenales pelota |
	
	"El Arquero que espera a ver la dirección del remate de una pelota jabulani rápida a matar antes de lanzarse, nunca la ataja sin importar nada, siquiera que se adelantó..."	
	"(su poder era de más de 9000!! era impresionante, no podía moverme, sólo la ví pasar... f )"
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 200.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 1@1 arqueroSeLanzaEnDirección: 1@1.
	
	self assert: 1 equals: juegoPenales puntajeDeDelantero.
	self assert: 0 equals: juegoPenales puntajeDeArquero.
	self assert: 1@1 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test30DelanteroQueNoPateaAlAnguloConPlayeraAMatarSuma2AAlturaDeDireccionPelotaAdentro
	
	| arquero delantero juegoPenales pelota |
	
	"Si se tira 'a matar' el Delantero usa el 100% de su fuerza... (no importa pelota, ni arquero)"
	"Si se tira 'a matar' a los ángulos, la 2da coordenada (altura) del remate pasa a 1 (altura media)... (no importa pelota, ni arquero)"	
	"Si se tira 'a matar' usando una pelota playera a una dirección que no es un ángulo, la 2da coordenada del remate (altura) suma 2, es decir sale volando producto de su liviandez (y que quiere retornar al mar). Si la pelota se va fuera del arco, el puntaje va al arquero... (no importa arquero)"
	"(y voló.. y me hizo volar... y yo volé de él...  pero acá por la arbolada... y el voló.. y se estrelló por acá por la pared...)"
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:100.
	pelota := Pelota playeraLentaCostaAzul.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 200.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 1@0 arqueroSeLanzaEnDirección: 1@0.
	
	self assert: 1 equals: juegoPenales puntajeDeDelantero.
	self assert: 0 equals: juegoPenales puntajeDeArquero.
	self assert: 1@2 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test31DelanteroQueNoPateaAlAnguloConPlayeraAMatarSuma2AAlturaDeDireccionPelotaAfuera
	
	| arquero delantero juegoPenales pelota |
	
	"Si se tira 'a matar' el Delantero usa el 100% de su fuerza... (no importa pelota, ni arquero)"
	"Si se tira 'a matar' a los ángulos, la 2da coordenada (altura) del remate pasa a 1 (altura media)... (no importa pelota, ni arquero)"	
	"Si se tira 'a matar' usando una pelota playera a una dirección que no es un ángulo, la 2da coordenada del remate (altura) suma 2, es decir sale volando producto de su liviandez (y que quiere retornar al mar). Si la pelota se va fuera del arco, el puntaje va al arquero... (no importa arquero)"
	"(El caso auspiciado por el Pipita...)"
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:100.
	pelota := Pelota playeraLentaCostaAzul.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 200.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@1 arqueroSeLanzaEnDirección: 0@0.
	
	self assert: 0 equals: juegoPenales puntajeDeDelantero.
	self assert: 1 equals: juegoPenales puntajeDeArquero.
	self assert: 0@3 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test32ArqueroQueEligeAntesDeTiroVsPlayeraAMatarAlAnguloIgnoraAnchoTiro
	
	| arquero delantero juegoPenales pelota |
	
	"Si se tira 'a matar' el Delantero usa el 100% de su fuerza... (no importa pelota, ni arquero)"
	"Si se tira 'a matar' a los ángulos, la 2da coordenada (altura) del remate pasa a 1 (altura media)... (no importa pelota, ni arquero)"	
	"Si el arquero elige donde tirarse antes del tiro a matar de la pelota playera, ignora la 1ra coordenada del remate (ancho) al atajar..."
	"(con agacharse, quedarse parado, o saltar le alcanza...)"
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:100.
	pelota := Pelota playeraLentaCostaAzul.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 100.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@0 arqueroSeLanzaEnDirección: 2@1.
	
	self assert: 0 equals: juegoPenales puntajeDeDelantero.
	self assert: 1 equals: juegoPenales puntajeDeArquero.
	self assert: 0@1 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 18:39:22'!
test33ArqueroQueEligeAntesDeTiroVsPlayeraAMatarNoAlAnguloIgnoraAnchoTiro
	
	| arquero delantero juegoPenales pelota |
	
	"Si se tira 'a matar' el Delantero usa el 100% de su fuerza... (no importa pelota, ni arquero)"
	"Si se tira 'a matar' usando una pelota playera a una dirección que no es un ángulo, la 2da coordenada del remate (altura) suma 2, es decir sale volando producto de su liviandez (y que quiere retornar al mar). Si la pelota se va fuera del arco, el puntaje va al arquero... (no importa arquero)"
	"Si el arquero elige donde tirarse antes del tiro a matar de la pelota playera, ignora la 1ra coordenada del remate (ancho) al atajar..."
	"(con agacharse, quedarse parado, o saltar le alcanza...)"
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:100.
	pelota := Pelota playeraLentaCostaAzul.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 100.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 1@0 arqueroSeLanzaEnDirección: 0@2.
	
	self assert: 0 equals: juegoPenales puntajeDeDelantero.
	self assert: 1 equals: juegoPenales puntajeDeArquero.
	self assert: 1@2 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test34ArqueroQueEsperaPorTiroYSeAdelantaVsPlayeraAMatarSiempreAtaja
	
	| arquero delantero juegoPenales pelota |
	
	"El Arquero que espera y se adelanta ante una pelota playera lenta a matar, siempre la ataja sin importar nada..."	
	"(como la pelota es taaaan lentaaa, el arquero se puede ir a tomar un cafe, verse una serie, volver y aún atajar la pelota habiendose tirado a cualquier lado. Pero igual es más rapida que cuando se la tira a colocar, donde indefectiblemente el arbitro lo detecta...)"
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:100.
	pelota := Pelota playeraLentaCostaAzul.
	arquero := Arquero esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 1.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 2@2 arqueroSeLanzaEnDirección: 0@0.
	
	self assert: 0 equals: juegoPenales puntajeDeDelantero.
	self assert: 1 equals: juegoPenales puntajeDeArquero.
	self assert: 2@1 equals: juegoPenales varDireccionRemateResultante! !


!classDefinition: #Arquero category: #Penales!
Object subclass: #Arquero
	instanceVariableNames: 'fuerza modoDeAtajar'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Penales'!

!Arquero methodsFor: 'initialization' stamp: 'MN 4/24/2025 16:23:27'!
inicializarConFuerzaBaseDe: unaMagnitud yModoDeAtajar: unModoDeAtajar
	fuerza := unaMagnitud.
	modoDeAtajar := unModoDeAtajar.! !


!Arquero methodsFor: 'accessing' stamp: 'MN 4/24/2025 14:43:57'!
fuerza
	^ fuerza ! !


!Arquero methodsFor: 'behaviour' stamp: 'MN 4/26/2025 12:26:39'!
puedeAtajarEnDireccion: direccionAtajar laPelota: unaPelota rematadaEnDireccion: direccionRemate conFuerza: fuerzaRemate yModoDeTiro: unModoDeTiro 
	
	| pudoAtajar |
	
	pudoAtajar := modoDeAtajar
		puedeAtajarEnDireccion: direccionAtajar
		conFuerza: fuerza
		laPelota: unaPelota
		rematadaEnDireccion: direccionRemate
		conFuerza: fuerzaRemate
		yModoDeTiro: unModoDeTiro.
		
	^ pudoAtajar
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Arquero class' category: #Penales!
Arquero class
	instanceVariableNames: ''!

!Arquero class methodsFor: 'instance creation' stamp: 'MN 4/26/2025 12:32:22'!
eligeDireccionAntesDeTiroSuFuerzaBaseEs: unaMagnitud
	^ self new inicializarConFuerzaBaseDe: unaMagnitud yModoDeAtajar: EligeAntesDeTiro new! !

!Arquero class methodsFor: 'instance creation' stamp: 'MN 4/26/2025 12:32:16'!
esperaPorTiroYSeAdelantaSuFuerzaBaseEs: unaMagnitud
	^ self new inicializarConFuerzaBaseDe: unaMagnitud yModoDeAtajar: EsperaPorTiroYSeAdelanta new! !


!classDefinition: #Delantero category: #Penales!
Object subclass: #Delantero
	instanceVariableNames: 'fuerza modoDeTiro fuerzaConLaQuePateo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Penales'!

!Delantero methodsFor: 'accessing' stamp: 'MN 4/24/2025 14:43:01'!
fuerza
	^ fuerza ! !

!Delantero methodsFor: 'accessing' stamp: 'MN 4/26/2025 22:04:17'!
fuerzaConLaQuePateo
	^ fuerzaConLaQuePateo! !

!Delantero methodsFor: 'accessing' stamp: 'MN 4/26/2025 22:05:02'!
fuerzaConLaQuePateo: unaMagnitud
	fuerzaConLaQuePateo := unaMagnitud! !

!Delantero methodsFor: 'accessing' stamp: 'MN 4/24/2025 17:51:38'!
modoDeTiro
	^ modoDeTiro ! !


!Delantero methodsFor: 'initialization' stamp: 'MN 4/26/2025 10:25:19'!
inicializarConModoDeTiroAColocarConFuerzaBaseDe: unaMagnitud
	modoDeTiro := TiroAColocar nuevoParaDelantero: self.
	fuerza := unaMagnitud! !

!Delantero methodsFor: 'initialization' stamp: 'MN 4/26/2025 10:25:29'!
inicializarConModoDeTiroAMatarConFuerzaBaseDe: unaMagnitud
	modoDeTiro := TiroAMatar nuevoParaDelantero: self.
	fuerza := unaMagnitud! !


!Delantero methodsFor: 'behaviour' stamp: 'MN 4/26/2025 23:22:11'!
remataConPelota: unaPelota yCalcularDireccionAlApuntarEnDireccion: direccionRemate
	
	| direccionFinalRemate |
	
	fuerzaConLaQuePateo := fuerza.
	
	direccionFinalRemate := modoDeTiro
		rematarConPelota: unaPelota
		yCalcularDireccionAlApuntarEnDireccion: direccionRemate.
	
	^ direccionFinalRemate ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Delantero class' category: #Penales!
Delantero class
	instanceVariableNames: ''!

!Delantero class methodsFor: 'instance creation' stamp: 'MN 4/26/2025 10:24:28'!
decideTirarAColocarSuFuerzaBaseEs: unaMagnitud
	^self new inicializarConModoDeTiroAColocarConFuerzaBaseDe: unaMagnitud! !

!Delantero class methodsFor: 'instance creation' stamp: 'MN 4/26/2025 10:24:41'!
decideTirarAMatarSuFuerzaBaseEs: unaMagnitud
	^ self new inicializarConModoDeTiroAMatarConFuerzaBaseDe: unaMagnitud ! !


!classDefinition: #ModoDeAtajar category: #Penales!
Object subclass: #ModoDeAtajar
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Penales'!

!ModoDeAtajar methodsFor: 'behaviour' stamp: 'MN 4/26/2025 12:23:15'!
puedeAtajarEnDireccion: direccionAtajar conFuerza: fuerzaAtajar laPelota: unaPelota rematadaEnDireccion: direccionRemate conFuerza: fuerzaRemate yModoDeTiro: unModoDeTiro
	
	self subclassResponsibility ! !


!classDefinition: #EligeAntesDeTiro category: #Penales!
ModoDeAtajar subclass: #EligeAntesDeTiro
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Penales'!

!EligeAntesDeTiro methodsFor: 'behaviour' stamp: 'MN 4/26/2025 12:30:39'!
puedeAtajarEnDireccion: direccionAtajar conFuerza: fuerzaAtajar laPelota: unaPelota rematadaEnDireccion: direccionRemate conFuerza: fuerzaRemate yModoDeTiro: unModoDeTiro

	| pudoAtajar |
	
	pudoAtajar := unModoDeTiro
		siArqueroEligioAntesPuedeLaPelota: unaPelota
		serAtajadaEnDireccion: direccionAtajar
		conFuerza: fuerzaAtajar
		rematadaEnDireccion: direccionRemate
		conFuerza: fuerzaRemate.
		
	^ pudoAtajar ! !


!classDefinition: #EsperaPorTiroYSeAdelanta category: #Penales!
ModoDeAtajar subclass: #EsperaPorTiroYSeAdelanta
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Penales'!

!EsperaPorTiroYSeAdelanta methodsFor: 'behaviour' stamp: 'MN 4/26/2025 12:29:36'!
puedeAtajarEnDireccion: direccionAtajar conFuerza: fuerzaAtajar laPelota: unaPelota rematadaEnDireccion: direccionRemate conFuerza: fuerzaRemate yModoDeTiro: unModoDeTiro
	
	| pudoAtajar |
	
	pudoAtajar := unModoDeTiro
		siArqueroEsperoYAdelantoPuedeLaPelota: unaPelota
		serAtajadaEnDireccion: direccionAtajar 
		conFuerza: fuerzaAtajar
		rematadaEnDireccion: direccionRemate
		conFuerza: fuerzaRemate.
		
	^ pudoAtajar! !


!classDefinition: #ModoDeTiro category: #Penales!
Object subclass: #ModoDeTiro
	instanceVariableNames: 'delantero'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Penales'!

!ModoDeTiro methodsFor: 'behaviour' stamp: 'MN 4/26/2025 10:10:52'!
rematarConPelota: unaPelota yCalcularDireccionAlApuntarEnDireccion: direccionRemate
	self subclassResponsibility ! !

!ModoDeTiro methodsFor: 'behaviour' stamp: 'MN 4/26/2025 12:19:40'!
siArqueroEligioAntesPuedeLaPelota: unaPelota serAtajadaEnDireccion: direccionAtajar conFuerza: fuerzaAtajar rematadaEnDireccion: direccionRemate conFuerza: fuerzaRemate

	self subclassResponsibility ! !

!ModoDeTiro methodsFor: 'behaviour' stamp: 'MN 4/26/2025 12:19:27'!
siArqueroEsperoYAdelantoPuedeLaPelota: unaPelota serAtajadaEnDireccion: direccionAtajar conFuerza: fuerzaAtajar rematadaEnDireccion: direccionRemate conFuerza: fuerzaRemate

	self subclassResponsibility ! !


!ModoDeTiro methodsFor: 'initialization' stamp: 'MN 4/26/2025 10:20:32'!
inicializarParaDelantero: unDelantero
	delantero := unDelantero.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ModoDeTiro class' category: #Penales!
ModoDeTiro class
	instanceVariableNames: ''!

!ModoDeTiro class methodsFor: 'instance creation' stamp: 'MN 4/26/2025 10:19:41'!
nuevoParaDelantero: unDelantero
	^ self new inicializarParaDelantero: unDelantero ! !


!classDefinition: #TiroAColocar category: #Penales!
ModoDeTiro subclass: #TiroAColocar
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Penales'!

!TiroAColocar methodsFor: 'behaviour' stamp: 'MN 4/26/2025 23:20:31'!
rematarConPelota: unaPelota yCalcularDireccionAlApuntarEnDireccion: direccionRemate
	delantero fuerzaConLaQuePateo: (delantero fuerza * 0.5).
	
	unaPelota calcularFuerzaConLaQueEsPateadaPorDelanteroQueTiraAColocar: delantero.

	^ direccionRemate
	! !

!TiroAColocar methodsFor: 'behaviour' stamp: 'MN 4/26/2025 22:01:36'!
siArqueroEligioAntesPuedeLaPelota: unaPelota serAtajadaEnDireccion: direccionAtajar conFuerza: fuerzaAtajar rematadaEnDireccion: direccionRemate conFuerza: fuerzaRemate
	
	| esAtajadaLaPelota |
	
	esAtajadaLaPelota := unaPelota
		esAtajadaSiFueColocadaEnDireccion: direccionRemate
		conFuerza: fuerzaRemate
		yArqueroEligioAntesEnDireccion: direccionAtajar
		conFuerza: fuerzaAtajar.
		
	^ esAtajadaLaPelota
		! !

!TiroAColocar methodsFor: 'behaviour' stamp: 'MN 4/26/2025 13:04:51'!
siArqueroEsperoYAdelantoPuedeLaPelota: unaPelota serAtajadaEnDireccion: direccionAtajar conFuerza: fuerzaAtajar rematadaEnDireccion: direccionRemate conFuerza: fuerzaRemate

	| esAtajadaLaPelota |
	
	esAtajadaLaPelota := unaPelota
		esAtajadaSiFueColocadaEnDireccion:direccionRemate
		conFuerza: fuerzaRemate
		yArqueroEsperoYSeAdelantoEnDireccion: direccionAtajar
		conFuerza: fuerzaAtajar.
		
	^ esAtajadaLaPelota! !


!classDefinition: #TiroAMatar category: #Penales!
ModoDeTiro subclass: #TiroAMatar
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Penales'!

!TiroAMatar methodsFor: 'behaviour' stamp: 'MN 4/26/2025 23:20:46'!
rematarConPelota: unaPelota yCalcularDireccionAlApuntarEnDireccion: direccionRemate
	| direccionesEsquinas direccionFinal |
	direccionesEsquinas := Set with: 0@0 with: 2@0 with: 0@2 with: 2@2.
	
	unaPelota calcularFuerzaConLaQueEsPateadaPorDelanteroQueTiraAMatar: delantero.

	(direccionesEsquinas includes: direccionRemate) ifTrue:[
		direccionFinal := (direccionRemate x)@(1)
	] ifFalse: [
		direccionFinal:= unaPelota calcularDireccionFinalCuandoEsPateadaEn: direccionRemate.
	].

	^ direccionFinal ! !

!TiroAMatar methodsFor: 'behaviour' stamp: 'MN 4/26/2025 23:22:52'!
siArqueroEligioAntesPuedeLaPelota: unaPelota serAtajadaEnDireccion: direccionAtajar conFuerza: fuerzaAtajar rematadaEnDireccion: direccionRemate conFuerza: fuerzaRemate
	
	| esAtajadaLaPelota |
	
	esAtajadaLaPelota := unaPelota 
		esAtajadaSiFueMatadaEnDireccion: direccionRemate
		conFuerza: fuerzaRemate
		yArqueroEligioAntesEnDireccion: direccionAtajar
		conFuerza: fuerzaAtajar.
		
	^ esAtajadaLaPelota! !

!TiroAMatar methodsFor: 'behaviour' stamp: 'MN 4/26/2025 13:05:10'!
siArqueroEsperoYAdelantoPuedeLaPelota: unaPelota serAtajadaEnDireccion: direccionAtajar conFuerza: fuerzaAtajar rematadaEnDireccion: direccionRemate conFuerza: fuerzaRemate

	| esAtajadaLaPelota |
	
	esAtajadaLaPelota := unaPelota
		esAtajadaSiFueMatadaEnDireccion:direccionRemate
		conFuerza: fuerzaRemate
		yArqueroEsperoYSeAdelantoEnDireccion: direccionAtajar
		conFuerza: fuerzaAtajar.
		
	^ esAtajadaLaPelota! !


!classDefinition: #Pelota category: #Penales!
Object subclass: #Pelota
	instanceVariableNames: 'tipo fuerzaConLaQueFueAtajada'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Penales'!

!Pelota methodsFor: 'initialization' stamp: 'MN 4/24/2025 16:22:02'!
inicializarPelota: unTipoDePelota
	tipo := unTipoDePelota ! !


!Pelota methodsFor: 'accessing' stamp: 'MN 4/26/2025 21:59:22'!
fuerzaConLaQueFueAtajada
	^ fuerzaConLaQueFueAtajada! !

!Pelota methodsFor: 'accessing' stamp: 'MN 4/24/2025 14:53:10'!
tipo
	^ tipo! !


!Pelota methodsFor: 'behaviour atajada' stamp: 'MN 4/26/2025 13:03:38'!
esAtajadaSiFueColocadaEnDireccion:direccionRemate conFuerza: fuerzaRemate yArqueroEligioAntesEnDireccion: direccionAtajar conFuerza: fuerzaAtajar

	self subclassResponsibility ! !

!Pelota methodsFor: 'behaviour atajada' stamp: 'MN 4/26/2025 13:04:19'!
esAtajadaSiFueColocadaEnDireccion:direccionRemate conFuerza: fuerzaRemate yArqueroEsperoYSeAdelantoEnDireccion: direccionAtajar conFuerza: fuerzaAtajar

	self subclassResponsibility ! !

!Pelota methodsFor: 'behaviour atajada' stamp: 'MN 4/26/2025 13:04:08'!
esAtajadaSiFueMatadaEnDireccion:direccionRemate conFuerza: fuerzaRemate yArqueroEligioAntesEnDireccion: direccionAtajar conFuerza: fuerzaAtajar

	self subclassResponsibility ! !

!Pelota methodsFor: 'behaviour atajada' stamp: 'MN 4/26/2025 13:03:51'!
esAtajadaSiFueMatadaEnDireccion:direccionRemate conFuerza: fuerzaRemate yArqueroEsperoYSeAdelantoEnDireccion: direccionAtajar conFuerza: fuerzaAtajar

	self subclassResponsibility ! !


!Pelota methodsFor: 'behaviour al patear' stamp: 'MN 4/26/2025 22:35:06'!
calcularDireccionFinalCuandoEsPateadaEn: unaDireccionQueNoEsEsquina
	^ self subclassResponsibility ! !

!Pelota methodsFor: 'behaviour al patear' stamp: 'MN 4/26/2025 23:18:01'!
calcularFuerzaConLaQueEsPateadaPorDelanteroQueTiraAColocar: unDelantero

	self subclassResponsibility ! !

!Pelota methodsFor: 'behaviour al patear' stamp: 'MN 4/26/2025 23:17:45'!
calcularFuerzaConLaQueEsPateadaPorDelanteroQueTiraAMatar: unDelantero

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Pelota class' category: #Penales!
Pelota class
	instanceVariableNames: ''!

!Pelota class methodsFor: 'instance creation' stamp: 'MN 4/26/2025 13:00:25'!
jabulaniSudafricanaRapida
	^ Jabulani new! !

!Pelota class methodsFor: 'instance creation' stamp: 'MN 4/26/2025 13:00:34'!
playeraLentaCostaAzul
	^ Playera new! !


!classDefinition: #Jabulani category: #Penales!
Pelota subclass: #Jabulani
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Penales'!

!Jabulani methodsFor: 'behaviour al patear' stamp: 'MN 4/26/2025 22:35:27'!
calcularDireccionFinalCuandoEsPateadaEn: unaDireccionQueNoEsEsquina
	^ unaDireccionQueNoEsEsquina ! !

!Jabulani methodsFor: 'behaviour al patear' stamp: 'MN 4/26/2025 23:19:09'!
calcularFuerzaConLaQueEsPateadaPorDelanteroQueTiraAColocar: unDelantero

	unDelantero fuerzaConLaQuePateo: (unDelantero fuerzaConLaQuePateo)! !

!Jabulani methodsFor: 'behaviour al patear' stamp: 'MN 4/26/2025 23:18:40'!
calcularFuerzaConLaQueEsPateadaPorDelanteroQueTiraAMatar: unDelantero

	unDelantero fuerzaConLaQuePateo: (unDelantero fuerzaConLaQuePateo * 1.2)! !


!Jabulani methodsFor: 'behaviour atajada' stamp: 'MN 4/26/2025 21:59:53'!
esAtajadaSiFueColocadaEnDireccion:direccionRemate conFuerza: fuerzaRemate yArqueroEligioAntesEnDireccion: direccionAtajar conFuerza: fuerzaAtajar

	| fuerzaAtajarFinal |
	
	fuerzaAtajarFinal := fuerzaAtajar * 1.5.
	
	fuerzaConLaQueFueAtajada := fuerzaAtajarFinal.
	
	^ Penales
		coincide: direccionRemate
		conFuerza: fuerzaRemate
		conDireccion: direccionAtajar
		conFuerza: fuerzaAtajarFinal .! !

!Jabulani methodsFor: 'behaviour atajada' stamp: 'MN 4/26/2025 22:00:09'!
esAtajadaSiFueColocadaEnDireccion:direccionRemate conFuerza: fuerzaRemate yArqueroEsperoYSeAdelantoEnDireccion: direccionAtajar conFuerza: fuerzaAtajar
	
	fuerzaConLaQueFueAtajada := fuerzaAtajar.
	
	^ Penales
		coincide: direccionRemate x
		conFuerza: fuerzaRemate
		conDireccion: direccionAtajar x
		conFuerza: fuerzaAtajar.! !

!Jabulani methodsFor: 'behaviour atajada' stamp: 'MN 4/26/2025 22:00:18'!
esAtajadaSiFueMatadaEnDireccion:direccionRemate conFuerza: fuerzaRemate yArqueroEligioAntesEnDireccion: direccionAtajar conFuerza: fuerzaAtajar
	
	fuerzaConLaQueFueAtajada := fuerzaAtajar.
	
	^ Penales
		coincide: direccionRemate x
		conFuerza: fuerzaRemate
		conDireccion: direccionAtajar x
		conFuerza: fuerzaAtajar .! !

!Jabulani methodsFor: 'behaviour atajada' stamp: 'MN 4/26/2025 22:00:25'!
esAtajadaSiFueMatadaEnDireccion:direccionRemate conFuerza: fuerzaRemate yArqueroEsperoYSeAdelantoEnDireccion: direccionAtajar conFuerza: fuerzaAtajar
	
	fuerzaConLaQueFueAtajada := fuerzaAtajar.
	
	^ false! !


!classDefinition: #Playera category: #Penales!
Pelota subclass: #Playera
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Penales'!

!Playera methodsFor: 'behaviour al patear' stamp: 'MN 4/26/2025 22:33:16'!
calcularDireccionFinalCuandoEsPateadaEn: unaDireccionQueNoEsEsquina

	| direccionFinalDosArriba |
	
	direccionFinalDosArriba := (unaDireccionQueNoEsEsquina x)@(unaDireccionQueNoEsEsquina y + 2).
	
	^ direccionFinalDosArriba ! !

!Playera methodsFor: 'behaviour al patear' stamp: 'MN 4/26/2025 23:19:57'!
calcularFuerzaConLaQueEsPateadaPorDelanteroQueTiraAColocar: unDelantero

	unDelantero fuerzaConLaQuePateo: (unDelantero fuerzaConLaQuePateo * 0.8)! !

!Playera methodsFor: 'behaviour al patear' stamp: 'MN 4/26/2025 23:20:16'!
calcularFuerzaConLaQueEsPateadaPorDelanteroQueTiraAMatar: unDelantero

	unDelantero fuerzaConLaQuePateo: (unDelantero fuerzaConLaQuePateo)! !


!Playera methodsFor: 'behaviour atajada' stamp: 'MN 4/26/2025 22:00:32'!
esAtajadaSiFueColocadaEnDireccion:direccionRemate conFuerza: fuerzaRemate yArqueroEligioAntesEnDireccion: direccionAtajar conFuerza: fuerzaAtajar

	| fuerzaAtajarFinal |
	
	fuerzaAtajarFinal := fuerzaAtajar * 2.
	
	fuerzaConLaQueFueAtajada := fuerzaAtajarFinal.
	
	^ Penales
		coincide: direccionRemate
		conFuerza: fuerzaRemate
		conDireccion: direccionAtajar
		conFuerza: fuerzaAtajarFinal .! !

!Playera methodsFor: 'behaviour atajada' stamp: 'MN 4/26/2025 22:00:36'!
esAtajadaSiFueColocadaEnDireccion:direccionRemate conFuerza: fuerzaRemate yArqueroEsperoYSeAdelantoEnDireccion: direccionAtajar conFuerza: fuerzaAtajar

	fuerzaConLaQueFueAtajada := fuerzaAtajar.

	^ false! !

!Playera methodsFor: 'behaviour atajada' stamp: 'MN 4/26/2025 22:00:41'!
esAtajadaSiFueMatadaEnDireccion:direccionRemate conFuerza: fuerzaRemate yArqueroEligioAntesEnDireccion: direccionAtajar conFuerza: fuerzaAtajar

	fuerzaConLaQueFueAtajada := fuerzaAtajar.

	^ Penales
		coincide: direccionRemate y
		conFuerza: fuerzaRemate
		conDireccion: direccionAtajar y
		conFuerza: fuerzaAtajar .! !

!Playera methodsFor: 'behaviour atajada' stamp: 'MN 4/26/2025 22:00:45'!
esAtajadaSiFueMatadaEnDireccion:direccionRemate conFuerza: fuerzaRemate yArqueroEsperoYSeAdelantoEnDireccion: direccionAtajar conFuerza: fuerzaAtajar

	fuerzaConLaQueFueAtajada := fuerzaAtajar.

	^ true! !


!classDefinition: #Penales category: #Penales!
Object subclass: #Penales
	instanceVariableNames: 'delantero arquero puntajeDeDelantero puntajeDeArquero ultimaDireccionRematada ultimaDireccionAtajada fuerzaResultanteDeAtajada fuerzaResultanteDeTiro'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Penales'!

!Penales methodsFor: 'initialization' stamp: 'MN 4/24/2025 10:11:39'!
inicializarConDelantero: unDelantero yArquero: unArquero
	delantero := unDelantero.
	arquero := unArquero.
	
	puntajeDeDelantero := 0.
	puntajeDeArquero := 0.! !


!Penales methodsFor: 'kick' stamp: 'MN 4/26/2025 23:31:16'!
arbitroPitaConPelota: unaPelota delanteroRemataAlArcoConDireccion: direccionRemate arqueroSeLanzaEnDirección: direccionAtajar

	| pudoArqueroAtajar direccionFinalRemate |
	
	self chequearDireccionRemateDentroDelArco: direccionRemate.
	self chequearDireccionAtajarDentroDelArco: direccionAtajar.
	
	direccionFinalRemate := delantero
		remataConPelota: unaPelota
		yCalcularDireccionAlApuntarEnDireccion: direccionRemate.
		
	self
		siRemateEnDireccion: direccionFinalRemate 
		seFueVolandoEntonces: [ puntajeDeArquero := puntajeDeArquero + 1 ]
		siNo: [
			pudoArqueroAtajar := arquero
				puedeAtajarEnDireccion: direccionAtajar
				laPelota: unaPelota
				rematadaEnDireccion: direccionFinalRemate
				conFuerza: delantero fuerzaConLaQuePateo
				yModoDeTiro: delantero modoDeTiro.
		
			self calcularPuntajeDadoQue: pudoArqueroAtajar.
		].

	ultimaDireccionRematada := direccionFinalRemate.
	ultimaDireccionAtajada := direccionAtajar.
	fuerzaResultanteDeAtajada := unaPelota fuerzaConLaQueFueAtajada.
	fuerzaResultanteDeTiro := delantero fuerzaConLaQuePateo.! !

!Penales methodsFor: 'kick' stamp: 'MN 4/26/2025 23:29:46'!
calcularPuntajeDadoQue: unaCondicion

	unaCondicion ifTrue: [
		puntajeDeArquero := puntajeDeArquero + 1
	] ifFalse: [
		puntajeDeDelantero := puntajeDeDelantero + 1
	]! !

!Penales methodsFor: 'kick' stamp: 'MN 4/26/2025 23:28:52'!
siRemateEnDireccion: direccionRemate seFueVolandoEntonces: unBloque siNo: otroBloque
	direccionRemate y > 2 ifTrue: unBloque
	ifFalse: otroBloque .! !


!Penales methodsFor: 'accessing' stamp: 'MN 4/24/2025 10:14:18'!
puntajeDeArquero
	^puntajeDeArquero ! !

!Penales methodsFor: 'accessing' stamp: 'MN 4/24/2025 10:14:11'!
puntajeDeDelantero
	^puntajeDeDelantero ! !

!Penales methodsFor: 'accessing' stamp: 'MN 4/24/2025 14:29:51'!
varDireccionRemateResultante
	^ ultimaDireccionRematada! !

!Penales methodsFor: 'accessing' stamp: 'MN 4/26/2025 21:58:24'!
varFuerzaResultanteDeAtajada
	^ fuerzaResultanteDeAtajada.! !

!Penales methodsFor: 'accessing' stamp: 'MN 4/26/2025 23:12:41'!
varFuerzaResultanteDeTiro
	^ delantero fuerzaConLaQuePateo.! !


!Penales methodsFor: 'errores de direccion' stamp: 'MN 4/26/2025 23:31:36'!
chequearDireccionAtajarDentroDelArco: unaDireccion 
	self
		chequearDireccionValida: unaDireccion
		siInvalidaErrorConDescripcion: (self class direccionArqueroFueraDeRango) ! !

!Penales methodsFor: 'errores de direccion' stamp: 'MN 4/26/2025 23:31:40'!
chequearDireccionRemateDentroDelArco: unaDireccion 
	self
		chequearDireccionValida: unaDireccion
		siInvalidaErrorConDescripcion: (self class direccionTiroFueraDeRango)! !

!Penales methodsFor: 'errores de direccion' stamp: 'MN 4/26/2025 23:31:29'!
chequearDireccionValida: unaDireccion siInvalidaErrorConDescripcion: unaDescripcionDeError
	(unaDireccion between: 0@0 and: 2@2) ifFalse: [
		self error: unaDescripcionDeError
	].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Penales class' category: #Penales!
Penales class
	instanceVariableNames: ''!

!Penales class methodsFor: 'instance creation' stamp: 'MN 4/24/2025 10:33:01'!
conDelantero: unDelantero yArquero: unArquero
	^self new inicializarConDelantero: unDelantero yArquero: unArquero! !


!Penales class methodsFor: 'message errors' stamp: 'NR 9/19/2023 06:12:49'!
direccionArqueroFueraDeRango
	
	^'El arquero debe lanzarse a coordenadas válidas'! !

!Penales class methodsFor: 'message errors' stamp: 'NR 9/19/2023 06:12:32'!
direccionTiroFueraDeRango
	
	^'La pelota debe dirigirse a coordenadas válidas'! !



!Penales class methodsFor: 'puede atajar' stamp: 'MN 4/26/2025 11:17:43'!
coincide: direccionPateada conFuerza: fuerzaRemate conDireccion: direccionAtajada conFuerza: fuerzaAtajar

	direccionPateada = direccionAtajada ifTrue: [
		fuerzaAtajar >= fuerzaRemate ifTrue:[
			^ true
		] ifFalse: [ 
			^ false
		].
	] ifFalse: [
		 ^ false
	].! !
