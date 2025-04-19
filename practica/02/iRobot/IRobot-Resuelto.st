!classDefinition: #CashierTest category: 'IRobot'!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot'!

!CashierTest methodsFor: 'receiving from empty trailer' stamp: 'MN 4/16/2025 15:49:36'!
test01ShouldNotAcceptEmptyTrailerFromNormalWorkingRobot

	self
		should: [ :aCashier :aRobot |
			 aCashier receiveOrderWithWorkingNormalRobot: aRobot.
		]
		raiseError: Cashier trailerIsEmptyErrorDescription
! !

!CashierTest methodsFor: 'receiving from empty trailer' stamp: 'MN 4/16/2025 15:50:08'!
test02ShouldNotAcceptEmptyTrailerFromMechanicalFailureRobot

	self
		should: [ :aCashier :aRobot |
			 aRobot withMechanicalFailure.
			 aCashier receiveOrderWithMechanicalFailureRobot: aRobot 
		]
		raiseError: Cashier trailerIsEmptyErrorDescription
! !


!CashierTest methodsFor: 'receiving from sensors failure robot' stamp: 'MN 4/16/2025 15:51:53'!
test03ShouldNotAcceptSensorsFailureRobot

	self
		should: [ :aCashier :aRobot |
			aRobot withSensorsFailure.
			aCashier receiveOrderWithSensorsFailureRobot: aRobot 
		]
		raiseError: Cashier robotSensorsFailureErrorDescription	
! !


!CashierTest methodsFor: 'receiving from mechanical failure robot' stamp: 'MN 4/16/2025 15:51:40'!
test04ShouldChangeRobotStatusToOutOfOrderWhenMechanicalFailureRobot

	self
		should: [ :aCashier :aRobot |
			aRobot take: (ProductA with: 1  and: 1).
			aRobot withMechanicalFailure.
			
			aCashier receiveOrderWithMechanicalFailureRobot: aRobot.
			
			aRobot take: (ProductA with: 1 and: 1) 
		]
		raiseError: Robot outOfOrderErrorDescription	

! !


!CashierTest methodsFor: 'should raise' stamp: 'MN 4/16/2025 15:48:27'!
should: aClosure raiseError: anErrorMessage

	| aRobot aTrailer aCashier |
	
	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	
	aCashier := Cashier new.

	self
		should: [aClosure value: aCashier value: aRobot]
		raise: Error
		withMessageText: anErrorMessage ! !


!classDefinition: #ProductTest category: 'IRobot'!
TestCase subclass: #ProductTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot'!

!ProductTest methodsFor: 'instance creation' stamp: 'FRT 5/4/2020 19:37:46'!
test01CanNotCreateProductWithCeroOrLessWeight

	self
		should: [ Product with: 0  and: 100 ]
		raise: Error
		withMessageText: Product invalidWeightErrorDescription 
! !

!ProductTest methodsFor: 'instance creation' stamp: 'FRT 5/4/2020 19:37:51'!
test02CanNotCreateProductWithCeroOrLessHeight

	self
		should: [ Product with: 100  and: 0 ]
		raise: Error
		withMessageText: Product invalidHeightErrorDescription 
! !

!ProductTest methodsFor: 'instance creation' stamp: 'FRT 5/4/2020 17:54:48'!
test03CanNotCreateProductWithNoIntegerWeight

	self
		should: [ Product with: 1.5  and: 100 ]
		raise: Error
		withMessageText: Product weightMustBeIntegerErrorDescription 

! !

!ProductTest methodsFor: 'instance creation' stamp: 'FRT 5/4/2020 17:55:14'!
test04CanNotCreateProductWithNoIntegerHeight

	self
		should: [ Product with: 100  and: 1.5 ]
		raise: Error
		withMessageText: Product heightMustBeIntegerErrorDescription 

! !


!classDefinition: #RobotTest category: 'IRobot'!
TestCase subclass: #RobotTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot'!

