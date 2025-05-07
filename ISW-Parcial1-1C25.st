!classDefinition: #FleetRunTests category: #'ISW-Parcial1-1C25'!
TestCase subclass: #FleetRunTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-Parcial1-1C25'!

!FleetRunTests methodsFor: 'tests' stamp: 'HAW 5/6/2025 13:26:42'!
test01TheFleetShouldHaveAtLeastOneSpaceship
	
	self 
		should: [ FleetRun assemble: {  } ] 
		raise: Error-MessageNotUnderstood 
		withMessageText: FleetRun fleetWithoutSpaceshipsErrorDescription ! !

!FleetRunTests methodsFor: 'tests' stamp: 'HAW 5/6/2025 13:26:28'!
test02TheFleetCannotHaveDuplicatedShips

	| heavyCruiserOnImpulse |
	
	heavyCruiserOnImpulse := self newHeavyCruiserShipOnImpulse.
	
	self 
		should: [ FleetRun assemble: { heavyCruiserOnImpulse. heavyCruiserOnImpulse } ] 
		raise: Error-MessageNotUnderstood 
		withMessageText: FleetRun allSpaceshipsShouldBeDifferentErrorDescription ! !

!FleetRunTests methodsFor: 'tests' stamp: 'HAW 5/6/2025 11:19:11'!
test03TheSequenceRouteOfSectorsToGoThroughShouldNotBeEmpty

	| heavyCruiserOnImpulse fleet |
	
	heavyCruiserOnImpulse := self newHeavyCruiserShipOnImpulse.
	self assert: (heavyCruiserOnImpulse hasFuel: 50).
	
	fleet := FleetRun assemble: { heavyCruiserOnImpulse }.
	
	self 
		should: [ fleet runThrough: {  } ] 
		raise: Error-MessageNotUnderstood  
		withExceptionDo: [ :error | 
			self assert: FleetRun emptyRouteErrorDescription equals: error messageText.
			self assert: (heavyCruiserOnImpulse hasFuel: 50) ]
! !

!FleetRunTests methodsFor: 'tests' stamp: 'HAW 5/6/2025 13:50:17'!
test04FuelOfSpaceshipShouldSufficeSingleNormalPlanetarySectorRunAndSurvive

	| planetarySector fleet heavyCruiserOnImpulse |
	
	heavyCruiserOnImpulse := self newHeavyCruiserShipOnImpulse.
	self assert: (heavyCruiserOnImpulse hasFuel: 50).
	
	fleet := FleetRun assemble: { heavyCruiserOnImpulse }.
	
	planetarySector := self newPlanetarySectorWithGravity: 50 andRadiation: 50.
	
	fleet runThrough: { planetarySector }.
	
	self assert: (fleet isNumberOfSurvivors: 1).
	self assert: (fleet hasSurvived: heavyCruiserOnImpulse ).
	self assert: (heavyCruiserOnImpulse hasFuel: (50 - 10))
	
	
	
	! !

!FleetRunTests methodsFor: 'tests' stamp: 'HAW 5/6/2025 13:50:17'!
test05SpaceshipCanRunOutOfFuelButSurviveAnyway

	| fleet heavyCruiserOnImpulse |
	
	heavyCruiserOnImpulse := self newHeavyCruiserShipOnImpulse.
	self deny: heavyCruiserOnImpulse isDepleted.
	
	fleet := FleetRun assemble: { heavyCruiserOnImpulse }.
	
	fleet runThrough: (self newPlanetarySectorJourneySequenceOfSize: 5 withGravity: 50 withRadiation: 50).
	
	self assert: (fleet isNumberOfSurvivors: 1).
	self assert: (fleet hasSurvived: heavyCruiserOnImpulse ).
	self assert: heavyCruiserOnImpulse isDepleted
	
	
	
	! !

!FleetRunTests methodsFor: 'tests' stamp: 'HAW 5/6/2025 13:50:17'!
test06SpaceshipThatRunsOutOfFuelBeforeFinishingRunDoesntSurvive

	| fleet heavyCruiserOnImpulse |
	
	heavyCruiserOnImpulse := self newHeavyCruiserShipOnImpulse.
	self deny: heavyCruiserOnImpulse isDepleted.

	fleet := FleetRun assemble: { heavyCruiserOnImpulse }.
	
	"Secuencia de 6 sistemas planetarios seguidos..."
	fleet runThrough: (self newPlanetarySectorJourneySequenceOfSize: 6 withGravity: 50 withRadiation: 50).
	
	self assert: (fleet isNumberOfSurvivors: 0).
	self deny: (fleet hasSurvived: heavyCruiserOnImpulse).
	self assert: heavyCruiserOnImpulse isDepleted
	
	
	
	! !

!FleetRunTests methodsFor: 'tests' stamp: 'HAW 5/6/2025 13:50:17'!
test07SpaceshipPassingThroughSectorWithHigherGravityThanManeuverabilityGetsDamaged

	| fleet heavyCruiserOnImpulse |
	
	heavyCruiserOnImpulse := self newHeavyCruiserShipOnImpulse.
	self assert: (heavyCruiserOnImpulse hasDamageLevel: 0).
	self deny: heavyCruiserOnImpulse isDamaged.
	
	fleet := FleetRun assemble: { heavyCruiserOnImpulse }.
	
	fleet runThrough: { self newPlanetarySectorWithGravity: 70 andRadiation: 50 }.
	
	self assert: (fleet isNumberOfSurvivors: 1).
	self assert: (fleet hasSurvived: heavyCruiserOnImpulse ).
	self assert: (heavyCruiserOnImpulse hasDamageLevel: 1).
	self assert: heavyCruiserOnImpulse isDamaged.
	
	
	
	! !

!FleetRunTests methodsFor: 'tests' stamp: 'HAW 5/6/2025 13:50:17'!
test08SpaceshipPassingThroughSectorWithHigherRadiationThanShieldsGetsDamaged

	| fleet heavyCruiserOnImpulse |
	
	heavyCruiserOnImpulse := self newHeavyCruiserShipOnImpulse.
	self assert: (heavyCruiserOnImpulse hasDamageLevel: 0).
	self deny: heavyCruiserOnImpulse isDamaged.

	fleet := FleetRun assemble: { heavyCruiserOnImpulse }.
	
	fleet runThrough: { self newPlanetarySectorWithGravity: 50 andRadiation: 200 }.
	
	self assert: (fleet isNumberOfSurvivors: 1).
	self assert: (fleet hasSurvived: heavyCruiserOnImpulse ).
	self assert: (heavyCruiserOnImpulse hasDamageLevel: 1).
	self assert: heavyCruiserOnImpulse isDamaged.

	
	
	! !

