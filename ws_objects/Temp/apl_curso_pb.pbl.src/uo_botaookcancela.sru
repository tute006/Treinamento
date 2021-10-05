$PBExportHeader$uo_botaookcancela.sru
forward
global type uo_botaookcancela from userobject
end type
type cb_cancela from commandbutton within uo_botaookcancela
end type
type cb_Ok from commandbutton within uo_botaookcancela
end type
end forward

global type uo_botaookcancela from userobject
integer width = 1376
integer height = 288
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
cb_cancela cb_cancela
cb_Ok cb_Ok
end type
global uo_botaookcancela uo_botaookcancela

on uo_botaookcancela.create
this.cb_cancela=create cb_cancela
this.cb_Ok=create cb_Ok
this.Control[]={this.cb_cancela,&
this.cb_Ok}
end on

on uo_botaookcancela.destroy
destroy(this.cb_cancela)
destroy(this.cb_Ok)
end on

type cb_cancela from commandbutton within uo_botaookcancela
integer x = 603
integer y = 64
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Cancela"
boolean cancel = true
end type

event clicked;triggerEvent ("Cancela")
end event

type cb_Ok from commandbutton within uo_botaookcancela
integer x = 96
integer y = 68
integer width = 402
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Ok"
boolean default = true
end type

event clicked;triggerEvent ("Ok")
end event

