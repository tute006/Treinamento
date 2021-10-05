$PBExportHeader$w_cadastrodepartamento_original.srw
$PBExportComments$Janela de manutenção de departamentos - antes de herdar de janela da biblioteca
forward
global type w_cadastrodepartamento_original from window
end type
type cb_adicionar from commandbutton within w_cadastrodepartamento_original
end type
type cb_recuperar from commandbutton within w_cadastrodepartamento_original
end type
type cb_apagar from commandbutton within w_cadastrodepartamento_original
end type
type cb_gravar from commandbutton within w_cadastrodepartamento_original
end type
type cb_inserir from commandbutton within w_cadastrodepartamento_original
end type
type dw_departamento from datawindow within w_cadastrodepartamento_original
end type
end forward

global type w_cadastrodepartamento_original from window
integer width = 3776
integer height = 1560
boolean titlebar = true
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
string icon = "ApplicationIcon2!"
boolean center = true
event ue_inserir ( long al_numlinha )
event ue_teste ( )
event ue_gravar ( )
event ue_excluir ( )
event ue_recuperar ( )
cb_adicionar cb_adicionar
cb_recuperar cb_recuperar
cb_apagar cb_apagar
cb_gravar cb_gravar
cb_inserir cb_inserir
dw_departamento dw_departamento
end type
global w_cadastrodepartamento_original w_cadastrodepartamento_original

forward prototypes
public function integer of_arearegulo (integer lado, integer altura)
end prototypes

event ue_inserir(long al_numlinha);

// insere uma linha na datawindow, na posição da linha atual, empurrando as demais linhas para posição subsequente.
dw_Departamento.insertRow (al_NumLinha)


return

end event

event ue_gravar();integer li_Retorno						// retorno da função

// atualiza as informações da datawindow no banco de dados
li_Retorno = dw_Departamento.update()
if (li_Retorno = -1) then
	// cancela / desfaz as transações feitas no banco de dados
	rollback ;
	
	// importante que a message box apareça depois do rollback para que o banco de dados
	// não seja travado, caso o usuário demore a apertar o botão ok
	messageBox ('Gravação', 'Erro na gravação. ' + sqlca.SQLErrText, StopSign!)
end if


// efetiva as transações feitas até o momento no banco de dados
commit;


return



end event

event ue_excluir();// apaga a linha corrente da datawindow
// o parâmetro 0 informa que será apagada a linha corrente (atualmente selecionada ou onde se encontra o cursor)
// caso necessite apagar uma linha específica, informe o número da linha ao invés de 0.
// a linha não será apagada do banco de dados imediatamente e sim movida para o buffer deleted.
dw_Departamento.deleteRow (0)

return
end event

event ue_recuperar();long ll_QtdLinha							// quantidade de linhas recuperadas do banco de dados

// recupera os dados através do comando sql associado com a datawindow.
// este comando retorna o número de linha recuperadas. Caso ocorra algum erro, esse comando retornará -1.
ll_QtdLinha = dw_Departamento.retrieve()

// verifica se houve erro
if (ll_QtdLinha < 0) then
	messageBox ('', 'Houve erro na recuperação de dados', StopSign!)
	return
end if

return

end event

public function integer of_arearegulo (integer lado, integer altura);long Area

Area = Lado * Altura

return Area

end function

on w_cadastrodepartamento_original.create
this.cb_adicionar=create cb_adicionar
this.cb_recuperar=create cb_recuperar
this.cb_apagar=create cb_apagar
this.cb_gravar=create cb_gravar
this.cb_inserir=create cb_inserir
this.dw_departamento=create dw_departamento
this.Control[]={this.cb_adicionar,&
this.cb_recuperar,&
this.cb_apagar,&
this.cb_gravar,&
this.cb_inserir,&
this.dw_departamento}
end on

on w_cadastrodepartamento_original.destroy
destroy(this.cb_adicionar)
destroy(this.cb_recuperar)
destroy(this.cb_apagar)
destroy(this.cb_gravar)
destroy(this.cb_inserir)
destroy(this.dw_departamento)
end on

event open;long ll_QtdLinha							// quantidade de linha recuperadas


// o comando SetTransObject associa a datawindow com a conexão. Se esse comando o Powerbuilder não sabe de onde os dados
// serão lidos. Desta forma, se uma janela (window) possuir mais de uma datawindow, nada impede que cada uma dela seja
// conectada a uma conexão diferente.
dw_Departamento.setTransObject (sqlca)


// reaproveitar o script de recuperação do botão recuperar
//cb_Recuperar.event clicked( )

// recupera dados na tela
event ue_Recuperar( )

// recupera os dados através do comando sql associado com a datawindow.
// este comando retorna o número de linha recuperadas. Caso ocorra algum erro, esse comando retornará -1.
/*ll_QtdLinha = dw_Departamento.retrieve()

// verifica se houve erro
if (ll_QtdLinha < 0) then
	messageBox ('', 'Erro ao recuperar os dados', StopSign!)
	return
end if*/


return

end event

event closequery;integer li_Resposta						// resposta do usuário

// Accept the last data entered into the datawindow
dw_Departamento.AcceptText()
 
//Check to see if any data has changed
if dw_Departamento.DeletedCount() + dw_Departamento.ModifiedCount() > 0 then
   li_Resposta = MessageBox("Fechando", "Deseja gravar os dados antes?", Question!, YesNoCancel!, 3)
 
 	choose case li_Resposta
		case 1	// Sim - usuário escolheu gravar antes de fechar
			cb_Gravar.event clicked( )
			return 0
		  
		case 2	// Não usuário que sair sem gravar
			return 0
		case 3	// Cancela fechamento de janela
			return 1
	end choose
else
   // Se não houver dados apagados ou modificados a janela é fechada
	return 0
end if


end event

type cb_adicionar from commandbutton within w_cadastrodepartamento_original
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

event clicked;parent.event ue_Inserir (0)

return

end event

type cb_recuperar from commandbutton within w_cadastrodepartamento_original
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

event clicked;parent.event ue_Recuperar()

return
end event

type cb_apagar from commandbutton within w_cadastrodepartamento_original
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

event clicked;event ue_Excluir( )


return 

end event

type cb_gravar from commandbutton within w_cadastrodepartamento_original
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

event clicked;parent.event ue_Gravar()


return
end event

type cb_inserir from commandbutton within w_cadastrodepartamento_original
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

event clicked;long ll_LinhaAtual							// linha atual da datawindow

// buscar a linha corrente (atual) da datawindow
ll_LinhaAtual = dw_Departamento.getRow()


parent.event ue_Inserir(ll_LinhaAtual)

return

end event

type dw_departamento from datawindow within w_cadastrodepartamento_original
integer x = 32
integer y = 16
integer width = 3122
integer height = 920
integer taborder = 20
string title = "none"
string dataobject = "d_lista_departamento"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event sqlpreview;
string ls_Teste


ls_Teste = ''
end event