!FleetRunTests methodsFor: 'tests' stamp: 'HAW 5/6/2025 13:50:17'!
test09SpaceshipPassingThroughSectorWithHigherGravityAndRadiationThanManeuverabilityAndShieldsGetsDoubleDamaged

	| fleet heavyCruiserOnImpulse |
	
	heavyCruiserOnImpulse := self newHeavyCruiserShipOnImpulse.
	self assert: (heavyCruiserOnImpulse hasDamageLevel: 0).
	self deny: heavyCruiserOnImpulse isDamaged.

	fleet := FleetRun assemble: { heavyCruiserOnImpulse }.
	
	fleet runThrough: { self newPlanetarySectorWithGravity: 70 andRadiation: 200 }.
	
	self assert: (fleet isNumberOfSurvivors: 1).
	self assert: (fleet hasSurvived: heavyCruiserOnImpulse ).
	self assert: (heavyCruiserOnImpulse hasDamageLevel: 2).
	self assert: heavyCruiserOnImpulse isDamaged.
	
	
	
	! !

!FleetRunTests methodsFor: 'tests' stamp: 'HAW 5/6/2025 13:50:17'!
test10SpaceshipTakingMoreDamageLevelsThanTheirHullCapacityGetsDestroyedAndDoesntSurvive

	| fleet heavyCruiserOnImpulse |
	
	heavyCruiserOnImpulse := self newHeavyCruiserShipOnImpulse.
	self deny: heavyCruiserOnImpulse isDestroyed.
	
	fleet := FleetRun assemble: { heavyCruiserOnImpulse }.
	
	"6 niveles de daño en una clase de naves que sólo admite 5 como máximo..."
	fleet runThrough: (self newPlanetarySectorJourneySequenceOfSize: 3 withGravity: 70 withRadiation: 200).
	
	self assert: (fleet isNumberOfSurvivors: 0).
	self deny: (fleet hasSurvived: heavyCruiserOnImpulse).
	self assert: heavyCruiserOnImpulse isDestroyed
	
	
	
	! !

!FleetRunTests methodsFor: 'tests' stamp: 'HAW 5/6/2025 13:50:17'!
test11IntactHullSpaceshipPassingThroughPlanetarySectorUsingWarpIgnoresRadiationLevelsOfSector

	| fleet smugglerTransportOnWarp |
	
	"Si el casco de la nave no ha sido dañado y se viaja en Warp (o Light Speed, Subluminal, FTL: Faster Than Light, o como tu autor de ciencia ficción favorito lo llame) en un sector de sistema de planetas, se puede pasar tan rápido que se ignoran los efectos de la radiación"
	
	smugglerTransportOnWarp := self newSmugglerTransportShipOnWarp.
	self assert: (smugglerTransportOnWarp hasDamageLevel: 0).
	self deny: smugglerTransportOnWarp isDamaged.

	fleet := FleetRun assemble: { smugglerTransportOnWarp}.
	
	fleet runThrough: { self newPlanetarySectorWithGravity: 50 andRadiation: 200 }.
	
	self assert: (fleet isNumberOfSurvivors: 1).
	self assert: (fleet hasSurvived: smugglerTransportOnWarp).
	self assert: (smugglerTransportOnWarp hasDamageLevel: 0).
	self deny: smugglerTransportOnWarp isDamaged.
	self assert: (smugglerTransportOnWarp hasFuel: (95 - 10)).
	
	"El daño proviene aquí de la alta gravedad y no de la radiación..."	
	fleet runThrough: { self newPlanetarySectorWithGravity: 90 andRadiation: 200 }.
	
	self assert: (fleet isNumberOfSurvivors: 1).
	self assert: (fleet hasSurvived: smugglerTransportOnWarp).
	self assert: (smugglerTransportOnWarp hasDamageLevel: 1).
	self assert: smugglerTransportOnWarp isDamaged.
	self assert: (smugglerTransportOnWarp hasFuel: (95 - 20))
	
	
	
	! !

!FleetRunTests methodsFor: 'tests' stamp: 'HAW 5/6/2025 13:50:17'!
test12SpaceshipPassingThroughAsteroidSystemUsingImpulseThrustersLowersShields

	| fleet smugglerTransportOnImpulse |
	
	"Si el casco de la nave no ha sido dañado y se viaja en un sector de asteroidos utilizando el propulsor básico, los shields indefectiblemente reciben el impacto de los asteroides (nada que pueda hacer el piloto con ese tipo de propulsores) y se reducen permanentemente en 20"
	
	smugglerTransportOnImpulse := self newSmugglerTransportShipOnImpulse.
	self assert: (smugglerTransportOnImpulse hasDamageLevel: 0).
	self deny: smugglerTransportOnImpulse isDamaged.
	self assert: (smugglerTransportOnImpulse hasShieldLevelsAt: 50).

	fleet := FleetRun assemble: { smugglerTransportOnImpulse}.
	
	fleet runThrough: { self newAsteroidsSystemWithGravity: 65 andRadiation: 35 }.
	
	self assert: (fleet isNumberOfSurvivors: 1).
	self assert: (fleet hasSurvived: smugglerTransportOnImpulse).
	self assert: (smugglerTransportOnImpulse hasDamageLevel: 1).
	self assert: smugglerTransportOnImpulse isDamaged.
	self assert: (smugglerTransportOnImpulse hasShieldLevelsAt: 50 - 20).

	
	
	! !

