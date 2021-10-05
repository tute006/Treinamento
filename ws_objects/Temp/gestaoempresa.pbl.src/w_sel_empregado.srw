$PBExportHeader$w_sel_empregado.srw
$PBExportComments$Janela de seleção de empregado
forward
global type w_sel_empregado from window
end type
type cb_cancela from commandbutton within w_sel_empregado
end type
type cb_novo from commandbutton within w_sel_empregado
end type
type cb_ok from commandbutton within w_sel_empregado
end type
type dw_selecao from datawindow within w_sel_empregado
end type
end forward

global type w_sel_empregado from window
integer width = 2437
integer height = 872
boolean titlebar = true
string title = "Selecione o empregado"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_cancela cb_cancela
cb_novo cb_novo
cb_ok cb_ok
dw_selecao dw_selecao
end type
global w_sel_empregado w_sel_empregado

on w_sel_empregado.create
this.cb_cancela=create cb_cancela
this.cb_novo=create cb_novo
this.cb_ok=create cb_ok
this.dw_selecao=create dw_selecao
this.Control[]={this.cb_cancela,&
this.cb_novo,&
this.cb_ok,&
this.dw_selecao}
end on

on w_sel_empregado.destroy
destroy(this.cb_cancela)
destroy(this.cb_novo)
destroy(this.cb_ok)
destroy(this.dw_selecao)
end on

event open;// conecta a transação sqlca à datawindow
dw_Selecao.setTransObject (sqlca)

// recupera empregados
dw_Selecao.retrieve (vgl_CodAluno)


return
end event

type cb_cancela from commandbutton within w_sel_empregado
integer x = 2117
integer y = 380
integer width = 279
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Cancela"
boolean cancel = true
end type

event clicked;str_sel_empregado vlstr_Selecao		// parâmetros selecionados

// monta parâmetros de retorno
vlstr_Selecao.cancelado = true

// retorna parâmetros para janela que chamou
closeWithReturn (parent, vlstr_Selecao)

return


end event

type cb_novo from commandbutton within w_sel_empregado
integer x = 2117
integer y = 228
integer width = 279
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Novo"
end type

event clicked;str_sel_empregado vlstr_Selecao		// parâmetros selecionados

// monta parâmetros de retorno
vlstr_Selecao.novoEmpregado = true

// retorna parâmetros para janela que chamou
closeWithReturn (parent, vlstr_Selecao)

return


end event

type cb_ok from commandbutton within w_sel_empregado
integer x = 2117
integer y = 76
integer width = 279
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Ok"
end type

event clicked;integer vli_LinhaSelecionada			// linha selecionada
str_sel_empregado vlstr_Selecao		// parâmetros selecionados

// obtém linha selecionada
vli_LinhaSelecionada = dw_Selecao.GetSelectedRow(0)

// verifica se há linha selecionada
if (vli_LinhaSelecionada = 0) then
	messageBox ('Seleção', 'Não há linha selecionada', Exclamation!)
	return
end if


// monta parâmetros de retorno
vlstr_Selecao.matricula = dw_Selecao.getItemNumber (vli_LinhaSelecionada, 'cod_empregado')
vlstr_Selecao.nome = dw_Selecao.getItemString (vli_LinhaSelecionada, 'nome_empregado')

// retorna parâmetros para janela que chamou
closeWithReturn (parent, vlstr_Selecao)

return


end event

type dw_selecao from datawindow within w_sel_empregado
integer x = 32
integer y = 20
integer width = 2057
integer height = 740
integer taborder = 10
string title = "none"
string dataobject = "d_sel_empregado"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;// desmarca todas as linhas
selectRow (0, false)

// marca linha clicada
selectRow (row, false)


return

end event