!RobotTest methodsFor: 'instance creation' stamp: 'FRT 5/4/2020 11:29:44'!
test01ShouldReceiveAnEmptyTrailer

	| aTrailer |

	aTrailer := Trailer with: 20 and: 100.
	aTrailer carry: (ProductA with: 1  and: 1).
	
	self
		should: [ Robot with: aTrailer ]
		raise: Error
		withMessageText: Robot notEmptyTrailerErrorDescription! !


!RobotTest methodsFor: 'taking products' stamp: 'FRT 5/4/2020 11:04:57'!
test02ShouldTakeProductsWhenWorkingNormal

	| aTrailer aRobot |

	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	
	aRobot take: (ProductA with: 1  and: 1).
	
	self assert: 1 equals: aTrailer totalProductsAmount! !

!RobotTest methodsFor: 'taking products' stamp: 'FRT 5/4/2020 11:07:49'!
test03ShouldTakeProductsWhenWorkingWithSensorsFailures

	| aTrailer aRobot |

	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	aRobot withSensorsFailure.
	
	aRobot take: (ProductA with: 1  and: 1).
	
	self assert: 1 equals: aTrailer totalProductsAmount! !

!RobotTest methodsFor: 'taking products' stamp: 'FRT 5/4/2020 11:08:34'!
test04ShouldTakeProductsWhenWorkingWithMechanicalFailures

	| aTrailer aRobot |

	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	aRobot withMechanicalFailure.
	
	aRobot take: (ProductA with: 1  and: 1).
	
	self assert: 1 equals: aTrailer totalProductsAmount! !

!RobotTest methodsFor: 'taking products' stamp: 'FRT 5/4/2020 18:26:53'!
test05ShouldNotTakeProductsWhenOutOfOrder

	| aTrailer aRobot |

	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	aRobot outOfOrder.
	
	self
		should: [ aRobot take: (ProductA with: 1  and: 1) ]
		raise: Error
		withMessageText: Robot outOfOrderErrorDescription.
	
	self assert: 0 equals: aTrailer totalProductsAmount! !


!RobotTest methodsFor: 'closing order' stamp: 'FRT 5/4/2020 12:46:40'!
test06CanCloseOrderWhenWorkingNormal

	| aTrailer aRobot |

	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	aRobot take: (ProductA with: 1  and: 1).
	
	self assert: (aRobot closeOrderUsing: Cashier new)! !

!RobotTest methodsFor: 'closing order' stamp: 'FRT 5/4/2020 11:28:16'!
test07CanNotCloseOrderWhenWorkingWithSensorsFailures

	| aTrailer aRobot |

	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	aRobot take: (ProductA with: 1  and: 1).
	
	aRobot withSensorsFailure.

	self
		should: [ aRobot closeOrderUsing: Cashier new ]
		raise: Error
		withMessageText: Cashier robotSensorsFailureErrorDescription.
 
! !

!RobotTest methodsFor: 'closing order' stamp: 'FRT 5/4/2020 12:47:10'!
test08CanCloseOrderWhenWorkingWithMechanicalFailures

	| aTrailer aRobot |

	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	aRobot take: (ProductA with: 1  and: 1).

	aRobot withMechanicalFailure.	
		
	self assert: (aRobot closeOrderUsing: Cashier new).! !

!RobotTest methodsFor: 'closing order' stamp: 'FRT 5/4/2020 18:48:41'!
test09CanNotCloseOrderWhenOutOfOrder

	| aTrailer aRobot |

	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	aRobot take: (ProductA with: 1  and: 1).
	
	aRobot outOfOrder.

	self
		should: [ aRobot closeOrderUsing: Cashier new ]
		raise: Error
		withMessageText: Robot outOfOrderErrorDescription.
 
! !


!classDefinition: #TrailerTest category: 'IRobot'!
TestCase subclass: #TrailerTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot'!

!TrailerTest methodsFor: 'weight capacity' stamp: 'MN 4/16/2025 16:20:59'!
test01CanNotCreateTrailerWithCeroOrLessMaxWeight

	self
		shouldTrailerWith: 0 and: 100 raiseError: Trailer invalidWeightCapacityErrorDescription  