!FleetRunTests methodsFor: 'tests' stamp: 'HAW 5/6/2025 13:50:17'!
test13SpaceshipPassingThroughAsteroidSystemUsingGravitonThrustersIgnoresGravityButConsumesDoubleFuel

	| fleet smugglerTransportOnGravitons |
	
	"Si el casco de la nave no ha sido dañado y se viaja en un sector de asteroides utilizando el avanzado sistema de propulsores basado en Gravitones, el piloto automático de la nave puede sin problema eludirlos sin impactos. Como el piloto no participa, no se tiene en cuenta el rating de maniobrabilidad de la nave, ni la gravedad del sector"
	
	"Al mismo tiempo, lamentablemente el sistema consume el doble de combustible que lo normal"
	
	smugglerTransportOnGravitons := self newSmugglerTransportShipOnGravitons.
	
	fleet := FleetRun assemble: { smugglerTransportOnGravitons}.
	
	"La alta gravedad no son nada para el sistema avanzado de propulsores de Gravitones"
	fleet runThrough: { self newAsteroidsSystemWithGravity: 90 andRadiation: 30 }.
	
	self assert: (fleet isNumberOfSurvivors: 1).
	self assert: (fleet hasSurvived: smugglerTransportOnGravitons).
	self deny: smugglerTransportOnGravitons isDamaged.
	"Doble gasto de combustible"
	self assert: (smugglerTransportOnGravitons hasFuel: (95 - 20)).

	"La radiación del sector es la que produce el daño (60 supera a los 50 de los shields de la nave) y no la gravedad..."
	fleet runThrough: { self newAsteroidsSystemWithGravity: 90 andRadiation: 60 }.
	
	self assert: (fleet isNumberOfSurvivors: 1).
	self assert: (fleet hasSurvived: smugglerTransportOnGravitons).
	self assert: (smugglerTransportOnGravitons hasDamageLevel: 1).
	self assert: smugglerTransportOnGravitons isDamaged.
	"Doble gasto de combustible"
	self assert: (smugglerTransportOnGravitons hasFuel: (95 - 40))
	! !

!FleetRunTests methodsFor: 'tests' stamp: 'HAW 5/6/2025 13:50:17'!
test14SpaceshipPassingThroughAsteroidSystemUsingWarpLowersShieldsToZeroAndGetsDamaged

	| fleet smugglerTransportOnWarp |
	
	"Smuggler Transport Class Ship Stats: Man: 70 Shield: 50 Fuel: 95 HullDamageLevels: 3 Speed: 1"
	
	"Si el casco de la nave no ha sido dañado y se atraviesa un sector de asteroides utilizando warp, vas derecho al desastre... quien sea que haya trazado ese curso estará condenado, porque irá en linea recta contra un cinturón de asteroides a la velocidad de la luz (duh!!). En terminos prácticos, la nave pierde todos sus escudos permanentemente (pasan a 0) debido a los impactos con los asteroides, se le inflinje 1 nivel de daño al casco y además casi seguro se le suma otro nivel más por radiación al esta no contar más con sus escudos"
	
	smugglerTransportOnWarp := self newSmugglerTransportShipOnWarp.
	self assert: (smugglerTransportOnWarp hasDamageLevel: 0).
	self deny: smugglerTransportOnWarp isDamaged.
	self assert: (smugglerTransportOnWarp hasShieldLevelsAt: 50).
	
	fleet := FleetRun assemble: { smugglerTransportOnWarp }.
	
	"Usar Warp con asteroides acaba con los shields y suma 1 nivel de daño al casco".
	"La radición daña al casco de la nave ya que sus shields se reducen a 0"
	fleet runThrough: { self newAsteroidsSystemWithGravity: 65 andRadiation: 30 }.
	
	self assert: (fleet isNumberOfSurvivors: 1).
	self assert: (fleet hasSurvived: smugglerTransportOnWarp).
	self assert: smugglerTransportOnWarp isDamaged.
	self assert: (smugglerTransportOnWarp hasDamageLevel: 2).
	self assert: (smugglerTransportOnWarp hasShieldLevelsAt: 0).
	! !

!FleetRunTests methodsFor: 'tests' stamp: 'HAW 5/6/2025 13:50:17'!
test15SpaceshipPassingThroughNebulaUsingWarpIgnoresAllSectorChecksAndConsumesNoFuel

	| fleet smugglerTransportOnWarp |
	
	"Smuggler Transport Class Ship Stats: Man: 70 Shield: 50 Fuel: 95 HullDamageLevels: 3 Speed: 1"
	
	"Si el casco de la nave no ha sido dañado y se viaja hacia una nebula utilizando Warp, el modulo Warp se revigoriza por un efecto cuántico bien conocido por el contacto con los gases de la nébula, y casi la teletransporta de inmediato al próximo sector galáctico de la trayectoria del viaje. Luego no se consume combustible, y no se efectua ninguno de los chequeos típicos de supervivencia en el sector"
	
	smugglerTransportOnWarp := self newSmugglerTransportShipOnWarp.
	self deny: smugglerTransportOnWarp isDamaged.
	self assert: (smugglerTransportOnWarp hasFuel: 95).

	fleet := FleetRun assemble: { smugglerTransportOnWarp }.
	
	fleet runThrough: { self newNebulaCloudWithGravity: 90 andRadiation: 90 }.
	
	self assert: (fleet isNumberOfSurvivors: 1).
	self assert: (fleet hasSurvived: smugglerTransportOnWarp).
	self deny: smugglerTransportOnWarp isDamaged.
	self assert: (smugglerTransportOnWarp hasFuel: 95).
! !

!FleetRunTests methodsFor: 'tests' stamp: 'HAW 5/6/2025 13:50:17'!
test16SpaceshipPassingThroughNebulaUsingImpulseCosumesFuelsAndIsSubjectToGravityAndRadiation

	| fleet smugglerTransportOnImpulse |
	
	"Smuggler Transport Class Ship Stats: Man: 70 Shield: 50 Fuel: 95 HullDamageLevels: 3 Speed: 1"
		
	smugglerTransportOnImpulse := self newSmugglerTransportShipOnImpulse .
	self deny: smugglerTransportOnImpulse isDamaged.
	self assert: (smugglerTransportOnImpulse hasFuel: 95).

	fleet := FleetRun assemble: { smugglerTransportOnImpulse }.
	
	fleet runThrough: { self newNebulaCloudWithGravity: 90 andRadiation: 90 }.
	
	self assert: (fleet isNumberOfSurvivors: 1).
	self assert: (fleet hasSurvived: smugglerTransportOnImpulse).
	self assert: (smugglerTransportOnImpulse hasDamageLevel: 2).
	self assert: smugglerTransportOnImpulse isDamaged.
	self assert: (smugglerTransportOnImpulse hasFuel: 95 - 10).
! !

!FleetRunTests methodsFor: 'tests' stamp: 'HAW 5/6/2025 13:50:17'!
test17SpaceshipPassingThroughNebulaUsingGravitonsOnlyCosumesFuels

	| fleet smugglerTransportOnGravitons |
	
	"Smuggler Transport Class Ship Stats: Man: 70 Shield: 50 Fuel: 95 HullDamageLevels: 3 Speed: 1"
		
	smugglerTransportOnGravitons := self newSmugglerTransportShipOnGravitons .
	self deny: smugglerTransportOnGravitons isDamaged.
	self assert: (smugglerTransportOnGravitons hasFuel: 95).

	fleet := FleetRun assemble: { smugglerTransportOnGravitons }.
	
	fleet runThrough: { self newNebulaCloudWithGravity: 90 andRadiation: 90 }.
	
	self assert: (fleet isNumberOfSurvivors: 1).
	self assert: (fleet hasSurvived: smugglerTransportOnGravitons).
	self deny: smugglerTransportOnGravitons isDamaged.
	self assert: (smugglerTransportOnGravitons hasFuel: 95 - 20).
