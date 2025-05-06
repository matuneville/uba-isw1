!classDefinition: #FloorTest category: #'ISW1-2024-1C-Parcial'!
TestCase subclass: #FloorTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial'!

!FloorTest methodsFor: 'testing' stamp: 'HAW 4/26/2024 16:54:55'!
test01CannotCreateFloorWithoutRooms

	self
		should: [ self createFloorWith: 0 and: self defaultPriceList ]
		raise: Error - MessageNotUnderstood 
		withMessageText: Floor numberOfRoomsMustBePositiveErrorDescription ! !

!FloorTest methodsFor: 'testing' stamp: 'HAW 4/26/2024 16:55:02'!
test02CannotCreateFloorWithNoIntergerNumberOfRooms

	self
		should: [ self createFloorWith: 1.5 and: self defaultPriceList ]
		raise: Error - MessageNotUnderstood 
		withMessageText: Floor numberOfRoomsMustBeIntegerErrorDescription ! !

!FloorTest methodsFor: 'testing' stamp: 'HAW 4/26/2024 16:55:06'!
test03CannotCreateFloorWithoutPrices

	self
		should: [ self createFloorWith: 10 and:  Dictionary new ]
		raise: Error - MessageNotUnderstood 
		withMessageText: Floor pricesListCannotBeEmptyErrorDescription ! !

!FloorTest methodsFor: 'testing' stamp: 'FRT 4/21/2024 16:53:28'!
test04WhenAFloorIsCreatedAllTheRoomsAreAvailable

	| floor |
	
	floor := self createFloorWith: 10 and: self defaultPriceList.
	
	self assert: floor isAvailable.
	self assert: 0 equals: floor totalRoomsOccupied.
	self assert: 0 equals: floor totalRoomsReserved.
! !

!FloorTest methodsFor: 'testing' stamp: 'MN 5/2/2025 13:05:44'!
test05WhenAFloorReceivesAGuestInARoomReducesTheAvailableRoomsByOneAndIncreaseOccupiedByOne

	| floor roomsNumber |
	
	roomsNumber := 10.
	floor := self createFloorWith: roomsNumber and: self defaultPriceList.
	
	"Tech Debt"
	(floor roomAt: 1) receive: self guestTypeVacation.
	
	self assert: roomsNumber - 1 equals: floor totalRoomsAvailable. 
	self assert: 1 equals: floor totalRoomsOccupied.
	self assert: 0 equals: floor totalRoomsReserved.
! !

!FloorTest methodsFor: 'testing' stamp: 'MN 5/2/2025 13:06:39'!
test06WhenAFloorReceivesOnReservationAGuestInARoomKeepsTheAvailableRoomsAndOccupiedAndReducesTheReservedByOne

	| floor roomsNumber roomsAvailable roomsOccupied roomsReserved |
	
	roomsNumber := 10.
	floor := self createFloorWith: roomsNumber and: self defaultPriceList.
	
	"Tech Debt"
	(floor roomAt: 1) reserve.

	roomsAvailable := floor totalRoomsAvailable.
	roomsOccupied := floor totalRoomsOccupied.
	roomsReserved := floor totalRoomsReserved.

	"Tech Debt"
	(floor roomAt: 1) receiveWithReservation: self guestTypeVacation.
	
	self assert: roomsAvailable equals: floor totalRoomsAvailable. 
	self assert: roomsOccupied equals: floor totalRoomsOccupied.
	self assert: roomsReserved - 1 equals: floor totalRoomsReserved.
! !

!FloorTest methodsFor: 'testing' stamp: 'MN 5/2/2025 13:05:08'!
test07WhenARoomIsReservedTheFloorAvailableRoomsReducesByOneAndIncreaseReservedAndOccupiedByOne

	| floor roomsNumber |
	
	roomsNumber := 10.
	floor := self createFloorWith: roomsNumber and: self defaultPriceList.
	
	"Tech Debt"
	(floor roomAt: 1) reserve.
	
	self assert: roomsNumber - 1 equals: floor totalRoomsAvailable. 
	self assert: 1 equals: floor totalRoomsOccupied.
	self assert: 1 equals: floor totalRoomsReserved.
! !

!FloorTest methodsFor: 'testing' stamp: 'MN 5/2/2025 13:05:25'!
test08TotalProfitShouldBeTheSumOfOccupiedRoomsProfits

	| floor roomsNumber |
	
	roomsNumber := 10.
	floor := self createFloorWith: roomsNumber and: self defaultPriceList.
	
	"Tech Debt"
	(floor roomAt: 1) receive: self guestTypeVacation.
	(floor roomAt: 2) receive: self guestTypeConference.
	(floor roomAt: 3) reserve.
		
	self assert: (100*peso) + (200*peso) + (50*peso) equals: floor totalProfits
! !

!FloorTest methodsFor: 'testing' stamp: 'MN 5/2/2025 13:05:38'!
test09TotalLossesShouldBeTheSumOfAvailableRoomsLosses

	| floor roomsNumber |
	
	roomsNumber := 10.
	floor := self createFloorWith: roomsNumber and: self defaultPriceList.
	
	"Tech Debt"
	(floor roomAt: 1) receive: self guestTypeVacation.
	(floor roomAt: 2) receive: self guestTypeConference.
	(floor roomAt: 3) reserve.
		
	self assert: (200*peso) * 7 equals: floor totalLosses
! !


!FloorTest methodsFor: 'create' stamp: 'MN 4/29/2025 15:39:02'!
createFloorWith: aNumberOfRooms and: aPriceList

	| floor |

	floor := Floor newWithTotalRooms: aNumberOfRooms andPriceList: aPriceList.
	
	^ floor.! !

!FloorTest methodsFor: 'create' stamp: 'FRT 4/21/2024 17:01:23'!
defaultPriceList
	
	^ Dictionary new
		at: self guestTypeVacation put: 100*peso;
		at: self guestTypeConference put: 200*peso;
		yourself ! !

