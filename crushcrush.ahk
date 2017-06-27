r = 0; number of gifts to purchase
s = 0; number of dates to go on
d = Moonlight

ResetBoost = 738.00	; not used yet
SpeedBoost = 64		; not used yet
WaitToDate = 10		; TODO:: calculate time to wait between dates

ShowGuiWindow()
{
	global
	Gui, CrushCrushBuy: New, +AlwaysOnTop +ToolWindow, CrushCrush
	Gui, Add, Text,, Buy Gifts:
	Gui, Add, Edit, w150 vGiftName +Lowercase,shell
	Gui, Add, Edit, w50 vGiftNum +Number,1
	Gui, Add, Button, Default gBuy, &Buy
	Gui, Add, Text, vBuyStatusText w150,
	Gui, Add, Progress, w150 h20 vBuyProgress -Smooth Range0-100
	Gui, Add, Text, ys, Go on Date:
	Gui, Add, Radio, gDateMoonlight Checked, Moonlight Stroll
	Gui, Add, Radio, gDateMovie, Movie Theater
	Gui, Add, Radio, gDateSightseeing, Sightseeing
	Gui, Add, Radio, gDateBeach, Beach
	Gui, Add, Edit, w50 vDateNum +Number,1
	Gui, Add, Button, gDate, &Date
	Gui, Add, Text, vDateStatusText w150,
	Gui, Add, Progress, w150 h20 vDateProgress -Smooth Range0-100
	Gui, Show, x10 y10
}
ShowGuiWindow()
return

DateMoonlight:
	d = Moonlight
return

DateMovie:
	d = Movie
return

DateSightseeing:
	d = Sightseeing
return

DateBeach:
	d = Beach
return

Buy:
	Gui, Submit, NoHide
	r = %GiftNum%
	GuiControl,CrushCrushBuy:+Range0-%GiftNum%, BuyProgress
	GuiControl,CrushCrushBuy:,BuyProgress, 0
	UpdateBuyStatus()
	BuyGift(GiftName)
return

Date:
	Gui, Submit, NoHide
	s = %DateNum%
	GuiControl,CrushCrushBuy:+Range0-%DateNum%, DateProgress
	GuiControl,CrushCrushBuy:,DateProgress, 0
	GoDate(d)
return

^+!r::
	ShowGuiWindow()
return

UpdateBuyStatus()
{
	global
	prog := GiftNum - r
	GuiControl,CrushCrushBuy:,BuyStatusText,%r% remain
	GuiControl,CrushCrushBuy:, BuyProgress, %prog%
}

UpdateDateStatus()
{
	global
	GuiControl,CrushCrushBuy:,DateStatusText,%s% remain
	GuiControl,CrushCrushBuy:,DateProgress, +1
}

ClearBuyStatus()
{
	r := 0
	GuiControl,CrushCrushBuy:,BuyStatusText,
	GuiControl,CrushCrushBuy:, BuyProgress, 0
}

ClearDateStatus()
{
	s := 0
	GuiControl,CrushCrushBuy:,DateStatusText,
	GuiControl,CrushCrushBuy:, DateProgress, 0
}

GoDate(date)
{
	global
	ClickDate(date)
	ClickDatePay()
	Loop %DateNum% {
		UpdateDateStatus()
		Sleep %WaitToDate%
		ClickDateGoAgain()
		s--
	}
	ClickDateComplete()
	UpdateDateStatus()
}

ClickDate(date)
{
	IfWinExist Crush Crush
	{
		WinActivate
	} else 
	{
		MsgBox Window not found
		return
	}
	DFunc = ClickDate%date%
	If IsFunc(DFunc)
	{
		ClickCloseTabButton()
		ClickDateButton()
		%DFunc%()
	} else {
		MsgBox Function %DFunc% not found
	}
}