! !

!FleetRunTests methodsFor: 'tests' stamp: 'HAW 5/6/2025 13:50:17'!
test18PassingByPlanetarySectorWithGravitonsCosumesDoubleFuel

	| fleet smugglerTransportOnGravitons |
	
	smugglerTransportOnGravitons := self newSmugglerTransportShipOnGravitons .
	self deny: smugglerTransportOnGravitons isDamaged.
	self assert: (smugglerTransportOnGravitons hasFuel: 95).

	fleet := FleetRun assemble: { smugglerTransportOnGravitons }.
	
	fleet runThrough: { self newPlanetarySectorWithGravity: 90 andRadiation: 90 }.
	
	self assert: (fleet isNumberOfSurvivors: 1).
	self assert: (fleet hasSurvived: smugglerTransportOnGravitons).
	self deny: smugglerTransportOnGravitons isDamaged.
	self assert: (smugglerTransportOnGravitons hasFuel: 95 - 20).
! !


!FleetRunTests methodsFor: 'spaceships' stamp: 'HAW 5/6/2025 13:42:36'!
newHeavyCruiserShipOnImpulse

	^SpaceShip heavyCruiserWithThrusters: self impulseThrusters! !

!FleetRunTests methodsFor: 'spaceships' stamp: 'HAW 5/6/2025 13:42:46'!
newLightInterceptorShipOnWarp

	^SpaceShip lightInterceptorWithThrusters: self warpThrusters! !

!FleetRunTests methodsFor: 'spaceships' stamp: 'HAW 5/6/2025 13:43:00'!
newSmugglerTransportShipOnGravitons

	^SpaceShip smugglerTransportWithThrusters: self gravitonsThrusters ! !

!FleetRunTests methodsFor: 'spaceships' stamp: 'HAW 5/6/2025 13:42:36'!
newSmugglerTransportShipOnImpulse

	^SpaceShip smugglerTransportWithThrusters: self impulseThrusters! !

!FleetRunTests methodsFor: 'spaceships' stamp: 'HAW 5/6/2025 13:42:46'!
newSmugglerTransportShipOnWarp

	^SpaceShip smugglerTransportWithThrusters: self warpThrusters! !


!FleetRunTests methodsFor: 'space sectors' stamp: 'MN 5/6/2025 19:18:51'!
newAsteroidsSystemWithGravity: gravity andRadiation: radiation

	^ Sector newAsteroidsSectorWithGravity: gravity andRadiation: radiation.! !

!FleetRunTests methodsFor: 'space sectors' stamp: 'MN 5/6/2025 19:38:25'!
newNebulaCloudWithGravity: gravity andRadiation: radiation

	^ Sector newNebulaSectorWithGravity: gravity andRadiation: radiation.! !

!FleetRunTests methodsFor: 'space sectors' stamp: 'MN 5/6/2025 18:15:19'!
newPlanetarySectorJourneySequenceOfSize: numberOfSectors withGravity: gravity withRadiation: radiation 

	| planetarySectors |
	
	planetarySectors := OrderedCollection new.
	
	numberOfSectors timesRepeat: [ | newSector |
		newSector := self
			newPlanetarySectorWithGravity: gravity
			andRadiation: radiation .
		planetarySectors add: newSector.
	].

	^ planetarySectors ! !

!FleetRunTests methodsFor: 'space sectors' stamp: 'MN 5/6/2025 19:19:04'!
newPlanetarySectorWithGravity: gravity andRadiation: radiation

	^ Sector newPlanetarySectorWithGravity: gravity andRadiation: radiation.! !


!FleetRunTests methodsFor: 'thrusters' stamp: 'MN 5/6/2025 19:27:50'!
gravitonsThrusters

	^ Thrusters newGravitonThrusters . ! !

!FleetRunTests methodsFor: 'thrusters' stamp: 'MN 5/6/2025 17:38:56'!
impulseThrusters

	^ Thrusters newImpulseThrusters .! !

!FleetRunTests methodsFor: 'thrusters' stamp: 'MN 5/6/2025 19:07:44'!
warpThrusters

	^ Thrusters newWarpThrusters! !


!classDefinition: #FleetRun category: #'ISW-Parcial1-1C25'!
Object subclass: #FleetRun
	instanceVariableNames: 'fleet numberOfSurvivors'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-Parcial1-1C25'!

!FleetRun methodsFor: 'initialization' stamp: 'MN 5/6/2025 17:58:42'!
initializeAssemble: aFleet 
	
	fleet := aFleet.
	numberOfSurvivors := aFleet size.! !


!FleetRun methodsFor: 'run by sectors' stamp: 'MN 5/6/2025 18:02:43'!
assertRouteIsNotEmpty: sectors

	^ sectors ifEmpty: [self error: self class emptyRouteErrorDescription]! !

!FleetRun methodsFor: 'run by sectors' stamp: 'MN 5/6/2025 18:49:11'!
countSurvivors

	fleet do: [:spaceship |
		(spaceship hasSurvived and: spaceship isDestroyed not) ifFalse: [
			numberOfSurvivors := numberOfSurvivors - 1
		].
	.]! !

!FleetRun methodsFor: 'run by sectors' stamp: 'MN 5/6/2025 18:16:40'!
everySpaceShipRunsTrough: routeOfSectors

	^ fleet do:[ :spaceship |
		
		spaceship runThroughRoute: routeOfSectors.
		
	]! !

!FleetRun methodsFor: 'run by sectors' stamp: 'MN 5/6/2025 18:17:06'!
runThrough: routeOfSectors 
	
	self assertRouteIsNotEmpty: routeOfSectors.
	
	self everySpaceShipRunsTrough: routeOfSectors.
	
	self countSurvivors.
	
	! !


!FleetRun methodsFor: 'testing' stamp: 'MN 5/6/2025 17:57:40'!
hasSurvived: aSpaceship

	^ aSpaceship hasSurvived.! !

!FleetRun methodsFor: 'testing' stamp: 'MN 5/6/2025 17:58:21'!
isNumberOfSurvivors: aNumber

	 ^ numberOfSurvivors = aNumber ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FleetRun class' category: #'ISW-Parcial1-1C25'!