! !

!TrailerTest methodsFor: 'weight capacity' stamp: 'MN 4/16/2025 16:20:35'!
test02CanNotCreateTrailerWithCeroOrLessMaxHeight

	self
		shouldTrailerWith: 1.5 and: 0 raiseError: Trailer invalidHeightCapacityErrorDescription 
! !

!TrailerTest methodsFor: 'weight capacity' stamp: 'MN 4/16/2025 16:20:06'!
test03CanNotCreateTrailerWithNoIntegerMaxWeight

	self
		shouldTrailerWith: 1.5 and: 100 raiseError: Trailer weightCapacityMustBeIntegerErrorDescription 
! !

!TrailerTest methodsFor: 'weight capacity' stamp: 'MN 4/16/2025 16:19:43'!
test04CanNotCreateTrailerWithNoIntegerMaxHeight

	self
		shouldTrailerWith: 100 and: 1.5 raiseError: Trailer heightCapacityMustBeIntegerErrorDescription 
! !

!TrailerTest methodsFor: 'weight capacity' stamp: 'MN 4/16/2025 16:32:28'!
test05ShouldRejectProductAIfWeightExceeded
	
	self shouldRaiseMaxWeightErrorWhenAdding: ProductA
	
	! !

!TrailerTest methodsFor: 'weight capacity' stamp: 'MN 4/16/2025 16:33:16'!
test06ShouldRejectProductBIfWeightExceeded

	self shouldRaiseMaxWeightErrorWhenAdding: ProductB! !

!TrailerTest methodsFor: 'weight capacity' stamp: 'MN 4/16/2025 16:41:48'!
test07ShouldAcceptProductsIfWeightUnderMaxWeightCapacity

	| aTrailer |
	aTrailer := Trailer with: 11  and: 100.

	self
		should: aTrailer
		acceptTotalProductsAmountOf: 4 
		andTotalProductsWeightof: 10! !

!TrailerTest methodsFor: 'weight capacity' stamp: 'MN 4/16/2025 16:42:11'!
test08ShouldAcceptProductsIfWeightEqualsMaxWeightCapacity

	| aTrailer |
	aTrailer := Trailer with: 11  and: 100.

	aTrailer carry: (ProductB with: 1 and: 1).
	
	self
		should: aTrailer
		acceptTotalProductsAmountOf: 5 
		andTotalProductsWeightof: 11! !


!TrailerTest methodsFor: 'height capacity' stamp: 'MN 4/16/2025 16:50:12'!
test09ShouldAcceptProductAIgnoringMaxTotalHeightOfBProducts

	self
		shouldTotalProductsHeightEqual: 0
		afterAdding: ProductA
	! !

!TrailerTest methodsFor: 'height capacity' stamp: 'MN 4/16/2025 16:49:59'!
test10ShouldIgnoreAProductsInMaxTotalHeightOfBProducts

	| halfExceededHeightCapacity |

	halfExceededHeightCapacity := (100 + 2) / 2.

	self
		shouldTotalProductsHeightEqual: halfExceededHeightCapacity
		afterAdding: ProductB
	! !

!TrailerTest methodsFor: 'height capacity' stamp: 'FRT 5/5/2020 11:28:16'!
test11ShouldRejectProductBExceedingMaxTotalHeightOfBProducts

	| aTrailer heightCapacity exceededHeightCapacity halfExceededHeightCapacity |

	heightCapacity := 100.
	aTrailer := Trailer with: 20  and: heightCapacity.
	
	exceededHeightCapacity := heightCapacity + 2.
	halfExceededHeightCapacity := exceededHeightCapacity / 2.
	
	aTrailer carry: (ProductB with: 10 and: halfExceededHeightCapacity).

	self 
		should: [aTrailer carry: (ProductB with: 10 and: halfExceededHeightCapacity)] 
		raise: Error
		withMessageText: Trailer maxHeightExceededErrorDescription.
	
	self assert: aTrailer totalProductsAmount equals: 1.
	self assert: aTrailer totalProductsHeight equals: halfExceededHeightCapacity.
	! !


