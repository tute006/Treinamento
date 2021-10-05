$PBExportHeader$w_olamundo.srw
$PBExportComments$Primeira janela Powerbuilder
forward
global type w_olamundo from window
end type
type st_Mensagem from statictext within w_olamundo
end type
end forward

global type w_olamundo from window
integer width = 4754
integer height = 1980
boolean titlebar = true
string title = "Primeira aplicação"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_Mensagem st_Mensagem
end type
global w_olamundo w_olamundo

on w_olamundo.create
this.st_Mensagem=create st_Mensagem
this.Control[]={this.st_Mensagem}
end on

on w_olamundo.destroy
destroy(this.st_Mensagem)
end on

type st_Mensagem from statictext within w_olamundo
integer x = 1065
integer y = 820
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Olá Mundo"
boolean focusrectangle = false
end type

