$PBExportHeader$w_selecao_tela.srw
$PBExportComments$Seleção de tela
forward
global type w_selecao_tela from window
end type
type rb_manterfuncionario from radiobutton within w_selecao_tela
end type
type rb_manterdepto from radiobutton within w_selecao_tela
end type
type rb_mantercargo from radiobutton within w_selecao_tela
end type
type cb_cancela from commandbutton within w_selecao_tela
end type
type cb_ok from commandbutton within w_selecao_tela
end type
type gb_selecaotela from groupbox within w_selecao_tela
end type
end forward

global type w_selecao_tela from window
integer width = 1536
integer height = 1120
boolean titlebar = true
string title = "Principal"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
rb_manterfuncionario rb_manterfuncionario
rb_manterdepto rb_manterdepto
rb_mantercargo rb_mantercargo
cb_cancela cb_cancela
cb_ok cb_ok
gb_selecaotela gb_selecaotela
end type
global w_selecao_tela w_selecao_tela

type variables
constant integer cii_TelaCargo = 1							// assoaciação com tela de cargo
constant integer cii_TelaDepto = 2							// assoaciação com tela de departamento
constant integer cii_TelaFuncionario = 3					// assoaciação com tela de funcionário

integer vii_OpcaoTela											// opção de tela selecionada pelo usuário
end variables

on w_selecao_tela.create
this.rb_manterfuncionario=create rb_manterfuncionario
this.rb_manterdepto=create rb_manterdepto
this.rb_mantercargo=create rb_mantercargo
this.cb_cancela=create cb_cancela
this.cb_ok=create cb_ok
this.gb_selecaotela=create gb_selecaotela
this.Control[]={this.rb_manterfuncionario,&
this.rb_manterdepto,&
this.rb_mantercargo,&
this.cb_cancela,&
this.cb_ok,&
this.gb_selecaotela}
end on

on w_selecao_tela.destroy
destroy(this.rb_manterfuncionario)
destroy(this.rb_manterdepto)
destroy(this.rb_mantercargo)
destroy(this.cb_cancela)
destroy(this.cb_ok)
destroy(this.gb_selecaotela)
end on

type rb_manterfuncionario from radiobutton within w_selecao_tela
integer x = 256
integer y = 420
integer width = 631
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Manter &funcionário"
end type

event clicked;vii_OpcaoTela = cii_TelaFuncionario

return

end event

type rb_manterdepto from radiobutton within w_selecao_tela
integer x = 256
integer y = 304
integer width = 690
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Manter &departamento"
end type

event clicked;vii_OpcaoTela = cii_TelaDepto

return

end event

type rb_mantercargo from radiobutton within w_selecao_tela
integer x = 256
integer y = 188
integer width = 631
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Manter &cargo"
end type

event clicked;vii_OpcaoTela = cii_TelaCargo

return



end event

type cb_cancela from commandbutton within w_selecao_tela
integer x = 901
integer y = 796
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

event clicked;close (parent)

return

end event

type cb_ok from commandbutton within w_selecao_tela
integer x = 242
integer y = 796
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

event clicked;string vls_MensagemOpcaoSelecionada							// texto relacionado à mensagem

//if (rb_ManterCargo.checked) then
//	messageBox ('Seleção', 'Seleção usuário: ' + ' Manter cargo')
//end if
//
//if (rb_ManterDepto.checked) then
//	messageBox ('Seleção', 'Seleção usuário: ' + ' Manter departemento')
//end if
//
//if (rb_ManterFuncionario.checked) then
//	messageBox ('Seleção', 'Seleção usuário: ' + ' Manter Funcionário')
//end if


choose case vii_OpcaoTela
	case cii_TelaCargo
		Open (w_Manut_Cargo_mdi)
		
	case cii_TelaDepto
		Open (w_Manut_Depto_mdi)
		
	case cii_TelaFuncionario
		Open (w_Manut_Func_mdi)
		
end choose


//messageBox ('Seleção', 'Seleção usuário: ' + vls_MensagemOpcaoSelecionada)


return

end event

type gb_selecaotela from groupbox within w_selecao_tela
integer x = 187
integer y = 92
integer width = 763
integer height = 456
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Selecione a tela"
end type