!TrailerTest methodsFor: 'should raise' stamp: 'MN 4/16/2025 16:41:37'!
should: aTrailer acceptTotalProductsAmountOf: anAmountOfProducts andTotalProductsWeightof: aTotalWeight

	aTrailer carry: (ProductA with: 1 and: 1).
	aTrailer carry: (ProductA with: 2 and: 1).
	aTrailer carry: (ProductB with: 3 and: 1).
	aTrailer carry: (ProductB with: 4 and: 1).
		
	self assert: aTrailer totalProductsAmount equals: anAmountOfProducts .
	self assert: aTrailer totalProductsWeight equals: aTotalWeight.! !

!TrailerTest methodsFor: 'should raise' stamp: 'MN 4/16/2025 16:33:03'!
shouldRaiseMaxWeightErrorWhenAdding: aProductClass

	| aTrailer |
	aTrailer := Trailer with: 20  and: 100.
	
	self
		should: [ aTrailer carry: (aProductClass with: 21 and: 1) ]
		raise: Error
		withMessageText: Trailer maxWeightExceededErrorDescription.
		
	self assert: aTrailer isEmpty.! !

!TrailerTest methodsFor: 'should raise' stamp: 'MN 4/16/2025 16:48:57'!
shouldTotalProductsHeightEqual: aHeight afterAdding: aProductClass	

	| aTrailer heightCapacity exceededHeightCapacity halfExceededHeightCapacity |

	heightCapacity := 100.
	aTrailer := Trailer with: 20  and: heightCapacity.
	
	exceededHeightCapacity := heightCapacity + 2.
	halfExceededHeightCapacity := exceededHeightCapacity / 2.
	
	aTrailer carry: (ProductA with: 10 and: halfExceededHeightCapacity).
	aTrailer carry: (aProductClass with: 10 and: halfExceededHeightCapacity).
	
	self assert: aTrailer totalProductsAmount equals: 2.
	self assert: aTrailer totalProductsHeight equals: aHeight.
! !

!TrailerTest methodsFor: 'should raise' stamp: 'MN 4/16/2025 16:22:41'!
shouldTrailerWith: aWeightCapacity and: aHeightCapacity raiseError: anErrorMessage
	self
		should: [ Trailer with: aWeightCapacity and: aHeightCapacity ]
		raise: Error
		withMessageText: anErrorMessage! !


!classDefinition: #Cashier category: 'IRobot'!
Object subclass: #Cashier
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot'!

!Cashier methodsFor: 'closing buy order' stamp: 'MN 4/16/2025 15:42:23'!
receiveOrderWithMechanicalFailureRobot: aRobot
	|aTrailer|.
	
	aRobot outOfOrder.
		
	aTrailer := aRobot trailer.	
	self assertTrailerNotEmpty: aTrailer.

	"Comentario: en este punto el cashier realizaría el checkout de los productos."

	^ true! !

!Cashier methodsFor: 'closing buy order' stamp: 'MN 4/16/2025 15:42:03'!
receiveOrderWithSensorsFailureRobot: aRobot
	aRobot outOfOrder.
	self signalRobotSensorsFailure! !

!Cashier methodsFor: 'closing buy order' stamp: 'MN 4/16/2025 15:41:44'!
receiveOrderWithWorkingNormalRobot: aRobot
	| aTrailer | 
	aTrailer := aRobot trailer.	
	self assertTrailerNotEmpty: aTrailer.

	"Comentario: en este punto el cashier realizaría el checkout de los productos."

	^ true! !


!Cashier methodsFor: 'assertions' stamp: 'MN 4/13/2025 20:18:36'!
assertTrailerNotEmpty: aTrailer
	
	aTrailer isEmpty ifTrue: [
		self signalTrailerIsEmpty
		]! !

!Cashier methodsFor: 'assertions' stamp: 'FRT 5/4/2020 11:28:31'!
signalTrailerIsEmpty
	
	self error: self class trailerIsEmptyErrorDescription! !


