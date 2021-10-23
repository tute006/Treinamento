$PBExportHeader$w_manutencao.srw
$PBExportComments$Janela manutenção genérica.
forward
global type w_manutencao from window
end type
type mle_filtro from multilineedit within w_manutencao
end type
type dw_manutencao from uo_datawindow_ancestral within w_manutencao
end type
end forward

global type w_manutencao from window
integer width = 3803
integer height = 1660
boolean titlebar = true
string menuname = "m_ancestral"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 12632256
string icon = "ApplicationIcon2!"
boolean center = true
event ue_inserir ( long al_numlinha )
event ue_teste ( )
event ue_gravar ( )
event ue_excluir ( )
event ue_recuperar ( )
event type boolean ue_validardados ( ref string as_mensagemerro )
event type boolean ue_antesgravacao ( ref string as_mensagemerro )
event type boolean ue_aposgravacao ( ref string as_mensagemerro )
event ue_adicionarlinha ( )
event ue_inserirlinha ( )
event ue_inicializacao ( )
event ue_exportar ( )
event ue_filtrar ( )
mle_filtro mle_filtro
dw_manutencao dw_manutencao
end type
global w_manutencao w_manutencao

type variables
protected:
boolean ib_AjustarLarguraDw = false
boolean ib_AjustarAlturaDw = false



end variables

forward prototypes
public function integer of_arearegulo (integer lado, integer altura)
public function integer wf_janela ()
end prototypes

event ue_inserir(long al_numlinha);// insere uma linha na datawindow, na posição da linha atual, empurrando as demais linhas para posição subsequente.
dw_Manutencao.insertRow (al_NumLinha)


return

end event

event ue_gravar();boolean lb_Ok								// indica se está tudo bem (true) ou não (false)
integer li_Retorno						// retorno da função
string ls_MensagemErro					// mensagem de erro

// verificar se os dados a serem gravados estão corretos
lb_Ok = event ue_ValidarDados (ls_MensagemErro)
if (not lb_Ok) then
	messageBox ('Erro de validação', ls_MensagemErro, StopSign!)
	return
end if

// ações antes de gravar
lb_Ok = event ue_AntesGravacao(ls_MensagemErro)
if (not lb_Ok) then
	// cancela / desfaz as transações feitas no banco de dados
	rollback ;

	messageBox ('Erro antes de gravar', ls_MensagemErro, StopSign!)
	return
end if


// atualiza as informações da datawindow no banco de dados
li_Retorno = dw_Manutencao.update()
if (li_Retorno = -1) then
	// cancela / desfaz as transações feitas no banco de dados
	rollback ;
	
	// importante que a message box apareça depois do rollback para que o banco de dados
	// não seja travado, caso o usuário demore a apertar o botão ok
	messageBox ('Gravação', 'Erro na gravação. ' + sqlca.SQLErrText, StopSign!)
end if

// ações após de gravar
lb_Ok = event ue_AposGravacao(ls_MensagemErro)
if (not lb_Ok) then
	// cancela / desfaz as transações feitas no banco de dados
	rollback ;
	
	messageBox ('Erro após gravação', ls_MensagemErro, StopSign!)
	return
end if


// efetiva as transações feitas até o momento no banco de dados
commit;


return



end event

event ue_excluir();// apaga a linha corrente da datawindow
// o parâmetro 0 informa que será apagada a linha corrente (atualmente selecionada ou onde se encontra o cursor)
// caso necessite apagar uma linha específica, informe o número da linha ao invés de 0.
// a linha não será apagada do banco de dados imediatamente e sim movida para o buffer deleted.
dw_Manutencao.deleteRow (0)

return
end event

event type boolean ue_validardados(ref string as_mensagemerro);// escreva neste evento as validações da datawindow 


return true

end event

event type boolean ue_antesgravacao(ref string as_mensagemerro);// escreva neste evento as ações antes de gravar os dados


return true

end event

event type boolean ue_aposgravacao(ref string as_mensagemerro);// escreva neste evento as ações após gravar os dados


return true

end event

event ue_adicionarlinha();// insere linha no final
event ue_Inserir(0)

return
end event

event ue_inserirlinha();long ll_LinhaAtual							// linha atual da datawindow

// buscar a linha corrente (atual) da datawindow
ll_LinhaAtual = dw_Manutencao.getRow()