FleetRun class
	instanceVariableNames: ''!

!FleetRun class methodsFor: 'message error' stamp: 'HAW 5/6/2025 13:26:28'!
allSpaceshipsShouldBeDifferentErrorDescription

	^ 'All the spaceships in the fleet must be unique'! !

!FleetRun class methodsFor: 'message error' stamp: 'HAW 5/6/2025 11:19:11'!
emptyRouteErrorDescription

	^ 'The route cannot be empty'! !

!FleetRun class methodsFor: 'message error' stamp: 'HAW 5/6/2025 13:26:42'!
fleetWithoutSpaceshipsErrorDescription

	^ 'The fleet cannot be empty'! !


!FleetRun class methodsFor: 'instance creation' stamp: 'MN 5/6/2025 17:46:36'!
assemble: aFleet 
	
	self assertFleetIsNotEmpty: aFleet.
	
	self assertFleetHasNoDuplicates: aFleet.
	
	^self new initializeAssemble: aFleet ! !

!FleetRun class methodsFor: 'instance creation' stamp: 'MN 5/6/2025 17:47:14'!
assertFleetHasNoDuplicates: aFleet

	| areAllUnique |
	areAllUnique := aFleet allSatisfy: [:eachSpaceship | (aFleet occurrencesOf: eachSpaceship) = 1].
	
	areAllUnique ifFalse: [self error: self allSpaceshipsShouldBeDifferentErrorDescription ].! !

!FleetRun class methodsFor: 'instance creation' stamp: 'MN 5/6/2025 17:45:37'!
assertFleetIsNotEmpty: aFleet

	^ aFleet ifEmpty: [ self error: self fleetWithoutSpaceshipsErrorDescription ]! !


!classDefinition: #HullState category: #'ISW-Parcial1-1C25'!
Object subclass: #HullState
	instanceVariableNames: 'spaceship'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-Parcial1-1C25'!

!HullState methodsFor: 'testing' stamp: 'MN 5/6/2025 20:43:33'!
isDamaged

	self subclassResponsibility! !


!HullState methodsFor: 'initialization' stamp: 'MN 5/6/2025 20:46:12'!
initializeFor: aSpaceship

	spaceship := aSpaceship ! !


!HullState methodsFor: 'run with impulse' stamp: 'MN 5/6/2025 21:07:39'!
runWithGravitonThrustersThroughAsteroidsSector: sector

	self subclassResponsibility! !

!HullState methodsFor: 'run with impulse' stamp: 'MN 5/6/2025 20:58:01'!
runWithImpulseThrustersThroughAsteroidsSector: sector

	self subclassResponsibility ! !

!HullState methodsFor: 'run with impulse' stamp: 'MN 5/6/2025 20:57:10'!
runWithImpulseThrustersThroughNebulaSector: sector

	self subclassResponsibility! !

!HullState methodsFor: 'run with impulse' stamp: 'MN 5/6/2025 20:57:19'!
runWithImpulseThrustersThroughPlanetarySector: sector

	self subclassResponsibility! !

!HullState methodsFor: 'run with impulse' stamp: 'MN 5/6/2025 21:12:13'!
runWithWarpThrustersThroughAsteroidsSector: sector

	self subclassResponsibility! !

!HullState methodsFor: 'run with impulse' stamp: 'MN 5/6/2025 21:16:49'!
runWithWarpThrustersThroughPlanetarySector: sector

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'HullState class' category: #'ISW-Parcial1-1C25'!
HullState class
	instanceVariableNames: ''!

!HullState class methodsFor: 'instance creation' stamp: 'MN 5/6/2025 20:45:49'!
newFor: spaceship

	^ self new initializeFor: spaceship ! !


!classDefinition: #DamagedHull category: #'ISW-Parcial1-1C25'!
HullState subclass: #DamagedHull
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-Parcial1-1C25'!

!DamagedHull methodsFor: 'testing' stamp: 'MN 5/6/2025 20:47:15'!
isDamaged
	
	^ true! !


!DamagedHull methodsFor: 'run with impulse' stamp: 'MN 5/6/2025 21:07:57'!
runWithGravitonThrustersThroughAsteroidsSector: sector

	spaceship runWithGravitonThrustersWhenDamagedHullThroughAsteroidsSector: sector.! !

!DamagedHull methodsFor: 'run with impulse' stamp: 'MN 5/6/2025 20:58:06'!
runWithImpulseThrustersThroughAsteroidsSector: sector

	spaceship runWithImpulseThrustersWhenDamagedHullThroughAsteroidsSector: sector! !

!DamagedHull methodsFor: 'run with impulse' stamp: 'MN 5/6/2025 20:56:21'!
runWithImpulseThrustersThroughNebulaSector: sector! !

!DamagedHull methodsFor: 'run with impulse' stamp: 'MN 5/6/2025 20:56:26'!
runWithImpulseThrustersThroughPlanetarySector: sector! !

!DamagedHull methodsFor: 'run with impulse' stamp: 'MN 5/6/2025 21:12:34'!
runWithWarpThrustersThroughAsteroidsSector: sector

	spaceship runWithWarpThrustersWhenDamagedHullThroughAsteroidsSector: sector! !

!DamagedHull methodsFor: 'run with impulse' stamp: 'MN 5/6/2025 21:17:47'!
runWithWarpThrustersThroughPlanetarySector: sector

	spaceship runWithWarpThrustersWhenDamagedHullThroughPlanetarySector: sector! !


!classDefinition: #IntactHull category: #'ISW-Parcial1-1C25'!
HullState subclass: #IntactHull
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-Parcial1-1C25'!

!IntactHull methodsFor: 'testing' stamp: 'MN 5/6/2025 20:47:25'!
isDamaged

	^ false! !


!IntactHull methodsFor: 'run with impulse' stamp: 'MN 5/6/2025 21:08:37'!
runWithGravitonThrustersThroughAsteroidsSector: sector

	spaceship runWithGravitonThrustersWhenIntactHullThroughAsteroidsSector: sector. ! !

!IntactHull methodsFor: 'run with impulse' stamp: 'MN 5/6/2025 20:58:21'!
runWithImpulseThrustersThroughAsteroidsSector: sector

	spaceship runWithImpulseThrustersWhenIntactHullThroughAsteroidsSector: sector! !

!IntactHull methodsFor: 'run with impulse' stamp: 'MN 5/6/2025 21:12:54'!
runWithWarpThrustersThroughAsteroidsSector: sector

	spaceship runWithWarpThrustersWhenIntactHullThroughAsteroidsSector: sector ! !

