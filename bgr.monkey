Strict

Import imp

Global bgrXactual:Float
Global bgrXbottom:Float

Global fgrX:Float
Global fgrY:Float

Global bgrBottomImg:Image
Global bgrActualImg:Image
Global bgr2:Image
Global fgr:Image

Global bgrMiddleImg:Image 'center'
Global currentBgrMiddle:Int
Global bgrXmiddle:Float

Global cave:Image
Global caveMode:Bool
Global caveX:Float

Global bgr := New atlasClass

Function BackgroundInit:Void()

	'bgr atlas'
	bgr.Load("bgr/bgr0"+CurrentLevel+""+retinaStr+".png")
		
	bgrMiddleImg = LoadImage( "bgr/centerPics" + CurrentLevel + "" +retinaStr+ ".png", 256 * imagesRects2x, 256 * imagesRects2x,  16 )
	bgrMiddleImg.SetHandle( bgrMiddleImg.Width()/2, bgrMiddleImg.Height() )

	cave = LoadImage("bgr/cave"+retinaStr+".png")
	
	currentBgrMiddle = Rnd(0,10)
	bgrXmiddle = dw+bgrMiddleImg.Width()

	bgrXactual = bgr.width[0] / 2
		
End

Function BackgroundUpdate:Void()

	bgrXactual -= speed*Retina * globalSpeed / 4.0
	bgrXbottom -= speed*Retina * globalSpeed

	If bgrXactual < - bgr.width[0]*retinaScl	bgrXactual += bgr.width[0]*retinaScl
	If bgrXbottom < - bgr.width[1]*retinaScl	bgrXbottom += bgr.width[1]*retinaScl
		
	bgrXmiddle -= speed*Retina * globalSpeed / 2.0
	If bgrXmiddle < -bgrMiddleImg.Width()*retinaScl
		
		bgrXmiddle = dw+bgrMiddleImg.Width()
		currentBgrMiddle += 1
		If currentBgrMiddle = 10 currentBgrMiddle = 1
			
	End
	
End

Function BackgroundDraw:Void()
	
	'background main 0'
	bgr.Draw(0, bgrXactual, 							0, 0, retinaScl, retinaScl)
	bgr.Draw(0, bgrXactual + bgr.width[0]*retinaScl,	0, 0, retinaScl, retinaScl)
	
	DrawImage(bgrMiddleImg, bgrXmiddle, dh, 0, retinaScl, retinaScl, currentBgrMiddle)
	
	'background bottom 1'
	bgr.Draw(1, bgrXbottom, 							dh - bgr.height[1]*retinaScl, 	0, retinaScl, retinaScl)
	bgr.Draw(1, bgrXbottom + bgr.width[1]*retinaScl,	dh - bgr.height[1]*retinaScl, 	0, retinaScl, retinaScl)

End

Function BackgroundReset:Void()

	bgrXactual = 0
	bgrXbottom = 0

End

Function BackgroundDeinit:Void()
	
	bgr.Deinit()
	bgrMiddleImg.Discard()
	
End