!Cashier methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 11:28:03'!
signalRobotSensorsFailure
	
	self error: self class robotSensorsFailureErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'IRobot'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:28:03'!
robotSensorsFailureErrorDescription
	
	^ 'This robot presents sensors failures!!'! !

!Cashier class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:28:31'!
trailerIsEmptyErrorDescription
	
	^ 'This robots trailer is empty!!'! !


!classDefinition: #Product category: 'IRobot'!
Object subclass: #Product
	instanceVariableNames: 'weight height'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot'!

!Product methodsFor: 'instance creation' stamp: 'FRT 5/4/2020 10:39:55'!
initializeWith: aWeight and: aHeight
	
	weight := aWeight.
	height := aHeight.! !


!Product methodsFor: 'action' stamp: 'FRT 5/4/2020 10:38:22'!
carryBy: aTrailer	
	
	self subclassResponsibility! !


!Product methodsFor: 'testing' stamp: 'FRT 5/4/2020 10:39:06'!
isStackable
	
	self subclassResponsibility! !


!Product methodsFor: 'accessing' stamp: 'FRT 5/4/2020 10:43:30'!
height
	
	^ height! !

!Product methodsFor: 'accessing' stamp: 'FRT 5/4/2020 10:43:24'!
weight
	
	^ weight! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Product class' category: 'IRobot'!
Product class
	instanceVariableNames: ''!

!Product class methodsFor: 'instance creation' stamp: 'FRT 5/4/2020 17:47:40'!
with: aWeight and: aHeight
	
	aWeight strictlyPositive ifFalse: [ self signalInvalidWeight ].
	aHeight strictlyPositive ifFalse: [ self signalInvalidHeight ].

	aWeight isInteger ifFalse: [ self signalWeightMustBeInteger ].
	aHeight isInteger ifFalse: [ self signalHeightMustBeInteger ].
	
	^ self new initializeWith: aWeight and: aHeight! !


!Product class methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 17:48:22'!
signalHeightMustBeInteger

	self error: self heightMustBeIntegerErrorDescription! !

!Product class methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 11:29:08'!
signalInvalidHeight

	self error: self invalidHeightErrorDescription! !

!Product class methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 11:29:18'!
signalInvalidWeight

	self error: self invalidWeightErrorDescription! !

!Product class methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 17:48:12'!
signalWeightMustBeInteger

	self error: self weightMustBeIntegerErrorDescription! !


!Product class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 17:49:16'!
heightMustBeIntegerErrorDescription

	^ 'Height must be integer'! !

!Product class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:29:08'!
invalidHeightErrorDescription

	^ 'Height must be positive'! !

!Product class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:29:18'!
invalidWeightErrorDescription

	^ 'Weight must be positive'! !

!Product class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 17:49:08'!
weightMustBeIntegerErrorDescription

	^ 'Weight must be integer'! !


!classDefinition: #ProductA category: 'IRobot'!
Product subclass: #ProductA
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot'!

!ProductA methodsFor: 'testing' stamp: 'FRT 5/4/2020 10:41:29'!
isStackable

	^ false! !


!ProductA methodsFor: 'action' stamp: 'FRT 5/4/2020 10:41:12'!
carryBy: aTrailer

	aTrailer carryProductA: self! !


!classDefinition: #ProductB category: 'IRobot'!
Product subclass: #ProductB
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot'!

!ProductB methodsFor: 'testing' stamp: 'FRT 5/4/2020 10:42:28'!
isStackable

	^ true! !


!ProductB methodsFor: 'action' stamp: 'FRT 5/4/2020 10:42:16'!
carryBy: aTrailer

	aTrailer carryProductB: self! !


!classDefinition: #Robot category: 'IRobot'!
Object subclass: #Robot
	instanceVariableNames: 'status trailer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot'!

!Robot methodsFor: 'actions' stamp: 'MN 4/13/2025 20:28:24'!
closeOrderUsing: aCashier
	
	^ status closeOrderUsing: aCashier.
! !