!IntactHull methodsFor: 'run with impulse' stamp: 'MN 5/6/2025 21:17:36'!
runWithWarpThrustersThroughPlanetarySector: sector

	spaceship runWithWarpThrustersWhenIntactHullThroughPlanetarySector: sector ! !


!classDefinition: #Sector category: #'ISW-Parcial1-1C25'!
Object subclass: #Sector
	instanceVariableNames: 'gravity radiation'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-Parcial1-1C25'!

!Sector methodsFor: 'initialization' stamp: 'MN 5/6/2025 20:21:21'!
initializeWithGravity: aGravity andRadiation: aRadiation
	gravity := aGravity.
	radiation := aRadiation.! !


!Sector methodsFor: 'accessing' stamp: 'MN 5/6/2025 18:38:28'!
gravity
	
	^ gravity ! !

!Sector methodsFor: 'accessing' stamp: 'MN 5/6/2025 18:41:11'!
radiation

	^ radiation ! !


!Sector methodsFor: 'run with thrusters' stamp: 'MN 5/6/2025 20:24:10'!
isRunWithGravitonThrustersWithSpaceship: spaceship

	self subclassResponsibility! !

!Sector methodsFor: 'run with thrusters' stamp: 'MN 5/6/2025 20:23:33'!
isRunWithImpulseThrustersWithSpaceship: spaceship

	self subclassResponsibility! !

!Sector methodsFor: 'run with thrusters' stamp: 'MN 5/6/2025 20:23:36'!
isRunWithWarpThrustersWithSpaceship: spaceship

	self subclassResponsibility! !


!Sector methodsFor: 'spaceships' stamp: 'MN 5/6/2025 21:22:57'!
aSpaceshipGetsDamageWithManeuverability: maneuverability

	^ maneuverability < gravity! !

!Sector methodsFor: 'spaceships' stamp: 'MN 5/6/2025 21:24:02'!
aSpaceshipGetsDamageWithShields: shields

	^ shields < radiation! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sector class' category: #'ISW-Parcial1-1C25'!
Sector class
	instanceVariableNames: ''!

!Sector class methodsFor: 'instance creation' stamp: 'MN 5/6/2025 20:19:46'!
newAsteroidsSectorWithGravity: aGravity andRadiation: aRadiation

	^ Asteroids new initializeWithGravity: aGravity andRadiation: aRadiation.! !

!Sector class methodsFor: 'instance creation' stamp: 'MN 5/6/2025 20:20:18'!
newNebulaSectorWithGravity: aGravity andRadiation: aRadiation

	^ Nebula new initializeWithGravity: aGravity andRadiation: aRadiation.! !

!Sector class methodsFor: 'instance creation' stamp: 'MN 5/6/2025 20:20:40'!
newPlanetarySectorWithGravity: aGravity andRadiation: aRadiation

	^ Planetary new initializeWithGravity: aGravity andRadiation: aRadiation.! !


!classDefinition: #Asteroids category: #'ISW-Parcial1-1C25'!
Sector subclass: #Asteroids
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-Parcial1-1C25'!

!Asteroids methodsFor: 'run with thrusters' stamp: 'MN 5/6/2025 20:33:48'!
isRunWithGravitonThrustersWithSpaceship: spaceship

	spaceship runWithGravitonThrustersThroughAsteroidsSector: self! !

!Asteroids methodsFor: 'run with thrusters' stamp: 'MN 5/6/2025 20:25:12'!
isRunWithImpulseThrustersWithSpaceship: spaceship

	spaceship runWithImpulseThrustersThroughAsteroidsSector: self! !

!Asteroids methodsFor: 'run with thrusters' stamp: 'MN 5/6/2025 20:37:51'!
isRunWithWarpThrustersWithSpaceship: spaceship

	spaceship runWithWarpThrustersThroughAsteroidsSector: self! !


!classDefinition: #Nebula category: #'ISW-Parcial1-1C25'!
Sector subclass: #Nebula
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-Parcial1-1C25'!

!Nebula methodsFor: 'run with thrusters' stamp: 'MN 5/6/2025 20:34:03'!
isRunWithGravitonThrustersWithSpaceship: spaceship

	spaceship runWithGravitonThrustersThroughNebulaSector: self! !

!Nebula methodsFor: 'run with thrusters' stamp: 'MN 5/6/2025 20:24:43'!
isRunWithImpulseThrustersWithSpaceship: spaceship

	spaceship runWithImpulseThrustersThroughNebulaSector: self! !

!Nebula methodsFor: 'run with thrusters' stamp: 'MN 5/6/2025 20:38:03'!
isRunWithWarpThrustersWithSpaceship: spaceship

	spaceship runWithWarpThrustersThroughNebulaSector: self! !


!classDefinition: #Planetary category: #'ISW-Parcial1-1C25'!
Sector subclass: #Planetary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-Parcial1-1C25'!

!Planetary methodsFor: 'run with thrusters' stamp: 'MN 5/6/2025 20:34:19'!
isRunWithGravitonThrustersWithSpaceship: spaceship

	spaceship runWithGravitonThrustersThroughPlanetarySector: self
! !

!Planetary methodsFor: 'run with thrusters' stamp: 'MN 5/6/2025 20:24:56'!
isRunWithImpulseThrustersWithSpaceship: spaceship
	
	spaceship runWithImpulseThrustersThroughPlanetarySector: self! !

!Planetary methodsFor: 'run with thrusters' stamp: 'MN 5/6/2025 20:38:12'!
isRunWithWarpThrustersWithSpaceship: spaceship

	spaceship runWithWarpThrustersThroughPlanetarySector: self! !


!classDefinition: #SpaceShip category: #'ISW-Parcial1-1C25'!
Object subclass: #SpaceShip
	instanceVariableNames: 'thrusters maneuverability shields fuel maxDamageLevel damageTaken isAlive isDestroyed hullState'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-Parcial1-1C25'!

!SpaceShip methodsFor: 'initialization' stamp: 'MN 5/6/2025 20:46:26'!
initializeWithThrusters: aThrusters maneuverability: aManeuverability shileds: aShields fuel: aFuel damageLevel: aMaxDamageLevel     
	
	thrusters := aThrusters.
	maneuverability := aManeuverability.
	shields := aShields.
	fuel := aFuel.
	maxDamageLevel := aMaxDamageLevel.
	
	damageTaken := 0.
	hullState := IntactHull newFor: self.
	
	isAlive := true.
	isDestroyed := false.
	! !