BuyGift(gift)
{
	global r
	IfWinExist Crush Crush
	{
		WinActivate
	} else 
	{
		MsgBox Window not found
		return
	}
	while (r >= 10000) {
		ClickGift(gift)
		Loop 7 {
			ClickGiftPlus()
		}
		ClickGiftPay()
		r -= 10000
		UpdateBuyStatus()
	}
	while (r >= 1000) {
		ClickGift(gift)
		Loop 6 {
			ClickGiftPlus()
		}
		ClickGiftPay()
		r -= 1000
		UpdateBuyStatus()
	}
	while (r >= 100) {
		ClickGift(gift)
		Loop 5 {
			ClickGiftPlus()
		}
		ClickGiftPay()
		r -= 100
		UpdateBuyStatus()
	}
	while (r >= 50) {
		ClickGift(gift)
		Loop 4 {
			ClickGiftPlus()
		}
		ClickGiftPay()
		r -= 50
		UpdateBuyStatus()
	}
	while (r >= 25) {
		ClickGift(gift)
		Loop 3 {
			ClickGiftPlus()
		}
		ClickGiftPay()
		r -= 25
		UpdateBuyStatus()
	}
	while (r >= 10) {
		ClickGift(gift)
		ClickGiftPlus()
		ClickGiftPlus()
		ClickGiftPay()
		r -= 10
		UpdateBuyStatus()
	}
	while (r >= 5) {
		ClickGift(gift)
		ClickGiftPlus()
		ClickGiftPay()
		r -= 5
		UpdateBuyStatus()
	}
	while (r >= 1) {
		ClickGift(gift)
		ClickGiftPay()
		r -= 1
		UpdateBuyStatus()
	}
;	ClearBuyStatus()
}

ClickGift(gift)
{
	ClickCloseTabButton()
	ClickGiftButton()
	if (gift = "shell")
	{
		ClickGift1()
	} else if (gift = "rose")
	{
		ClickGift2()
	} else if (gift = "handlotion")
	{
		ClickGift3()
	} else if (gift = "donut")
	{
		ClickGift4()
	} else if (gift = "fruitbasket")
	{
		ClickGift5()
	} else if (gift = "chocolates")
	{
		ClickGift6()
	} else if (gift = "book")
	{
		ClickGift7()
	} else if (gift = "earrings")
	{
		ClickGift8()
	} else if (gift = "drink")
	{
		ClickNextGiftPage()
		ClickGift1()
	} else if (gift = "flowers")
	{
		ClickNextGiftPage()
		ClickGift2()
	} else if (gift = "cake")
	{
		ClickNextGiftPage()
		ClickGift3()
	} else if (gift = "plushytoy")
	{
		ClickNextGiftPage()
		ClickGift4()
	} else if (gift = "teaset")
	{
		ClickNextGiftPage()
		ClickGift5()
	} else if (gift = "shoes")
	{
		ClickNextGiftPage()
		ClickGift6()
	} else if (gift = "cutepuppy")
	{
		ClickNextGiftPage()
		ClickGift7()
	} else if (gift = "necklace")
	{
		ClickNextGiftPage()
		ClickGift8()
	} else if (gift = "designerbag")
	{
		ClickNextGiftPage()
		ClickNextGiftPage()
		ClickGift1()
	} else if (gift = "newcar")
	{
		ClickNextGiftPage()
		ClickNextGiftPage()
		ClickGift2()
	} else
	{
		MsgBox Gift not found
	}
}

ClickFlirtButton()
{
	Click 760, 240
}

ClickStatsButton()
{
	Click 760, 290
}

ClickGiftButton()
{
	Click 760, 340
}

ClickDateButton()
{
	Click 760, 390
}

ClickCloseTabButton()
{
	Click 680, 230
}

ClickNextGiftPage()
{
	Click 650, 250
}

ClickGift1()
{
	Click 400, 300
}

ClickGift2()
{
	Click 600, 300
}

ClickGift3()
{
	Click 400, 380
}

ClickGift4()
{
	Click 600, 380
}

ClickGift5()
{
	Click 400, 460
}

ClickGift6()
{
	Click 600, 460
}

ClickGift7()
{
	Click 400, 540
}

ClickGift8()
{
	Click 600, 540
}

ClickGiftPlus()
{
	Click 840, 450
}

ClickGiftPay()
{
	Click 900, 400
}

ClickDateMoonlight()
{
	Click 500, 300
}

ClickDateMovie()
{
	Click 500, 380
}

ClickDateSightseeing()
{
	Click 500, 460
}

ClickDateBeach()
{
	Click 500, 540
}

ClickDatePay()
{
	Click 900, 400
}

ClickDateGoAgain()
{
	Click 400, 560
}

ClickDateComplete()
{
	Click 900, 560
}