!Robot methodsFor: 'actions' stamp: 'MN 4/13/2025 20:28:16'!
take: aProduct
	
	^ status take: aProduct
! !


!Robot methodsFor: 'status' stamp: 'MN 4/12/2025 10:27:52'!
outOfOrder

	status := OutOfOrder newWith: self.
! !

!Robot methodsFor: 'status' stamp: 'MN 4/12/2025 10:28:00'!
withMechanicalFailure

	status := MechanicalFailure newWith: self.
! !

!Robot methodsFor: 'status' stamp: 'MN 4/12/2025 10:28:07'!
withSensorsFailure

	status := SensorsFailure newWith: self.
! !


!Robot methodsFor: 'accessing' stamp: 'FRT 5/4/2020 18:35:21'!
status

	^ status
! !

!Robot methodsFor: 'accessing' stamp: 'FRT 5/3/2020 21:27:04'!
trailer

	^ trailer
! !


!Robot methodsFor: 'actions on status' stamp: 'MN 4/12/2025 10:07:47'!
canTakeSoTake: aProduct
	^ trailer carry: aProduct! !

!Robot methodsFor: 'actions on status' stamp: 'MN 4/12/2025 10:17:16'!
cannotTakeNorCloseOrder
	^ self class signalOutOfOrder! !

!Robot methodsFor: 'actions on status' stamp: 'MN 4/16/2025 15:15:46'!
closeOrderWhenMechanicalFailure: aCashier
	^ aCashier receiveOrderWithMechanicalFailureRobot: self! !

!Robot methodsFor: 'actions on status' stamp: 'MN 4/16/2025 15:16:06'!
closeOrderWhenSensorsFailure: aCashier
	^ aCashier receiveOrderWithSensorsFailureRobot: self! !

!Robot methodsFor: 'actions on status' stamp: 'MN 4/16/2025 15:53:09'!
closeOrderWhenWorkingNormal: aCashier
	^ aCashier receiveOrderWithWorkingNormalRobot: self! !


!Robot methodsFor: 'initialization' stamp: 'MN 4/12/2025 10:22:56'!
initializeWith: aTrailer

	trailer := aTrailer.
	status := WorkingNormal newWith: self.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Robot class' category: 'IRobot'!
Robot class
	instanceVariableNames: ''!

!Robot class methodsFor: 'instance creation' stamp: 'FRT 5/3/2020 22:36:52'!
with: aTrailer

	self assertIsEmpty: aTrailer.

	^ self new initializeWith: aTrailer! !


!Robot class methodsFor: 'assertions' stamp: 'FRT 5/3/2020 22:35:35'!
assertIsEmpty: aTrailer

	^ aTrailer isEmpty ifFalse: [ self signalNotEmptyTrailer ]! !

!Robot class methodsFor: 'assertions' stamp: 'FRT 5/4/2020 11:29:32'!
signalNotEmptyTrailer

	self error: self notEmptyTrailerErrorDescription! !

!Robot class methodsFor: 'assertions' stamp: 'FRT 5/4/2020 18:26:04'!
signalOutOfOrder
	
	self error: self outOfOrderErrorDescription! !


!Robot class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:29:32'!
notEmptyTrailerErrorDescription

	^ 'The robot was assigned a non empty trailer'! !

!Robot class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 18:26:32'!
outOfOrderErrorDescription
	
	^ 'Robot out of order :('! !


!classDefinition: #RobotStatus category: 'IRobot'!
Object subclass: #RobotStatus
	instanceVariableNames: 'robot'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot'!

!RobotStatus methodsFor: 'initialization' stamp: 'MN 4/12/2025 10:23:49'!
initializeWith: aRobot
	robot := aRobot! !


!RobotStatus methodsFor: 'actions' stamp: 'MN 4/12/2025 09:57:52'!
closeOrderUsing: aCashier
	self subclassResponsibility ! !

!RobotStatus methodsFor: 'actions' stamp: 'MN 4/12/2025 09:52:34'!
take: aProduct
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RobotStatus class' category: 'IRobot'!
RobotStatus class
	instanceVariableNames: ''!

