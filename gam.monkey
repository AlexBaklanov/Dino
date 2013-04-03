Strict

Import imp

Global CurrentLevel:Int = 1
Global GameOverMode:Bool
Global gameOverBtn := New Buttons

Global mainGame:mainGameClass = New mainGameClass

Class mainGameClass

	'd888888b d8b   db d888888b d888888b 
	'  `88'   888o  88   `88'   `~~88~~' 
	'   88    88V8o 88    88       88    
	'   88    88 V8o88    88       88    
	'  .88.   88  V888   .88.      88    
	'Y888888P VP   V8P Y888888P    YP    
	
	Method Init:Void()

		HeroInit()
		BottomInit()
		ObstaclesInit()

		gameOverBtn.Init("Play Again")

		GameOverMode = False

		globalSpeedValue = 6.0 * Retina
		globalSpeedAcceleration = 0.05 * Retina
		globalSpeedDeceleration = .2 * Retina

		globalDistance = 0
		globalSpeed = 0.0

	End

	'db    db d8888b. d8888b.  .d8b.  d888888b d88888b 
	'88    88 88  `8D 88  `8D d8' `8b `~~88~~' 88'     
	'88    88 88oodD' 88   88 88ooo88    88    88ooooo 
	'88    88 88~~~   88   88 88~~~88    88    88~~~~~ 
	'88b  d88 88      88  .8D 88   88    88    88.     
	'~Y8888P' 88      Y8888D' YP   YP    YP    Y88888P

	Method Update:String()

		If GameOverMode

			If gameOverBtn.Pressed()

				mainGame.Deinit()
				mainGame.Init()

			End

			Return Game

		End

		HeroUpdate()
		BottomUpdate()
		ObstaclesUpdate()

		SpeedHandle()

		Return Game

	End



	'd8888b. d8888b.  .d8b.  db   d8b   db 
	'88  `8D 88  `8D d8' `8b 88   I8I   88 
	'88   88 88oobY' 88ooo88 88   I8I   88 
	'88   88 88`8b   88~~~88 Y8   I8I   88 
	'88  .8D 88 `88. 88   88 `8b d8'8b d8' 
	'Y8888D' 88   YD YP   YP  `8b8' `8d8'  


	Method Draw:Void()

		Cls()

		HeroDraw()
		BottomDraw()
		ObstaclesDraw()

		If GameOverMode gameOverBtn.Draw(dw/2, 0)

		'DrawText( bottomState, 10, 10 )
		'DrawText( heroState, 10, 30 )

		DrawText( globalDistance / 10 / Retina, 10, 50 )

	End

	'd8888b. d88888b .d8888. d88888b d888888b 
	'88  `8D 88'     88'  YP 88'     `~~88~~' 
	'88oobY' 88ooooo `8bo.   88ooooo    88    
	'88`8b   88~~~~~   `Y8b. 88~~~~~    88    
	'88 `88. 88.     db   8D 88.        88    
	'88   YD Y88888P `8888Y' Y88888P    YP    


	Method Reset:Void()

		

	End

	'd8888b. d88888b d888888b d8b   db d888888b d888888b 
	'88  `8D 88'       `88'   888o  88   `88'   `~~88~~' 
	'88   88 88ooooo    88    88V8o 88    88       88    
	'88   88 88~~~~~    88    88 V8o88    88       88    
	'88  .8D 88.       .88.   88  V888   .88.      88    
	'Y8888D' Y88888P Y888888P VP   V8P Y888888P    YP    

	Method Deinit:Void()
		
		HeroDeinit()
		BottomDeinit()
		ObstaclesDeinit()

		gameOverBtn.Deinit()
		
	End

End


'd88888b db    db d8b   db  .o88b. d888888b d888888b  .d88b.  d8b   db .d8888. 
'88'     88    88 888o  88 d8P  Y8 `~~88~~'   `88'   .8P  Y8. 888o  88 88'  YP 
'88ooo   88    88 88V8o 88 8P         88       88    88    88 88V8o 88 `8bo.   
'88~~~   88    88 88 V8o88 8b         88       88    88    88 88 V8o88   `Y8b. 
'88      88b  d88 88  V888 Y8b  d8    88      .88.   `8b  d8' 88  V888 db   8D 
'YP      ~Y8888P' VP   V8P  `Y88P'    YP    Y888888P  `Y88P'  VP   V8P `8888Y' 


Function ResetForNextLevel:Void()


	
End

Function SetUpgradeCoefs:Void()

	If CurrentLevel = 1  upgradeCostCoef 	= [2, 				3, 				1.83, 			1.56, 			1.48, 			1.5,			1.6 ]
	If CurrentLevel = 2  upgradeCostCoef 	= [1.58, 			3, 				1.45, 			1.37, 			1.38, 			1.265,			1.45 ]
	If CurrentLevel = 3  upgradeCostCoef 	= [1.45, 			3, 				1.32, 			1.26, 			1.3, 			1.22,			1.26 ]
	'										= ["Health:   ", 	"Speed:    ", 	"Armor:    ", 	"Friend:   ", 	"Strength: ", 	Mask:     ", 		"Oxygen:   "]
End



Function FromGameToShop:String()

	coins += coinsGame
	coinsGame = 0

	pauseMode = False

	mainGame.Deinit()
	shop.Init()

	SaveGame()

	'If health > -10 ModeFrom = "Not GameOver"

	Return Shop

End

Function FromGameToMenu:String()

	coins += coinsGame
	coinsGame = 0

	pauseMode = False

	mainGame.Deinit()

	menu.Init()

	SaveGame()

	Return Menu

End

'.d8888. d8888b. d88888b d88888b d8888b.      db   db  .d8b.  d8b   db d8888b. db      d88888b 
'88'  YP 88  `8D 88'     88'     88  `8D      88   88 d8' `8b 888o  88 88  `8D 88      88'     
'`8bo.   88oodD' 88ooooo 88ooooo 88   88      88ooo88 88ooo88 88V8o 88 88   88 88      88ooooo 
'  `Y8b. 88~~~   88~~~~~ 88~~~~~ 88   88      88~~~88 88~~~88 88 V8o88 88   88 88      88~~~~~ 
'db   8D 88      88.     88.     88  .8D      88   88 88   88 88  V888 88  .8D 88booo. 88.     
'`8888Y' 88      Y88888P Y88888P Y8888D'      YP   YP YP   YP VP   V8P Y8888D' Y88888P Y88888P 


Global globalSpeedValue:Float
Global globalSpeedAcceleration:Float
Global globalSpeedDeceleration:Float
Global globalSpeed:Float
Global globalDistance:Int

Function SpeedHandle:Void()

	globalDistance += globalSpeed

	If isStatesMatch()
		If globalSpeed < globalSpeedValue globalSpeed += globalSpeedAcceleration
	ElseIf jump = 0
		globalSpeed -= globalSpeedDeceleration
	End

	If globalSpeed < 0 GameOverMode = True

End

Function isStatesMatch:Bool()

	If heroState = bottomState Return True

	Return False

End