!FloorTest methodsFor: 'create' stamp: 'FRT 4/21/2024 17:00:09'!
guestTypeConference
	
	^ #conferenceGuest! !

!FloorTest methodsFor: 'create' stamp: 'FRT 4/21/2024 17:00:42'!
guestTypeVacation
	
	^ #vacationGuest! !


!classDefinition: #HotelTest category: #'ISW1-2024-1C-Parcial'!
TestCase subclass: #HotelTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial'!

!HotelTest methodsFor: 'testing' stamp: 'MN 5/2/2025 09:57:27'!
test01CannotCreateHotelWithoutFloors

	self
		should: [ Hotel newWithFloors: OrderedCollection new. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: Hotel noFloorsErrorDescription.! !

!HotelTest methodsFor: 'testing' stamp: 'FRT 4/22/2024 11:30:09'!
test02NewHotelsAreEmpty

	| hotel |
	
	hotel := self createHotel.
	
	self assert: hotel isEmpty.! !

!HotelTest methodsFor: 'testing' stamp: 'HAW 4/29/2024 11:18:22'!
test03HotelCanReceiveATypeOfGuestInRoomAtFloor

	| hotel |
	
	hotel := self createHotel.
	
	self assert: hotel totalRooms equals: hotel	 totalRoomsAvailable.

	hotel receive: self guestTypeVacation atFloor: 1 atRoom: 2.

	self assert: hotel	 totalRooms - 1 equals: hotel totalRoomsAvailable.
	self assert: 0 equals: hotel totalRoomsReserved.
	self assert: 1 equals: hotel totalRoomsOccupied.
! !

!HotelTest methodsFor: 'testing' stamp: 'HAW 4/29/2024 11:18:32'!
test04HotelCanTakeAReservationForARoomAtFloor

	| hotel |
	
	hotel := self createHotel.

	self assert: hotel totalRooms equals: hotel	 totalRoomsAvailable.

	hotel reserveRoom: 2 atFloor: 1.

	self assert: hotel	 totalRooms - 1 equals: hotel totalRoomsAvailable.
	self assert: 1 equals: hotel totalRoomsReserved.
	self assert: 1 equals: hotel totalRoomsOccupied.! !

!HotelTest methodsFor: 'testing' stamp: 'HAW 4/29/2024 11:18:41'!
test05HotelCanReceiveWithReservationATypeOfGuestInRoomAtFloor

	| hotel |
	
	hotel := self createHotel.
	
	self assert: hotel totalRooms equals: hotel	 totalRoomsAvailable.

	hotel reserveRoom: 2 atFloor: 1.
	hotel receiveWithReservation: self guestTypeVacation atFloor: 1 atRoom: 2.

	self assert: hotel	 totalRooms - 1 equals: hotel totalRoomsAvailable.
	self assert: 0 equals: hotel totalRoomsReserved.
	self assert: 1 equals: hotel totalRoomsOccupied.
! !

!HotelTest methodsFor: 'testing' stamp: 'HAW 4/29/2024 11:17:34'!
test06HotelCannotReceiveWithReservationWithoutPreviousReservation
	
	| hotel |
	
	hotel := self createHotel.
	
	self assert: hotel totalRooms equals: hotel	 totalRoomsAvailable.

	self 
		should: [ 	hotel receiveWithReservation: self guestTypeVacation atFloor: 1 atRoom: 2. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [		:error |	
			self assert: Room roomIsNotReservedErrorDescription equals: error messageText.
			
			self assert: hotel	 totalRooms equals: hotel totalRoomsAvailable.
			self assert: 0 equals: hotel totalRoomsReserved.
			self assert: 0 equals: hotel totalRoomsOccupied.
		]


! !

!HotelTest methodsFor: 'testing' stamp: 'MN 5/2/2025 09:57:32'!
test07HotelProfitsAreTheSumOfEachFloorProfits
	
	| hotel floor1 floor2 floors |
	
	
	floor1 := self createFloorWith: 10 and: self defaultPriceList.
	floor2 := self createFloorWith: 10 and: self defaultPriceList.

	floors := OrderedCollection with: floor1 with: floor2.
	hotel := 	Hotel newWithFloors: floors.
	
	hotel receive: self guestTypeVacation atFloor: 1 atRoom: 1.
	hotel receive: self guestTypeConference atFloor: 2 atRoom: 1.

	self assert: floor1 totalProfits + floor2 totalProfits equals:		hotel totalProfits.! !

!HotelTest methodsFor: 'testing' stamp: 'MN 5/2/2025 09:57:38'!
test08HotelLossesAreTheSumOfEachFloorLosses
	
	| hotel floor1 floor2 floors |
	
	
	floor1 := self createFloorWith: 10 and: self defaultPriceList.
	floor2 := self createFloorWith: 10 and: self defaultPriceList.

	floors := OrderedCollection with: floor1 with: floor2.
	hotel := 	Hotel newWithFloors: floors.
	
	hotel receive: self guestTypeVacation atFloor: 1 atRoom: 1.
	hotel receive: self guestTypeConference atFloor: 2 atRoom: 1.

	hotel reserveRoom: 4 atFloor: 1.
	hotel reserveRoom: 2 atFloor: 2.

	self assert: floor1 totalLosses + floor2 totalLosses equals:		hotel totalLosses.! !

!HotelTest methodsFor: 'testing' stamp: 'MN 5/2/2025 09:57:41'!
test09HotelCannotReserveANonexistentRoom
	
	| hotel floor1 floors |
	
	floor1 := self createFloorWith: 10 and: self defaultPriceList.

	floors := OrderedCollection with: floor1.
	hotel := 	Hotel newWithFloors: floors.
	
	self 
	should: [ 	hotel reserveRoom: 42 atFloor: 1. ]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [		:error |	
		self assert: Hotel roomNumberDoesNotExistErrorDescription equals: error messageText.
		
		self assert: hotel	 totalRooms equals: hotel totalRoomsAvailable.
		self assert: 0 equals: hotel totalRoomsReserved.
		self assert: 0 equals: hotel totalRoomsOccupied.
	]
! !

!HotelTest methodsFor: 'testing' stamp: 'MN 5/2/2025 09:57:44'!
test10HotelCannotReserveANonexistentFloor
	
	| hotel floor1 floors |
	
	floor1 := self createFloorWith: 10 and: self defaultPriceList.

	floors := OrderedCollection with: floor1.
	hotel := 	Hotel newWithFloors: floors.
	
	self 
	should: [ 	hotel reserveRoom: 1 atFloor: 42. ]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [		:error |	
		self assert: Hotel floorNumberDoesNotExistErrorDescription equals: error messageText.
		
		self assert: hotel	 totalRooms equals: hotel totalRoomsAvailable.
		self assert: 0 equals: hotel totalRoomsReserved.
		self assert: 0 equals: hotel totalRoomsOccupied.
	]! !

!HotelTest methodsFor: 'testing' stamp: 'MN 5/2/2025 09:57:47'!
test11HotelCannotReceiveAtNonexistentRoom
	
	| hotel floor1 floors |
	
	floor1 := self createFloorWith: 10 and: self defaultPriceList.

	floors := OrderedCollection with: floor1.
	hotel := 	Hotel newWithFloors: floors.
	
	self 
	should: [ 	hotel receive: self guestTypeVacation atFloor: 1 atRoom: 42. ]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [		:error |	
		self assert: Hotel roomNumberDoesNotExistErrorDescription equals: error messageText.
		
		self assert: hotel	 totalRooms equals: hotel totalRoomsAvailable.
		self assert: 0 equals: hotel totalRoomsReserved.
		self assert: 0 equals: hotel totalRoomsOccupied.
	]! !

!HotelTest methodsFor: 'testing' stamp: 'MN 5/2/2025 09:57:49'!
test12HotelCannotReceiveAtNonexistentFloor
	
	| hotel floor1 floors |
	
	floor1 := self createFloorWith: 10 and: self defaultPriceList.

	floors := OrderedCollection with: floor1.
	hotel := 	Hotel newWithFloors: floors.
	
	self 
	should: [ 	hotel receive: self guestTypeVacation atFloor: 42 atRoom: 1. ]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [		:error |	
		self assert: Hotel floorNumberDoesNotExistErrorDescription equals: error messageText.
		
		self assert: hotel	 totalRooms equals: hotel totalRoomsAvailable.
		self assert: 0 equals: hotel totalRoomsReserved.
		self assert: 0 equals: hotel totalRoomsOccupied.
	]! !

!HotelTest methodsFor: 'testing' stamp: 'MN 5/2/2025 09:57:51'!
test13HotelCannotReceiveWithReservationAtNonexistentRoom
	
	| hotel floor1 floors |
	
	floor1 := self createFloorWith: 10 and: self defaultPriceList.

	floors := OrderedCollection with: floor1.
	hotel := 	Hotel newWithFloors: floors.

	hotel reserveRoom: 1 atFloor: 1. 
	
	self 
	should: [ 	hotel receiveWithReservation: self guestTypeVacation atFloor: 1 atRoom: 42. ]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [		:error |	
		self assert: Hotel roomNumberDoesNotExistErrorDescription equals: error messageText.
		
		self assert: hotel	 totalRooms - 1 equals: hotel totalRoomsAvailable.
		self assert: 1 equals: hotel totalRoomsReserved.
		self assert: 1 equals: hotel totalRoomsOccupied.
	]! !


!HotelTest methodsFor: 'create' stamp: 'MN 4/29/2025 16:03:41'!
createFloorWith: aNumberOfRooms and: aPriceList

	| floor |

	floor := Floor newWithTotalRooms: aNumberOfRooms andPriceList: aPriceList.
	
	^ floor.! !

!HotelTest methodsFor: 'create' stamp: 'MN 4/29/2025 16:01:48'!
createHotel
	
	| floors |
	
	floors := (OrderedCollection
		with: (self createFloorWith: 10 and: self defaultPriceList)
		with: (self createFloorWith: 1 and: self defaultPriceList)).
	
	^ Hotel newWithFloors: floors.! !

!HotelTest methodsFor: 'create' stamp: 'FRT 4/22/2024 10:27:22'!
defaultPriceList
	
	^ Dictionary new
		at: self guestTypeVacation put: self minPriceInList;
		at: self guestTypeConference put: self maxPriceInList;
		yourself ! !

!HotelTest methodsFor: 'create' stamp: 'FRT 4/22/2024 10:27:36'!
guestTypeConference
	
	^ #conferenceGuest! !

!HotelTest methodsFor: 'create' stamp: 'FRT 4/22/2024 10:27:42'!
guestTypeVacation
	
	^ #vacationGuest! !

!HotelTest methodsFor: 'create' stamp: 'FRT 4/22/2024 10:27:48'!
maxPriceInList
	
	^ 200*peso ! !

!HotelTest methodsFor: 'create' stamp: 'FRT 4/22/2024 10:27:53'!
minPriceInList
	
	^ 100*peso ! !


!classDefinition: #RoomTest category: #'ISW1-2024-1C-Parcial'!
TestCase subclass: #RoomTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial'!

!RoomTest methodsFor: 'testing' stamp: 'FRT 4/21/2024 22:11:08'!
test01NewRoomsAreAvailable

	| room |
	
	room := Room new.

	self assert: room isAvailable.
	
	self deny: room isOccupied.
	self deny: room isReserved.! !

!RoomTest methodsFor: 'testing' stamp: 'FRT 4/22/2024 09:03:07'!
test02ReceivingAGuestMakesTheRoomOccupied

	| room |
	
	room := Room new.

	room receive: self guestTypeVacation.

	self assert: room isOccupied.

	self deny: room isAvailable.
	self deny: room isReserved.! !

!RoomTest methodsFor: 'testing' stamp: 'FRT 4/22/2024 09:04:16'!
test03ReservingARoomMakesTheRoomReservedAndOccupied

	| room |
	
	room := Room new.

	room reserve.

	self assert: room isReserved.
	self assert: room isOccupied.

	self deny: room isAvailable.
! !

!RoomTest methodsFor: 'testing' stamp: 'HAW 4/26/2024 17:30:25'!
test04CannotReceiveAGuestInAOccupiedRoom

	| room |
	
	room := Room new.

	room receive: self guestTypeVacation.
	
	self 
		should: [ room receive: self guestTypeVacation ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo:  [ 	:error |
			self assert: Room roomIsNotEmptyErrorDescription equals: error messageText.

			self assert: room isOccupied.
			
			self deny: room isAvailable.
			self deny: room isReserved.
		]
	
! !

!RoomTest methodsFor: 'testing' stamp: 'HAW 4/26/2024 17:30:32'!
test05CannotReceiveAGuestInAReservedRoom

	| room |
	
	room := Room new.

	room reserve.
	
	self 
		should: [ room receive: self guestTypeVacation ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo:  [ 	:error |
			self assert: Room roomIsNotEmptyErrorDescription equals: error messageText.
			
			self assert: room isReserved.
			self assert: room isOccupied.
			
			self deny: room isAvailable.
		]

	

	
! !

!RoomTest methodsFor: 'testing' stamp: 'FRT 4/22/2024 11:58:29'!
test06ReceivingOnReservationMakesTheRoomOccupied

	| room |
	
	room := Room new.

	room reserve.
	
	room receiveWithReservation: self guestTypeVacation.
	
	self assert: room isOccupied.
	
	self deny: room isReserved.
	self deny: room isAvailable.
! !

!RoomTest methodsFor: 'testing' stamp: 'HAW 4/26/2024 17:30:40'!
test07CannotReceiveOnReservationAnAvailableRoom

	| room |
	
	room := Room new.

	self 
		should: [ room receiveWithReservation: self guestTypeVacation. ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo:  [ 	:error |
			self assert: Room roomIsNotReservedErrorDescription equals: error messageText.

			self assert: room isAvailable.

			self deny: room isReserved.
			self deny: room isOccupied.
		]

	
! !

!RoomTest methodsFor: 'testing' stamp: 'HAW 4/26/2024 17:30:50'!
test08CannotReceiveOnReservationAnOccupiedRoom

	| room |
	
	room := Room new.

	room receive: self guestTypeVacation.

	self 
		should: [ room receiveWithReservation: self guestTypeVacation. ] 
		raise: Error - MessageNotUnderstood 	
		withExceptionDo:  [ 	:error |
			self assert: Room roomIsNotReservedErrorDescription equals: error messageText.
			
			self assert: room isOccupied.

			self deny: room isReserved.
			self deny: room isAvailable.
		]

	
! !

!RoomTest methodsFor: 'testing' stamp: 'FRT 4/22/2024 09:22:02'!
test09ProfitOfAvailableRoomIsCeroPesos

	| room |
	
	room := Room new.

	self assert: 0*peso equals: (room profitUsing: self defaultPriceList ifAbsentGuestType: [ self fail ]).
	
! !

!RoomTest methodsFor: 'testing' stamp: 'HAW 4/29/2024 11:22:57'!
test10ProfitOfReservedRoomIsHalfTheMinPriceInList

	| room |
	
	room := Room new.

	room reserve.

	self assert: self minPriceInList / 2 equals: (room profitUsing: self defaultPriceList ifAbsentGuestType: [ self fail ]).
! !

!RoomTest methodsFor: 'testing' stamp: 'FRT 4/22/2024 09:45:00'!
test11ProfitOfOccupiedRoomDependsOnGuestType

	| roomWithConferenceGuest roomWithVacationGuest |
	
	roomWithConferenceGuest := Room new.
	roomWithConferenceGuest receive: self guestTypeConference.
	
	roomWithVacationGuest := Room new.
	roomWithVacationGuest receive: self guestTypeVacation.

	self assert: (self defaultPriceList at: self guestTypeConference) 
		equals: (roomWithConferenceGuest profitUsing: self defaultPriceList ifAbsentGuestType: [ self fail ]).

	self assert: (self defaultPriceList at: self guestTypeVacation) 
		equals: (roomWithVacationGuest profitUsing: self defaultPriceList ifAbsentGuestType: [ self fail ]).
! !

!RoomTest methodsFor: 'testing' stamp: 'FRT 4/22/2024 09:52:21'!
test12NoProfitOnOccupiedRoomByUnknownGuestType

	| room |
	
	room := Room new.
	room receive: #unknownGuest.
	
	room profitUsing: self defaultPriceList ifAbsentGuestType: [ ^self ].
	
	"we should not get here"
	self failWith: 'should not calculate profit on room occupied by unknown guest type'.
! !

!RoomTest methodsFor: 'testing' stamp: 'MN 5/2/2025 13:15:56'!
test13LossesOfAvailableRoomIsTheMaxPriceInList

	| room |

	room := Room new.

	self assert: self maxPriceInList equals: (room lossUsing: self defaultPriceList ifAbsentGuestType: [ self fail ]).
! !

!RoomTest methodsFor: 'testing' stamp: 'MN 5/2/2025 13:16:10'!
test14LossesOfReservedRoomIsCeroPesos


	| room |

	room := Room new.

	room reserve.

	self assert: 0*peso equals: (room lossUsing: self defaultPriceList ifAbsentGuestType: [ self fail ]).
! !

!RoomTest methodsFor: 'testing' stamp: 'MN 5/2/2025 13:16:18'!
test15LossesOfOccupiedRoomIsCeroPesos

	| room |

	room := Room new.

	room receive: self guestTypeVacation.

	self assert: 0*peso equals: (room lossUsing: self defaultPriceList ifAbsentGuestType: [ self fail ]).! !

!RoomTest methodsFor: 'testing' stamp: 'HAW 4/28/2024 15:53:31'!
test16CannotReserveWhenReserved

	| room |
	
	room := Room new.

	room reserve.

	self 
		should: [ room reserve ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Room roomIsNotEmptyErrorDescription equals: anError messageText.
			self assert: room isReserved ].! !

!RoomTest methodsFor: 'testing' stamp: 'HAW 4/28/2024 15:53:48'!
test17CannotReserveWhenOccupied

	| room |
	
	room := Room new.

	room receive: self guestTypeVacation.

	self 
		should: [ room reserve ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Room roomIsNotEmptyErrorDescription equals: anError messageText.
			self assert: room isOccupied ].! !


!RoomTest methodsFor: 'create' stamp: 'FRT 4/22/2024 10:16:28'!
defaultPriceList
	
	^ Dictionary new
		at: self guestTypeVacation put: self minPriceInList;
		at: self guestTypeConference put: self maxPriceInList;
		yourself ! !

!RoomTest methodsFor: 'create' stamp: 'FRT 4/22/2024 09:20:45'!
guestTypeConference
	
	^ #conferenceGuest! !

!RoomTest methodsFor: 'create' stamp: 'FRT 4/22/2024 09:02:15'!
guestTypeVacation
	
	^ #vacationGuest! !

!RoomTest methodsFor: 'create' stamp: 'FRT 4/22/2024 10:16:13'!
maxPriceInList
	
	^ 200*peso ! !

!RoomTest methodsFor: 'create' stamp: 'FRT 4/22/2024 09:40:38'!
minPriceInList
	
	^ 100*peso ! !


!classDefinition: #Floor category: #'ISW1-2024-1C-Parcial'!
Object subclass: #Floor
	instanceVariableNames: 'rooms prices'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial'!

!Floor methodsFor: 'testing' stamp: 'FRT 4/21/2024 15:02:31'!
isAvailable
	
	^ self totalRooms = self totalRoomsAvailable

		
! !


!Floor methodsFor: 'accessing' stamp: 'MN 5/2/2025 13:06:20'!
roomAt: aRoomNumber 
	^ rooms at: aRoomNumber! !

!Floor methodsFor: 'accessing' stamp: 'MN 5/2/2025 12:57:11'!
roomAt: aRoomNumber ifAbsent: aBlock
	^ rooms at: aRoomNumber ifAbsent: aBlock! !


!Floor methodsFor: 'accounting' stamp: 'FRT 4/21/2024 13:23:04'!
totalLosses
	
	| total |
	
	total := 0*peso.
	rooms do: [ :room | room isAvailable ifTrue: [ total := total + prices values max ] ].

	^ total

		
! !

!Floor methodsFor: 'accounting' stamp: 'FRT 4/21/2024 22:06:47'!
totalProfits

	| total |
	
	total := 0*peso.
	rooms do: [ :room | | roomTotal | 
		room isOccupied ifTrue: [
			roomTotal := 	room profitUsing: prices ifAbsentGuestType: [ self class signalUnknownGuestType ].
			total := total + roomTotal.
		]
	].

	^ total
! !


!Floor methodsFor: 'totals' stamp: 'FRT 4/21/2024 14:49:55'!
totalRooms
	
	^ rooms size
		
! !

!Floor methodsFor: 'totals' stamp: 'HAW 4/28/2024 16:49:36'!
totalRoomsAvailable
	
	^rooms count: [ :room | room isAvailable ]
		
! !

!Floor methodsFor: 'totals' stamp: 'HAW 4/28/2024 16:49:47'!
totalRoomsOccupied
	
	^rooms count: [ :room | room isOccupied ]
		
! !

!Floor methodsFor: 'totals' stamp: 'HAW 4/28/2024 16:50:07'!
totalRoomsReserved
	
	^rooms count: [ :room | room isReserved ]! !


!Floor methodsFor: 'initialization' stamp: 'MN 4/29/2025 16:17:58'!
createRooms: aNumberOfRooms

	rooms := OrderedCollection new.
	
	aNumberOfRooms timesRepeat: [
		rooms add: Room new.
	]! !

!Floor methodsFor: 'initialization' stamp: 'MN 4/29/2025 16:17:58'!
initializeWithTotalRooms: aNumberOfRooms andPriceList: aPriceList
	
	self createRooms: aNumberOfRooms.
	
	prices := aPriceList.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Floor class' category: #'ISW1-2024-1C-Parcial'!
Floor class
	instanceVariableNames: ''!

!Floor class methodsFor: 'assertions' stamp: 'FRT 4/20/2024 19:39:26'!
assertIsInteger: aNumber ifFalse: signalsBlock

	aNumber isInteger ifFalse: signalsBlock! !

!Floor class methodsFor: 'assertions' stamp: 'FRT 4/20/2024 19:40:06'!
assertIsPositive: aNumber ifFalse: signalsBlock

	aNumber strictlyPositive ifFalse: signalsBlock! !

!Floor class methodsFor: 'assertions' stamp: 'MN 5/2/2025 09:46:19'!
assertIsValid: aNumberOfRooms

	self
		assertIsInteger: aNumberOfRooms
		ifFalse: [ self signalNumberOfRoomsMustBeInteger ].
		
	self
		assertIsPositive: aNumberOfRooms
		ifFalse: [ self signalNumberOfRoomsMustBePositive ]! !


!Floor class methodsFor: 'error messages' stamp: 'FRT 4/20/2024 19:02:53'!
numberOfRoomsMustBeIntegerErrorDescription
	
	^ 'Number of rooms must be integer'! !

!Floor class methodsFor: 'error messages' stamp: 'FRT 4/20/2024 19:35:54'!
numberOfRoomsMustBePositiveErrorDescription
	
	^'The number of rooms must be positive'! !

!Floor class methodsFor: 'error messages' stamp: 'FRT 4/20/2024 19:42:12'!
priceMustBeIntegerErrorDescription
	
	^ 'Price must be integer'! !

!Floor class methodsFor: 'error messages' stamp: 'FRT 4/20/2024 19:42:25'!
priceMustBePositiveErrorDescription
	
	^'Price must be positive'! !

!Floor class methodsFor: 'error messages' stamp: 'FRT 4/21/2024 14:43:01'!
pricesListCannotBeEmptyErrorDescription 
	
	^ 'Prices List must not be empty'! !

!Floor class methodsFor: 'error messages' stamp: 'FRT 4/21/2024 14:47:30'!
unknownGuestTypeErrorDescription
	
	^ 'The guest type is unknown'! !


!Floor class methodsFor: 'instance creation' stamp: 'MN 5/2/2025 09:46:19'!
newWithTotalRooms: aNumberOfRooms andPriceList: aPriceList
	
	self assertIsValid: aNumberOfRooms.
	
	aPriceList ifEmpty: [ self signalNoPrices ]		.

	^ self new initializeWithTotalRooms: aNumberOfRooms andPriceList: aPriceList.! !


!Floor class methodsFor: 'exceptions' stamp: 'FRT 4/21/2024 14:42:33'!
signalNoPrices
	
	self error: self pricesListCannotBeEmptyErrorDescription ! !

!Floor class methodsFor: 'exceptions' stamp: 'FRT 4/20/2024 19:02:35'!
signalNumberOfRoomsMustBeInteger
	
	self error: self numberOfRoomsMustBeIntegerErrorDescription ! !

!Floor class methodsFor: 'exceptions' stamp: 'FRT 4/20/2024 19:35:54'!
signalNumberOfRoomsMustBePositive

	self error: self numberOfRoomsMustBePositiveErrorDescription! !

!Floor class methodsFor: 'exceptions' stamp: 'FRT 4/20/2024 19:41:37'!
signalPriceMustBeInteger
	
	self error: self priceMustBeIntegerErrorDescription ! !

!Floor class methodsFor: 'exceptions' stamp: 'FRT 4/20/2024 19:41:58'!
signalPriceMustBePositive

	self error: self priceMustBePositiveErrorDescription! !

!Floor class methodsFor: 'exceptions' stamp: 'FRT 4/21/2024 14:48:09'!
signalUnknownGuestType

	self error: self class unknownGuestTypeErrorDescription
! !


!classDefinition: #Hotel category: #'ISW1-2024-1C-Parcial'!
Object subclass: #Hotel
	instanceVariableNames: 'floors availableRoomsCount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial'!

!Hotel methodsFor: 'accounting' stamp: 'MN 5/2/2025 15:53:36'!
totalLosses

	^ floors sum: [:eachFloor |
		eachFloor totalLosses 	
	].
! !

!Hotel methodsFor: 'accounting' stamp: 'MN 5/2/2025 15:53:29'!
totalProfits

	^ floors sum: [:eachFloor |
		eachFloor totalProfits 	
	].
! !


!Hotel methodsFor: 'initialization' stamp: 'MN 5/2/2025 09:54:56'!
initializeWithFloors: aCollectionOfFloors

	floors := aCollectionOfFloors. 
	availableRoomsCount := self totalRooms.! !



!Hotel methodsFor: 'totals' stamp: 'MN 5/2/2025 13:02:03'!
totalRooms

	^ floors sum: [ :eachFloor |
		eachFloor totalRooms
	]

! !

!Hotel methodsFor: 'totals' stamp: 'FRT 4/22/2024 11:43:00'!
totalRoomsAvailable

	^ availableRoomsCount.
! !

!Hotel methodsFor: 'totals' stamp: 'MN 5/2/2025 13:02:22'!
totalRoomsOccupied

	^ floors sum: [ :eachFloor |
		eachFloor totalRoomsOccupied 
	]
! !

!Hotel methodsFor: 'totals' stamp: 'MN 5/2/2025 13:02:32'!
totalRoomsReserved

	^ floors sum: [ :eachFloor |
		eachFloor totalRoomsReserved 
	]! !


!Hotel methodsFor: 'testing' stamp: 'MN 5/2/2025 12:51:56'!
isEmpty

	^ floors allSatisfy: [ :aFloor |
		aFloor isAvailable 
	]
! !


!Hotel methodsFor: 'guests' stamp: 'MN 5/2/2025 15:51:02'!
receive: aGuestType atFloor: aFloorNumber atRoom: aRoomNumber

	| room |
	
	room := self roomAt: aRoomNumber atFloor: aFloorNumber.

	room receive: aGuestType.
	
	availableRoomsCount := availableRoomsCount - 1.
! !

!Hotel methodsFor: 'guests' stamp: 'MN 5/2/2025 15:51:26'!
receiveWithReservation: aGuestType atFloor: aFloorNumber atRoom: aRoomNumber

	| room |
	
	room := self roomAt: aRoomNumber atFloor: aFloorNumber.

	room receiveWithReservation: aGuestType.

! !

!Hotel methodsFor: 'guests' stamp: 'MN 5/2/2025 15:51:30'!
reserveRoom: aRoomNumber atFloor: aFloorNumber

	| room |
	
	room := self roomAt: aRoomNumber atFloor: aFloorNumber.
	 
	room reserve.
	
	availableRoomsCount := availableRoomsCount - 1.
! !

!Hotel methodsFor: 'guests' stamp: 'MN 5/2/2025 15:49:49'!
roomAt: aRoomNumber atFloor: aFloorNumber
	
	| floor room |
	
	floor := floors at: aFloorNumber ifAbsent:  [ self class signalFloorNumberDoesNotExist ].
	room := floor roomAt: aRoomNumber ifAbsent: [ self class signalRoomNumberDoesNotExist ].
	
	^ room! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Hotel class' category: #'ISW1-2024-1C-Parcial'!
Hotel class
	instanceVariableNames: ''!

!Hotel class methodsFor: 'assertions' stamp: 'HAW 4/29/2024 08:48:39'!
assertHaveFloors: aFloorsCollection

	aFloorsCollection isEmpty ifTrue: [ self signalNoFloors ].! !


!Hotel class methodsFor: 'error description' stamp: 'FRT 4/25/2024 21:42:02'!
floorNumberDoesNotExistErrorDescription

	^ 'Floor number does not exist'.! !

!Hotel class methodsFor: 'error description' stamp: 'FRT 4/20/2024 21:42:02'!
noFloorsErrorDescription

	^ 'Cannot have a Hotel without floors'! !

!Hotel class methodsFor: 'error description' stamp: 'FRT 4/25/2024 21:41:41'!
roomNumberDoesNotExistErrorDescription

	^ 'Room number does not exist'.! !


!Hotel class methodsFor: 'exceptions' stamp: 'FRT 4/25/2024 21:42:24'!
signalFloorNumberDoesNotExist

	self error: self floorNumberDoesNotExistErrorDescription.! !

!Hotel class methodsFor: 'exceptions' stamp: 'FRT 4/20/2024 21:41:30'!
signalNoFloors

	self error: self noFloorsErrorDescription.! !

!Hotel class methodsFor: 'exceptions' stamp: 'FRT 4/25/2024 21:42:39'!
signalRoomNumberDoesNotExist

	self error: self roomNumberDoesNotExistErrorDescription.! !


!Hotel class methodsFor: 'instance creation' stamp: 'MN 5/2/2025 09:58:21'!
newWithFloors: aCollectionOfFloors

	self assertHaveFloors: aCollectionOfFloors.

	^ self new initializeWithFloors: aCollectionOfFloors ! !


!classDefinition: #Room category: #'ISW1-2024-1C-Parcial'!
Object subclass: #Room
	instanceVariableNames: 'status'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial'!

!Room methodsFor: 'guests' stamp: 'MN 5/2/2025 12:46:02'!
receive: aGuestType
		
	status receive: aGuestType forRoom: self! !

!Room methodsFor: 'guests' stamp: 'MN 5/2/2025 12:46:08'!
receiveWithReservation: aGuestType
	
	status receiveWithReservation: aGuestType forRoom: self! !

!Room methodsFor: 'guests' stamp: 'MN 5/2/2025 12:46:15'!
reserve

	status reserveForRoom: self! !


!Room methodsFor: 'testing' stamp: 'MN 5/2/2025 10:12:31'!
isAvailable

	^ status isAvailable ! !

!Room methodsFor: 'testing' stamp: 'MN 5/2/2025 10:12:43'!
isOccupied

	^ status isOccupied 
! !

!Room methodsFor: 'testing' stamp: 'MN 5/2/2025 10:12:49'!
isReserved

	^ status isReserved ! !


!Room methodsFor: 'accounting' stamp: 'MN 5/2/2025 15:18:50'!
lossUsing: aPriceList ifAbsentGuestType: unknownGuestTypeBlock

	^ status lossUsing: aPriceList ifAbsentGuestType: unknownGuestTypeBlock! !

!Room methodsFor: 'accounting' stamp: 'MN 5/2/2025 12:43:13'!
profitUsing: aPriceList ifAbsentGuestType: unknownGuestTypeBlock

	^ status profitUsing: aPriceList ifAbsentGuestType: unknownGuestTypeBlock forRoom: self 
	! !


!Room methodsFor: 'initialize' stamp: 'MN 5/2/2025 10:11:07'!
initialize
	
	status := AvailableRoom new.! !


!Room methodsFor: 'guest by status' stamp: 'MN 5/2/2025 12:46:36'!
receiveWhenAvailable: aGuestType

	status := OccupiedRoom newWith: aGuestType ! !

!Room methodsFor: 'guest by status' stamp: 'MN 5/2/2025 10:32:33'!
receiveWhenNotAvailable
	
	self error: self class roomIsNotEmptyErrorDescription! !

!Room methodsFor: 'guest by status' stamp: 'MN 5/2/2025 10:37:26'!
receiveWithReservationWhenNotReserved

	self error: self class roomIsNotReservedErrorDescription! !

!Room methodsFor: 'guest by status' stamp: 'MN 5/2/2025 12:46:51'!
receiveWithReservationWhenReserved: aGuestType

	status := OccupiedRoom newWith: aGuestType.
	! !

!Room methodsFor: 'guest by status' stamp: 'MN 5/2/2025 12:46:54'!
reserveWhenAvailable

	status := ReservedRoom newWith: #reserved! !

!Room methodsFor: 'guest by status' stamp: 'MN 5/2/2025 10:49:03'!
reserveWhenNotAvailable

	self error: self class roomIsNotEmptyErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Room class' category: #'ISW1-2024-1C-Parcial'!
Room class
	instanceVariableNames: ''!

!Room class methodsFor: 'error messages' stamp: 'FRT 4/22/2024 09:01:14'!
roomIsNotEmptyErrorDescription

	^ 'Room is not empty.'! !

!Room class methodsFor: 'error messages' stamp: 'FRT 4/22/2024 09:01:43'!
roomIsNotReservedErrorDescription

	^ 'Room is not reserved.'! !


!classDefinition: #RoomStatus category: #'ISW1-2024-1C-Parcial'!
Object subclass: #RoomStatus
	instanceVariableNames: 'guest'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial'!

!RoomStatus methodsFor: 'actions' stamp: 'MN 5/2/2025 10:30:57'!
receive: aGuest forRoom: aRoom

	self subclassResponsibility ! !

!RoomStatus methodsFor: 'actions' stamp: 'MN 5/2/2025 10:20:37'!
receiveWithReservation: aGuestType forRoom: aRoom

	self subclassResponsibility ! !

!RoomStatus methodsFor: 'actions' stamp: 'MN 5/2/2025 10:17:26'!
reserveForRoom: aRoom

	self subclassResponsibility ! !


!RoomStatus methodsFor: 'testing' stamp: 'MN 5/2/2025 10:08:25'!
isAvailable

	^ false! !

!RoomStatus methodsFor: 'testing' stamp: 'MN 5/2/2025 10:08:29'!
isOccupied

	^ false! !

!RoomStatus methodsFor: 'testing' stamp: 'MN 5/2/2025 10:08:36'!
isReserved

	^ false! !


!RoomStatus methodsFor: 'initialize' stamp: 'MN 5/2/2025 10:43:45'!
initializeWith: aGuestType 

	guest := aGuestType ! !


!RoomStatus methodsFor: 'accounting' stamp: 'MN 5/2/2025 15:22:27'!
lossUsing: aPriceList ifAbsentGuestType: unknownGuestTypeBlock

	^ 0*peso! !

!RoomStatus methodsFor: 'accounting' stamp: 'MN 5/2/2025 15:16:56'!
profitUsing: aPriceList ifAbsentGuestType: unknownGuestTypeBlock forRoom: aRoom

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RoomStatus class' category: #'ISW1-2024-1C-Parcial'!
RoomStatus class
	instanceVariableNames: ''!

!RoomStatus class methodsFor: 'instance creation' stamp: 'MN 5/2/2025 10:43:29'!
newWith: aGuestType

	^ self new initializeWith: aGuestType ! !


!classDefinition: #AvailableRoom category: #'ISW1-2024-1C-Parcial'!
RoomStatus subclass: #AvailableRoom
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial'!

!AvailableRoom methodsFor: 'actions' stamp: 'MN 5/2/2025 10:41:27'!
receive: aGuestType forRoom: aRoom

	aRoom receiveWhenAvailable: aGuestType ! !

!AvailableRoom methodsFor: 'actions' stamp: 'MN 5/2/2025 10:35:42'!
receiveWithReservation: aGuestType forRoom: aRoom

	aRoom receiveWithReservationWhenNotReserved! !

!AvailableRoom methodsFor: 'actions' stamp: 'MN 5/2/2025 10:49:40'!
reserveForRoom: aRoom

	aRoom reserveWhenAvailable! !


!AvailableRoom methodsFor: 'testing' stamp: 'MN 5/2/2025 10:08:58'!
isAvailable
	
	^ true! !


!AvailableRoom methodsFor: 'accounting' stamp: 'MN 5/2/2025 15:21:04'!
lossUsing: aPriceList ifAbsentGuestType: unknownGuestTypeBlock

	^ aPriceList values max! !

!AvailableRoom methodsFor: 'accounting' stamp: 'MN 5/2/2025 12:05:10'!
profitUsing: aPriceList ifAbsentGuestType: unknownGuestTypeBlock forRoom: aRoom

	^ 0*peso! !


!classDefinition: #OccupiedRoom category: #'ISW1-2024-1C-Parcial'!
RoomStatus subclass: #OccupiedRoom
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial'!

!OccupiedRoom methodsFor: 'actions' stamp: 'MN 5/2/2025 10:32:44'!
receive: aGuest forRoom: aRoom

	aRoom receiveWhenNotAvailable! !

!OccupiedRoom methodsFor: 'actions' stamp: 'MN 5/2/2025 10:35:49'!
receiveWithReservation: aGuestType forRoom: aRoom

	aRoom receiveWithReservationWhenNotReserved! !

!OccupiedRoom methodsFor: 'actions' stamp: 'MN 5/2/2025 10:49:32'!
reserveForRoom: aRoom

	aRoom reserveWhenNotAvailable! !


!OccupiedRoom methodsFor: 'testing' stamp: 'MN 5/2/2025 10:09:39'!
isOccupied
	
	^ true! !


!OccupiedRoom methodsFor: 'accounting' stamp: 'MN 5/2/2025 12:05:30'!
profitUsing: aPriceList ifAbsentGuestType: unknownGuestTypeBlock forRoom: aRoom

	^ aPriceList at: guest ifAbsent: unknownGuestTypeBlock! !


!classDefinition: #ReservedRoom category: #'ISW1-2024-1C-Parcial'!
RoomStatus subclass: #ReservedRoom
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial'!

!ReservedRoom methodsFor: 'testing' stamp: 'MN 5/2/2025 10:45:05'!
isOccupied
	
	^ true! !

!ReservedRoom methodsFor: 'testing' stamp: 'MN 5/2/2025 10:09:58'!
isReserved
	
	^ true! !


!ReservedRoom methodsFor: 'actions' stamp: 'MN 5/2/2025 10:32:47'!
receive: aGuest forRoom: aRoom

	aRoom receiveWhenNotAvailable! !

!ReservedRoom methodsFor: 'actions' stamp: 'MN 5/2/2025 10:36:51'!
receiveWithReservation: aGuestType forRoom: aRoom

	aRoom receiveWithReservationWhenReserved: aGuestType! !

!ReservedRoom methodsFor: 'actions' stamp: 'MN 5/2/2025 10:49:03'!
reserveForRoom: aRoom

	aRoom reserveWhenNotAvailable ! !


!ReservedRoom methodsFor: 'accounting' stamp: 'MN 5/2/2025 12:06:27'!
profitUsing: aPriceList ifAbsentGuestType: unknownGuestTypeBlock forRoom: aRoom

	^ aPriceList values min / 2! !