!RobotStatus class methodsFor: 'instance creation' stamp: 'MN 4/12/2025 10:23:29'!
newWith: aRobot
	^ self new initializeWith: aRobot! !


!classDefinition: #MechanicalFailure category: 'IRobot'!
RobotStatus subclass: #MechanicalFailure
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot'!

!MechanicalFailure methodsFor: 'actions' stamp: 'MN 4/16/2025 15:13:12'!
closeOrderUsing: aCashier
	^ robot closeOrderWhenMechanicalFailure: aCashier! !

!MechanicalFailure methodsFor: 'actions' stamp: 'MN 4/13/2025 20:26:53'!
take: aProduct
	^ robot canTakeSoTake: aProduct! !


!classDefinition: #OutOfOrder category: 'IRobot'!
RobotStatus subclass: #OutOfOrder
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot'!

!OutOfOrder methodsFor: 'actions' stamp: 'MN 4/13/2025 20:26:58'!
closeOrderUsing: aCashier
	^ robot cannotTakeNorCloseOrder.! !

!OutOfOrder methodsFor: 'actions' stamp: 'MN 4/13/2025 20:26:56'!
take: aProduct
	^ robot cannotTakeNorCloseOrder.! !


!classDefinition: #SensorsFailure category: 'IRobot'!
RobotStatus subclass: #SensorsFailure
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot'!

!SensorsFailure methodsFor: 'actions' stamp: 'MN 4/16/2025 15:12:55'!
closeOrderUsing: aCashier
	^ robot closeOrderWhenSensorsFailure: aCashier! !

!SensorsFailure methodsFor: 'actions' stamp: 'MN 4/13/2025 20:27:08'!
take: aProduct
	^ robot canTakeSoTake: aProduct! !


!classDefinition: #WorkingNormal category: 'IRobot'!
RobotStatus subclass: #WorkingNormal
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot'!

!WorkingNormal methodsFor: 'actions' stamp: 'MN 4/16/2025 15:13:02'!
closeOrderUsing: aCashier
	^ robot closeOrderWhenWorkingNormal: aCashier! !

!WorkingNormal methodsFor: 'actions' stamp: 'MN 4/13/2025 20:27:15'!
take: aProduct
	^ robot canTakeSoTake: aProduct! !


!classDefinition: #Trailer category: 'IRobot'!
Object subclass: #Trailer
	instanceVariableNames: 'weightCapacity heightCapacity container'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot'!

!Trailer methodsFor: 'initialization' stamp: 'FRT 5/3/2020 23:27:42'!
initializeWith: aWeightCapacity and: aHeightCapacity

	weightCapacity := aWeightCapacity.
	heightCapacity := aHeightCapacity.
	
	container := OrderedCollection new.! !


!Trailer methodsFor: 'accessing' stamp: 'MN 4/15/2025 11:02:43'!
sumTotal: aMeasure ofProductsIfConditionForProduct: aCondition
	| total index |

	total := 0.
	index := 1.
	
	[index <= container size] whileTrue: [ | product |
		product := (container at: index).

		(aCondition value: product) ifTrue:[
			total := total + (aMeasure value: product).
		].
		
		index := index + 1.	
	].

	^ total.! !

!Trailer methodsFor: 'accessing' stamp: 'FRT 5/3/2020 23:34:36'!
totalProductsAmount
	
	^ container size.! !

!Trailer methodsFor: 'accessing' stamp: 'MN 4/15/2025 11:04:15'!
totalProductsHeight

	^ self
		sumTotal: [:aProduct | aProduct height]
		ofProductsIfConditionForProduct: [:aProduct | aProduct isStackable]! !

!Trailer methodsFor: 'accessing' stamp: 'MN 4/15/2025 11:04:10'!
totalProductsWeight
	
	^ self
		sumTotal: [:aProduct | aProduct weight]
		ofProductsIfConditionForProduct: [:aProduct | true]! !


!Trailer methodsFor: 'testing' stamp: 'FRT 5/3/2020 23:33:33'!
isEmpty
	
	^ container isEmpty! !