!SpaceShip methodsFor: 'testing' stamp: 'MN 5/6/2025 18:46:20'!
hasDamageLevel: aNumber

	^ damageTaken = aNumber ! !

!SpaceShip methodsFor: 'testing' stamp: 'MN 5/6/2025 17:48:58'!
hasFuel: aNumberOfFuel

	^ fuel = aNumberOfFuel! !

!SpaceShip methodsFor: 'testing' stamp: 'MN 5/6/2025 19:26:38'!
hasShieldLevelsAt: aNumber

	^ shields = aNumber ! !

!SpaceShip methodsFor: 'testing' stamp: 'MN 5/6/2025 18:57:29'!
hasSurvived

	^ isAlive and: isDestroyed not.! !

!SpaceShip methodsFor: 'testing' stamp: 'MN 5/6/2025 20:42:57'!
isDamaged

	^ hullState isDamaged! !

!SpaceShip methodsFor: 'testing' stamp: 'MN 5/6/2025 18:28:54'!
isDepleted

	^ fuel <= 0.! !

!SpaceShip methodsFor: 'testing' stamp: 'MN 5/6/2025 18:57:00'!
isDestroyed
	
	^ isDestroyed ! !


!SpaceShip methodsFor: 'run' stamp: 'MN 5/6/2025 20:05:16'!
runThroughRoute: routeOfSectors

	routeOfSectors do: [ :sector |
		
		(isAlive and: isDestroyed not) ifTrue:[
			self runThroughSector: sector
		].
	].! !

!SpaceShip methodsFor: 'run' stamp: 'MN 5/6/2025 20:05:46'!
runThroughSector: sector
		
	thrusters runThroughSector: sector withSpaceship: self

! !


!SpaceShip methodsFor: 'damage and hull state' stamp: 'MN 5/6/2025 21:26:35'!
checkDamageWhen: aCondition
	
	aCondition ifTrue: [
		self takeDamageAndCheckIfDestroyed.
	]! !

!SpaceShip methodsFor: 'damage and hull state' stamp: 'MN 5/6/2025 21:33:09'!
shieldsDamagedBy: aNumber
	shields := shields - aNumber ! !

!SpaceShip methodsFor: 'damage and hull state' stamp: 'MN 5/6/2025 20:45:16'!
takeDamage
	
	hullState := DamagedHull newFor: self.
	^ damageTaken := damageTaken + 1.
	! !

!SpaceShip methodsFor: 'damage and hull state' stamp: 'MN 5/6/2025 19:52:27'!
takeDamageAndCheckIfDestroyed

	self takeDamage.
	damageTaken > maxDamageLevel ifTrue: [
		isDestroyed := true.
	]! !

!SpaceShip methodsFor: 'damage and hull state' stamp: 'MN 5/6/2025 21:27:22'!
updateDamageIfGravityHigherThanManeuverability: sector

	self checkDamageWhen: [sector aSpaceshipGetsDamageWithManeuverability: maneuverability] value.! !

!SpaceShip methodsFor: 'damage and hull state' stamp: 'MN 5/6/2025 21:27:00'!
updateDamageIfRadiationHigherThanShields: sector
	
	self checkDamageWhen: [sector aSpaceshipGetsDamageWithShields: shields] value.
! !


!SpaceShip methodsFor: 'run with impulse' stamp: 'MN 5/6/2025 21:03:58'!
runWithImpulseThrustersThroughAsteroidsSector: sector

	"hago polimorfismo con hull state solo cuando es necesario (es decir, cuando las operaciones sobre
	spaceship cambian segun hull dañado o no), ya que no me da el tiempo para hacer para las 3x3 combinaciones
	de thrusters x sector"
	
	hullState runWithImpulseThrustersThroughAsteroidsSector: sector
! !

!SpaceShip methodsFor: 'run with impulse' stamp: 'MN 5/6/2025 20:17:06'!
runWithImpulseThrustersThroughNebulaSector: sector

	self updateDamageIfRadiationHigherThanShields: sector.
! !

!SpaceShip methodsFor: 'run with impulse' stamp: 'MN 5/6/2025 20:17:12'!
runWithImpulseThrustersThroughPlanetarySector: sector

	self updateDamageIfRadiationHigherThanShields: sector.! !


!SpaceShip methodsFor: 'run by thrusters' stamp: 'MN 5/6/2025 21:30:13'!
runWithGravitonThrustersThroughSector: sector

	self consumeFuelIfRemaining: 20.

	sector isRunWithGravitonThrustersWithSpaceship: self.! !

!SpaceShip methodsFor: 'run by thrusters' stamp: 'MN 5/6/2025 21:29:38'!
runWithImpulseThrustersThroughSector: sector

	sector isRunWithImpulseThrustersWithSpaceship: self.

	self updateDamageIfGravityHigherThanManeuverability: sector.
	self consumeFuelIfRemaining: 10! !

!SpaceShip methodsFor: 'run by thrusters' stamp: 'MN 5/6/2025 20:38:17'!
runWithWarpThrustersThroughSector: sector

	sector isRunWithWarpThrustersWithSpaceship: self.! !


!SpaceShip methodsFor: 'run with graviton' stamp: 'MN 5/6/2025 21:28:19'!
runWithGravitonThrustersThroughAsteroidsSector: sector

	"hago polimorfismo con hull state solo cuando es necesario (es decir, cuando las operaciones sobre
	spaceship cambian segun hull dañado o no), ya que no me da el tiempo para hacer para las 3x3 combinaciones
	de thrusters x sector"

	hullState runWithGravitonThrustersThroughAsteroidsSector: sector.! !

!SpaceShip methodsFor: 'run with graviton' stamp: 'MN 5/6/2025 20:32:39'!
runWithGravitonThrustersThroughNebulaSector: sector! !

!SpaceShip methodsFor: 'run with graviton' stamp: 'MN 5/6/2025 20:32:30'!
runWithGravitonThrustersThroughPlanetarySector: sector! !


!SpaceShip methodsFor: 'run with warp and hull' stamp: 'MN 5/6/2025 21:10:34'!
runWithWarpThrustersWhenDamagedHullThroughAsteroidsSector: sector! !

!SpaceShip methodsFor: 'run with warp and hull' stamp: 'MN 5/6/2025 21:15:57'!
runWithWarpThrustersWhenDamagedHullThroughPlanetarySector: sector

	self updateDamageIfRadiationHigherThanShields: sector.! !

