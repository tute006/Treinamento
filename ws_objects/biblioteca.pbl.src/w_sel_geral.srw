$PBExportHeader$w_sel_geral.srw
$PBExportComments$Seleção Geral
forward
global type w_sel_geral from window
end type
type cb_cancela from commandbutton within w_sel_geral
end type
type cb_ok from commandbutton within w_sel_geral
end type
type d_selecao from datawindow within w_sel_geral
end type
end forward

global type w_sel_geral from window
integer width = 2825
integer height = 1064
boolean titlebar = true
string title = "Janela de Seleção"
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
event ue_selecao_linha ( long al_num_linha,  string as_nome_coluna )
cb_cancela cb_cancela
cb_ok cb_ok
d_selecao d_selecao
end type
global w_sel_geral w_sel_geral

type variables
str_parametros istr_Parametros_Retorno
end variables

event open;d_Selecao.setTransObject (sqlca)

d_Selecao.retrieve()

//comentario


end event

on w_sel_geral.create
this.cb_cancela=create cb_cancela
this.cb_ok=create cb_ok
this.d_selecao=create d_selecao
this.Control[]={this.cb_cancela,&
this.cb_ok,&
this.d_selecao}
end on

on w_sel_geral.destroy
destroy(this.cb_cancela)
destroy(this.cb_ok)
destroy(this.d_selecao)
end on

type cb_cancela from commandbutton within w_sel_geral
integer x = 2478
integer y = 196
integer width = 265
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

event clicked;istr_Parametros_Retorno.cancelado = true


closeWithReturn (parent, istr_Parametros_Retorno)

end event

type cb_ok from commandbutton within w_sel_geral
integer x = 2478
integer y = 60
integer width = 265
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Ok"
boolean default = true
end type

event clicked;istr_Parametros_Retorno.cancelado = false


closeWithReturn (parent, istr_Parametros_Retorno)

end event

type d_selecao from datawindow within w_sel_geral
integer x = 9
integer y = 8
integer width = 2418
integer height = 908
integer taborder = 10
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;string ls_ColunaClicada

ls_ColunaClicada = dwo.name

if (row = 0) then
	return
end if

event ue_Selecao_Linha(row, ls_ColunaClicada )


return




end event

event doubleclicked;string ls_ColunaClicada
string ls_ColunaOrdenacao

ls_ColunaClicada = dwo.name

if (row <> 0) then
	return
end if



return




end event