!Trailer methodsFor: 'action' stamp: 'FRT 5/3/2020 23:35:19'!
carry: aProduct
	
	^ aProduct carryBy: self.! !

!Trailer methodsFor: 'action' stamp: 'MN 4/15/2025 10:37:26'!
carryProductA: aProduct
	
	self
		tryToAdd: aProduct
		asserting: [
			self assertWeightAdding: aProduct
		]! !

!Trailer methodsFor: 'action' stamp: 'MN 4/15/2025 10:37:30'!
carryProductB: aProduct
	
	self
		tryToAdd: aProduct
		asserting: [
			self assertWeightAdding: aProduct.
			self assertHeightAdding: aProduct.
		]! !

!Trailer methodsFor: 'action' stamp: 'MN 4/15/2025 10:37:14'!
tryToAdd: aProduct asserting: aClosureOfAsserts

	aClosureOfAsserts value.
	
	container add: aProduct ! !


!Trailer methodsFor: 'assertions' stamp: 'MN 4/15/2025 10:32:08'!
assertHeightAdding: aProduct
	
	(self totalProductsHeight + aProduct height) > heightCapacity ifTrue: [ self signalMaxHeightCapacityExceeded ]! !

!Trailer methodsFor: 'assertions' stamp: 'FRT 5/5/2020 11:27:41'!
assertWeightAdding: aProduct
	
	(self totalProductsWeight + aProduct weight) > weightCapacity ifTrue: [ self signalMaxWeightCapacityExceeded ]! !


!Trailer methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 11:30:31'!
signalMaxHeightCapacityExceeded

	self error: self class maxHeightExceededErrorDescription
! !

!Trailer methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 11:30:38'!
signalMaxWeightCapacityExceeded

	self error: self class maxWeightExceededErrorDescription
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Trailer class' category: 'IRobot'!
Trailer class
	instanceVariableNames: ''!

!Trailer class methodsFor: 'instance creation' stamp: 'FRT 5/4/2020 17:33:58'!
with: aWeightCapacity and: aHeightCapacity

	aWeightCapacity strictlyPositive ifFalse: [ self signalInvalidWeightCapacity ].
	aHeightCapacity strictlyPositive ifFalse: [ self signalInvalidHeightCapacity ].
	
	aWeightCapacity isInteger ifFalse: [ self signalWeightCapacityMustBeInteger ].
	aHeightCapacity isInteger ifFalse: [ self signalHeightCapacityMustBeInteger ].
		
	^ self new initializeWith: aWeightCapacity and: aHeightCapacity.

! !


!Trailer class methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 17:37:41'!
signalHeightCapacityMustBeInteger

	self error: self heightCapacityMustBeIntegerErrorDescription
! !

!Trailer class methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 11:30:12'!
signalInvalidHeightCapacity

	self error: self invalidHeightCapacityErrorDescription
! !

!Trailer class methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 11:30:21'!
signalInvalidWeightCapacity

	self error: self invalidWeightCapacityErrorDescription
! !

!Trailer class methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 17:37:29'!
signalWeightCapacityMustBeInteger

	self error: self weightCapacityMustBeIntegerErrorDescription
! !


!Trailer class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 17:49:38'!
heightCapacityMustBeIntegerErrorDescription

	^ 'Height capacity must be integer'! !

!Trailer class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:30:12'!
invalidHeightCapacityErrorDescription

	^ 'The trailers height capacity must be positive.'
! !

!Trailer class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:30:21'!
invalidWeightCapacityErrorDescription

	^ 'The trailers weight capacity must be positive.'
! !

!Trailer class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:30:31'!
maxHeightExceededErrorDescription

	^ 'Maximum height has been exceeded'
! !

!Trailer class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:30:38'!
maxWeightExceededErrorDescription

	^ 'Maximum weight has been exceeded'
! !

!Trailer class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 17:49:32'!
weightCapacityMustBeIntegerErrorDescription

	^ 'Weight capacity must be integer'! !