!SpaceShip methodsFor: 'run with warp and hull' stamp: 'MN 5/6/2025 21:32:35'!
runWithWarpThrustersWhenIntactHullThroughAsteroidsSector: sector
	self shieldsDamagedBy: shields.
	self takeDamageAndCheckIfDestroyed.! !

!SpaceShip methodsFor: 'run with warp and hull' stamp: 'MN 5/6/2025 21:15:20'!
runWithWarpThrustersWhenIntactHullThroughPlanetarySector: sector! !


!SpaceShip methodsFor: 'run with warp' stamp: 'MN 5/6/2025 21:29:38'!
runWithWarpThrustersThroughAsteroidsSector: sector

	"hago polimorfismo con hull state solo cuando es necesario (es decir, cuando las operaciones sobre
	spaceship cambian segun hull dañado o no), ya que no me da el tiempo para hacer para las 3x3 combinaciones
	de thrusters x sector"

	hullState runWithWarpThrustersThroughAsteroidsSector: sector.

	self updateDamageIfRadiationHigherThanShields: sector.
	self updateDamageIfGravityHigherThanManeuverability: sector.
	self consumeFuelIfRemaining: 10! !

!SpaceShip methodsFor: 'run with warp' stamp: 'MN 5/6/2025 20:37:14'!
runWithWarpThrustersThroughNebulaSector: sector! !

!SpaceShip methodsFor: 'run with warp' stamp: 'MN 5/6/2025 21:29:38'!
runWithWarpThrustersThroughPlanetarySector: sector

	"hago polimorfismo con hull state solo cuando es necesario (es decir, cuando las operaciones sobre
	spaceship cambian segun hull dañado o no), ya que no me da el tiempo para hacer para las 3x3 combinaciones
	de thrusters x sector"

	hullState runWithWarpThrustersThroughPlanetarySector: sector.

	self updateDamageIfGravityHigherThanManeuverability: sector.
	self consumeFuelIfRemaining: 10! !


!SpaceShip methodsFor: 'fuel' stamp: 'MN 5/6/2025 21:29:54'!
consumeFuelIfRemaining: anAmountOfFuel

	fuel - anAmountOfFuel >= 0 ifTrue: [
		fuel := fuel - anAmountOfFuel.
	] ifFalse: [
		isAlive := false.
		fuel := 0.
	].! !


!SpaceShip methodsFor: 'run with impulse and hull' stamp: 'MN 5/6/2025 20:51:51'!
runWithImpulseThrustersWhenDamagedHullThroughAsteroidsSector: sector! !

!SpaceShip methodsFor: 'run with impulse and hull' stamp: 'MN 5/6/2025 21:32:40'!
runWithImpulseThrustersWhenIntactHullThroughAsteroidsSector: sector
	self takeDamageAndCheckIfDestroyed.
	self shieldsDamagedBy: 20.	! !


!SpaceShip methodsFor: 'run with graviton and hull' stamp: 'MN 5/6/2025 21:06:38'!
runWithGravitonThrustersWhenDamagedHullThroughAsteroidsSector: sector

	^ self updateDamageIfRadiationHigherThanShields: sector! !

!SpaceShip methodsFor: 'run with graviton and hull' stamp: 'MN 5/6/2025 21:05:11'!
runWithGravitonThrustersWhenIntactHullThroughAsteroidsSector: sector

	^ self updateDamageIfRadiationHigherThanShields: sector! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SpaceShip class' category: #'ISW-Parcial1-1C25'!
SpaceShip class
	instanceVariableNames: ''!

!SpaceShip class methodsFor: 'instance creation' stamp: 'HAW 5/6/2025 11:29:22'!
heavyCruiserWithThrusters: aThrusters 
	
	^self new initializeWithThrusters: aThrusters maneuverability: 50 shileds: 100 fuel: 50 damageLevel: 5 ! !

!SpaceShip class methodsFor: 'instance creation' stamp: 'HAW 5/6/2025 11:32:34'!
lightInterceptorWithThrusters: aThrusters 
	
	^self new initializeWithThrusters: aThrusters maneuverability: 90 shileds: 30 fuel: 30 damageLevel: 2 
! !

!SpaceShip class methodsFor: 'instance creation' stamp: 'HAW 5/6/2025 11:33:41'!
smugglerTransportWithThrusters: aThrusters 
	
	^self new initializeWithThrusters: aThrusters maneuverability: 70 shileds: 50 fuel: 95 damageLevel: 2 
! !


!classDefinition: #Thrusters category: #'ISW-Parcial1-1C25'!
Object subclass: #Thrusters
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-Parcial1-1C25'!

!Thrusters methodsFor: 'spaceship runs by sector' stamp: 'MN 5/6/2025 20:04:43'!
runThroughSector: sector withSpaceship: spaceship 

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Thrusters class' category: #'ISW-Parcial1-1C25'!
Thrusters class
	instanceVariableNames: ''!

!Thrusters class methodsFor: 'instance creation' stamp: 'MN 5/6/2025 20:07:03'!
newGravitonThrusters

	^ GravitonThrusters new.! !

!Thrusters class methodsFor: 'instance creation' stamp: 'MN 5/6/2025 20:07:10'!
newImpulseThrusters

	^ ImpulseThrusters new.! !

!Thrusters class methodsFor: 'instance creation' stamp: 'MN 5/6/2025 20:07:18'!
newWarpThrusters

	^ WarpThrusters new.! !


!classDefinition: #GravitonThrusters category: #'ISW-Parcial1-1C25'!
Thrusters subclass: #GravitonThrusters
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-Parcial1-1C25'!

!GravitonThrusters methodsFor: 'spaceship runs by sector' stamp: 'MN 5/6/2025 20:04:43'!
runThroughSector: sector withSpaceship: spaceship 

	spaceship runWithGravitonThrustersThroughSector: sector. ! !


!classDefinition: #ImpulseThrusters category: #'ISW-Parcial1-1C25'!
Thrusters subclass: #ImpulseThrusters
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-Parcial1-1C25'!

!ImpulseThrusters methodsFor: 'spaceship runs by sector' stamp: 'MN 5/6/2025 20:04:43'!
runThroughSector: sector withSpaceship: spaceship 

	spaceship runWithImpulseThrustersThroughSector: sector. ! !


!classDefinition: #WarpThrusters category: #'ISW-Parcial1-1C25'!
Thrusters subclass: #WarpThrusters
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-Parcial1-1C25'!

!WarpThrusters methodsFor: 'spaceship runs by sector' stamp: 'MN 5/6/2025 20:04:43'!
runThroughSector: sector withSpaceship: spaceship 

	spaceship runWithWarpThrustersThroughSector: sector! !