// evento para inserir uma nova linha
event ue_Inserir (ll_LinhaAtual)

// obs: o pronome "parent" indica que o evento a ser chamado é do pai (onde o objeto está associado) do objeto, ou seja, a window onde o botão está associado


return

end event

event ue_inicializacao();// este evento é executado ao final da fila
end event

event ue_exportar();string ls_path_Nome 
string ls_nome_arquivo
int li_retorno
string ls_extensao_arquivo


li_retorno = GetFileSaveName ( 'Seleciona Arquivo',  ls_path_Nome, ls_nome_arquivo , 'TXT', &
   "Excel (*.xls),*.xls, Texto(*.txt), *.txt, Todos os Arquivos (*.*),*.*" )
 
IF li_retorno < 1 Then
  return
End If

ls_extensao_arquivo = right (ls_nome_arquivo, 3)
choose case ls_extensao_arquivo
	case 'txt'
		dw_manutencao.SaveAs(ls_path_Nome, text!, true)
		case 'xls'
		dw_manutencao.SaveAs(ls_path_Nome, Excel5!, true)
	case else
		dw_manutencao.SaveAs(ls_path_Nome, text!, true)
end choose


end event

event ue_filtrar();string ls_Filtro

ls_Filtro = mle_Filtro.text


dw_Manutencao.setFilter(ls_Filtro)
dw_Manutencao.filter()
end event

public function integer of_arearegulo (integer lado, integer altura);long Area

Area = Lado * Altura

return Area

end function

public function integer wf_janela ();return 1

end function

on w_manutencao.create
if this.MenuName = "m_ancestral" then this.MenuID = create m_ancestral
this.mle_filtro=create mle_filtro
this.dw_manutencao=create dw_manutencao
this.Control[]={this.mle_filtro,&
this.dw_manutencao}
end on

on w_manutencao.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mle_filtro)
destroy(this.dw_manutencao)
end on

event open;long ll_QtdLinha							// quantidade de linha recuperadas


// o comando SetTransObject associa a datawindow com a conexão. Se esse comando o Powerbuilder não sabe de onde os dados
// serão lidos. Desta forma, se uma janela (window) possuir mais de uma datawindow, nada impede que cada uma dela seja
// conectada a uma conexão diferente.
dw_Manutencao.setTransObject (sqlca)


// reaproveitar o script de recuperação do botão recuperar
//cb_Recuperar.event clicked( )

// recupera dados na tela
//this.event ue_Recuperar()


post event ue_Inicializacao()

// obs: o pronome this indica que o evento a ser chamado é do próprio objeto, ou seja, da própria Window


// recupera os dados através do comando sql associado com a datawindow.
// este comando retorna o número de linha recuperadas. Caso ocorra algum erro, esse comando retornará -1.
/*ll_QtdLinha = dw_Manutencao.retrieve()

// verifica se houve erro
if (ll_QtdLinha < 0) then
	messageBox ('', 'Erro ao recuperar os dados', StopSign!)
	return
end if*/


return

end event

event closequery;integer li_Resposta						// resposta do usuário

// Accept the last data entered into the datawindow
dw_Manutencao.AcceptText()
 
//Check to see if any data has changed
if dw_Manutencao.DeletedCount() + dw_Manutencao.ModifiedCount() > 0 then
   li_Resposta = MessageBox("Fechando", "Deseja gravar os dados antes?", Question!, YesNoCancel!, 3)
 
 	choose case li_Resposta
		case 1	// Sim - usuário escolheu gravar antes de fechar
			event ue_Gravar()
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

event resize;
if (ib_AjustarLarguraDw) then
	dw_manutencao.width = newWidth - dw_manutencao.x - dw_manutencao.x
end if

if (ib_AjustarAlturaDw) then
	dw_manutencao.height = newHeight - dw_manutencao.y - dw_manutencao.y
end if

return


end event

type mle_filtro from multilineedit within w_manutencao
integer x = 869
integer y = 968
integer width = 480
integer height = 400
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type dw_manutencao from uo_datawindow_ancestral within w_manutencao
event ue_eventodw ( )
integer x = 32
integer y = 32
integer width = 2793
integer height = 1024
integer taborder = 20
boolean hscrollbar = true
boolean vscrollbar = true
end type

