$PBExportHeader$w_cadastrodepartamento.srw
$PBExportComments$Janela de cadastro de departamentos
forward
global type w_cadastrodepartamento from window
end type
type cb_apagaultimalinha from commandbutton within w_cadastrodepartamento
end type
type cb_adicionar from commandbutton within w_cadastrodepartamento
end type
type cb_recuperar from commandbutton within w_cadastrodepartamento
end type
type cb_apagar from commandbutton within w_cadastrodepartamento
end type
type cb_gravar from commandbutton within w_cadastrodepartamento
end type
type cb_inserir from commandbutton within w_cadastrodepartamento
end type
type dw_departamento from datawindow within w_cadastrodepartamento
end type
end forward

global type w_cadastrodepartamento from window
integer width = 3776
integer height = 1560
boolean titlebar = true
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
string icon = "ApplicationIcon2!"
boolean center = true
cb_apagaultimalinha cb_apagaultimalinha
cb_adicionar cb_adicionar
cb_recuperar cb_recuperar
cb_apagar cb_apagar
cb_gravar cb_gravar
cb_inserir cb_inserir
dw_departamento dw_departamento
end type
global w_cadastrodepartamento w_cadastrodepartamento

on w_cadastrodepartamento.create
this.cb_apagaultimalinha=create cb_apagaultimalinha
this.cb_adicionar=create cb_adicionar
this.cb_recuperar=create cb_recuperar
this.cb_apagar=create cb_apagar
this.cb_gravar=create cb_gravar
this.cb_inserir=create cb_inserir
this.dw_departamento=create dw_departamento
this.Control[]={this.cb_apagaultimalinha,&
this.cb_adicionar,&
this.cb_recuperar,&
this.cb_apagar,&
this.cb_gravar,&
this.cb_inserir,&
this.dw_departamento}
end on

on w_cadastrodepartamento.destroy
destroy(this.cb_apagaultimalinha)
destroy(this.cb_adicionar)
destroy(this.cb_recuperar)
destroy(this.cb_apagar)
destroy(this.cb_gravar)
destroy(this.cb_inserir)
destroy(this.dw_departamento)
end on

event open;dw_Departamento.setTransObject (sqlca)

dw_Departamento.retrieve()
end event

type cb_apagaultimalinha from commandbutton within w_cadastrodepartamento
integer x = 3269
integer y = 816
integer width = 402
integer height = 112
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Apag.Último"
end type

event clicked;long ll_UltimaLinha

// buscar a linha corrente (atual)
ll_UltimaLinha = dw_Departamento.rowCount()


// apaga a linha corrente da datawindow
dw_Departamento.deleteRow (ll_UltimaLinha)
end event

type cb_adicionar from commandbutton within w_cadastrodepartamento
integer x = 3269
integer y = 668
integer width = 402
integer height = 112
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Adicionar"
end type

event clicked;// adiciona linha ao final da datawindow
// 0 - significa que será no final
dw_Departamento.insertRow(0)
end event

type cb_recuperar from commandbutton within w_cadastrodepartamento
integer x = 3269
integer y = 508
integer width = 402
integer height = 112
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Recuperar"
end type

event clicked;// recupera as informações do banco de dados
dw_Departamento.retrieve()
end event

type cb_apagar from commandbutton within w_cadastrodepartamento
integer x = 3269
integer y = 348
integer width = 402
integer height = 112
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Apagar"
end type

event clicked;// apaga a linha corrente da datawindow
dw_Departamento.deleteRow (0)
end event

type cb_gravar from commandbutton within w_cadastrodepartamento
integer x = 3269
integer y = 188
integer width = 402
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Gravar"
end type

event clicked;integer li_Retorno

// atualiza as informações da datawindow no banco de dados
li_Retorno = dw_Departamento.update()
if (li_Retorno = -1) then
	messageBox ('Gravação', 'Erro na conexão. ' + sqlca.SQLErrText, StopSign!)
	rollback ;
end if

commit;



end event

type cb_inserir from commandbutton within w_cadastrodepartamento
integer x = 3269
integer y = 28
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Inserir"
end type

event clicked;long ll_LinhaAtual

// buscar a linha corrente (atual)
ll_LinhaAtual = dw_Departamento.getRow()


// adiciona linha ao final da datawindow
// 0 - significa que será no final
dw_Departamento.insertRow (ll_LinhaAtual)



end event

type dw_departamento from datawindow within w_cadastrodepartamento
integer x = 32
integer y = 16
integer width = 3122
integer height = 920
integer taborder = 20
string title = "none"
string dataobject = "d_lista_departamento"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event sqlpreview;
string ls_Teste


ls_Teste = ''
end event

