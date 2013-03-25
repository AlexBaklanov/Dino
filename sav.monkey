Strict

Import imp

Global mainState:String
Global paramLine:String[500]

Function SaveGame:Void()

	mainState = ""

	SaveState(mainState)

End


Function LoadGame:Void()

	mainState = LoadState()

	If mainState
		
		Local pn:Int = 0

		For Local line$=Eachin mainState.Split( "~n" )
			
			paramLine[pn] = line
			pn += 1
			
		Next

		

		LoadLevel(CurrentLevel)
		
	Else
		
		ResetGame()
		
	End

End















Function ResetGame:Void()

	

End



Function addParam:Void(param:Int)
	
	Local strParam:String = String(param)
	strParam = strParam.Trim()
	
	mainState += strParam + "~n"

End