$PBExportHeader$w_manut_departamento_backup.srw
$PBExportComments$Tela de manutenção de departamentos
forward
global type w_manut_departamento_backup from window
end type
type cb_gravar from commandbutton within w_manut_departamento_backup
end type
type cb_excluir from commandbutton within w_manut_departamento_backup
end type
type cb_inserir from commandbutton within w_manut_departamento_backup
end type
type cb_adicionar from commandbutton within w_manut_departamento_backup
end type
type dw_departamento from datawindow within w_manut_departamento_backup
end type
end forward

global type w_manut_departamento_backup from window
integer width = 2683
integer height = 1052
boolean titlebar = true
string title = "Manutenção Departamento"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
event type boolean ue_inserirlinha ( long al_numlinha )
event type boolean ue_excluirlinha ( long al_numlinha )
event type boolean ue_gravardados ( ref string as_mensagemerro )
event type long ue_recuperardados ( ref string as_mensagemerro )
event ue_inicializacao ( )
event type boolean ue_verificagravacaopendente ( )
event type boolean ue_validadados ( ref string as_mensagemerro )
cb_gravar cb_gravar
cb_excluir cb_excluir
cb_inserir cb_inserir
cb_adicionar cb_adicionar
dw_departamento dw_departamento
end type
global w_manut_departamento_backup w_manut_departamento_backup

forward prototypes
public function boolean of_verificaregistroduplicado (integer ai_numlinha, ref string as_mensagemerro)
end prototypes

event type boolean ue_inserirlinha(long al_numlinha);integer vli_NumLinhaInserida				// número da linha inserida


// insere na posição da linha corrente da datawindow
vli_NumLinhaInserida = dw_Departamento.insertRow (al_NumLinha)


// atribui o código do aluno à nova linha
dw_Departamento.setItem (vli_NumLinhaInserida, 'cod_aluno', vgl_CodAluno)


Return true

end event

event type boolean ue_excluirlinha(long al_numlinha);// apaga a linha na posição indicada
dw_Departamento.deleteRow (al_NumLinha)


return true

end event

event type boolean ue_gravardados(ref string as_mensagemerro);boolean vlb_Ok							// status da operação
integer vli_Retorno					// retorno de função

// carrega dado editado no buffer
vli_Retorno = dw_Departamento.acceptText()
if (vli_Retorno = -1) then
	return false
end if

// valida se os dados estao ok
vlb_Ok = event ue_ValidaDados (as_MensagemErro)
if (not vlb_Ok) then
	return vlb_Ok
end if

// atualiza os dados na tabela
vli_Retorno = dw_Departamento.update()

// verifica status da operação
vlb_Ok = (vli_Retorno = 1)

// confirma gravação
if (vlb_Ok) then
	// confirma gravação no banco de dados
	commit ;

	// verifica erro de operação do commit
	vlb_Ok = (sqlca.SqlCode = 0)
end if

// cancela operação e exibe mensagem de erro
if (not vlb_Ok) then
	as_MensagemErro = sqlca.sqlErrText

	// desfaz alterações do banco de dados
	rollback;
end if

return vlb_Ok

end event

event type long ue_recuperardados(ref string as_mensagemerro);boolean vlb_Ok									// status da operação
long vll_QtdLinhas							// quantidade de linahs recuperadas


// recupera as linhas gravadas
vll_QtdLinhas = dw_Departamento.retrieve (vgl_CodAluno)

// define status da operação
vlb_Ok = (vll_QtdLinhas >= 0)

// tratamento de erro
if (not vlb_Ok) then
	as_MensagemErro = sqlca.sqlErrText
end if


return vll_QtdLinhas
end event

event ue_inicializacao();boolean vlb_Ok								// status da operação
long vll_QtdLinhas						// quantidade de linhas recuperadas
string vls_MensagemErro					// mensagem de erro

// conecta a transação sqlca à datawindow
dw_Departamento.setTransObject (sqlca)

// chamada ao evento de recuperação de dados
vll_QtdLinhas = event ue_RecuperarDados (vls_MensagemErro)

// tratamento de acordo com o número de linhas retornadas
choose case vll_QtdLinhas
	case -1		// erro
		messageBox ('Erro', 'Erro ao recuperar departamentos' + '~r~n' + vls_MensagemErro, StopSign!)
		
	case 0		// nenhuma linha recuperada
		messageBox ('Departamentos', 'Não há departamentos cadastrados', Exclamation!)
		
	case else	// qualquer número de linhas
		messageBox ('Departamentos', 'Foram recuperados ' + string (vll_QtdLinhas) + ' registros')
end choose

return
end event

event type boolean ue_verificagravacaopendente();boolean vlb_GravacaoPendente					// indica se há pendência de gravação
integer vli_QtdLinhasModificadas				// número de linhas alteradas


// verifica número de linhas modificadas ou apagadas
vli_QtdLinhasModificadas = dw_Departamento.deletedCount() + dw_Departamento.modifiedCount( )


// se quantidade maior que zero significa que há linhas pendentes de gravação
vlb_GravacaoPendente = (vli_QtdLinhasModificadas > 0)

return vlb_GravacaoPendente

end event

event type boolean ue_validadados(ref string as_mensagemerro);// =========================================================================================================
// = Função: valida os campos da datawindow.
// =
// = Parâmetros:  1. mensagem de erro (retorno).
// = Retorno:		status da operação - se os dados estão ok
// ===================================================+======================================================

boolean vlb_Ok														// status da operação
integer i															// índice genérico
integer vli_CodDepartamento									// código do departamento
integer vli_NumLinhas											// número de linhas da datawindow
string vls_NomeDepartamento									// nome do departamento	

// inicialização
vlb_Ok = true
vli_NumLinhas = dw_Departamento.rowCount()


// validação de campos
for i = 1 to vli_NumLinhas
	// valida código
	vli_CodDepartamento = dw_Departamento.getItemNumber (i, 'cod_depto')
	if (isNull (vli_CodDepartamento)) then
		as_MensagemErro = 'Código não informado na linha ' + string (i)
		return false
	end if
	if (vli_CodDepartamento < 1) then
		as_MensagemErro = 'Código deve ser maior que 0 (zero) na linha ' + string (i)
		return false
	end if
	
	// valida descrição
	vls_NomeDepartamento = dw_Departamento.getItemString (i, 'nome_depto')
	if (isNull (vls_NomeDepartamento) or (trim (vls_NomeDepartamento) = '')) then
		as_MensagemErro = 'Nome não informado na linha ' + string (i)
		return false
	end if

	// verifica se código do carga está duplicado
	vlb_Ok = of_VerificaRegistroDuplicado (i, as_MensagemErro)
	if (not vlb_Ok) then
		return false
	end if
next

// finalização

return true

end event

public function boolean of_verificaregistroduplicado (integer ai_numlinha, ref string as_mensagemerro);// =========================================================================================================
// = Função: verificar se o código da linha informada já existe.
// =
// = Parâmetros:  1. número da linha em análise.
// =              2. menasgem erro (retorno).
// = Retorno:		indica se o código já foi utilizado.
// ===================================================+======================================================

boolean vlb_Ok														// status da operação
integer vli_NumLinhaDuplicada									// número da linha duplicada
integer vli_QtdLinhas											// quantidade de linhas da datawindow
long vll_CodDeptoLinha											// código do departamento da linha que está em análise
string vls_ExpressaoBusca										// expressão de busca


// inicialização
vlb_Ok = true
vll_CodDeptoLinha = dw_Departamento.getItemNumber (ai_NumLinha, 'cod_depto')
vli_QtdLinhas = dw_Departamento.rowCount()
vls_ExpressaoBusca = 'cod_depto = ' + string (vll_CodDeptoLinha)

// verifica se está tratando a última linha evitando que ela seja identificada como repetida - vide comando find
if (ai_NumLinha = vli_QtdLinhas) then
	return true
end if


// verifica se o código já existe a partir da linha informada
vli_NumLinhaDuplicada = dw_Departamento.find (vls_ExpressaoBusca, ai_NumLinha + 1, vli_QtdLinhas) 
vlb_Ok = (vli_NumLinhaDuplicada = 0)
if (not vlb_Ok) then
	as_MensagemErro = 'O código ' + string (vll_CodDeptoLinha) + ' está duplicado ~r~nnas linhas ' + &
							string (ai_NumLinha) + ' e ' + string (vli_NumLinhaDuplicada)
end if

// finalização

return vlb_Ok
end function

on w_manut_departamento_backup.create
this.cb_gravar=create cb_gravar
this.cb_excluir=create cb_excluir
this.cb_inserir=create cb_inserir
this.cb_adicionar=create cb_adicionar
this.dw_departamento=create dw_departamento
this.Control[]={this.cb_gravar,&
this.cb_excluir,&
this.cb_inserir,&
this.cb_adicionar,&
this.dw_departamento}
end on

on w_manut_departamento_backup.destroy
destroy(this.cb_gravar)
destroy(this.cb_excluir)
destroy(this.cb_inserir)
destroy(this.cb_adicionar)
destroy(this.dw_departamento)
end on

event open;// executa a inicialização enquanto a janela é aberta
post event ue_Inicializacao()

return

end event

event closequery;constant integer cli_CancelaFechamento = 1// indica que a janela não será fechada
constant integer cli_FechaJanela = 0		// indica que a janela será fechada
boolean vlb_GravacaoPendente					// indica se há pendência de gravação
boolean vlb_Ok										// status da operação
integer vli_Resposta								// resposta do usuário
integer vli_AcaoJanela							// ação a ser executada pela janela
string vls_MensagemErro							// mensagem de erro de gravação
									
// inicialização														
vli_AcaoJanela = cli_FechaJanela		// opção padrão = fechar janela

// verifica se há itens pendentes de gravação
vlb_GravacaoPendente = event ue_VerificaGravacaoPendente()

// questiona ação usuário
if (vlb_GravacaoPendente) then
	vli_Resposta = messageBox ('Gravação', 'Há dados pendentes de gravação.' + ' ~r~n' + &
										'Deseja gravá-los antes de fechar?', Question!, YesNoCancel!, 3)
	choose case vli_Resposta
		case 1	// grava os dados
			vlb_Ok = event ue_Gravardados (vls_MensagemErro)
			if (not vlb_Ok) then
				messageBox ('Gravação', 'Erro ao gravar dados. ' + vls_MensagemErro, StopSign!)
				vli_AcaoJanela = cli_CancelaFechamento
			else
				vli_AcaoJanela = cli_FechaJanela
			end if
			
		case 2	// sai sem salvar
				vli_AcaoJanela = cli_FechaJanela
				
		case 3	// usuário cancela operação de fechamento
				vli_AcaoJanela = cli_CancelaFechamento
	end choose
end if


return vli_AcaoJanela

end event

type cb_gravar from commandbutton within w_manut_departamento_backup
integer x = 2290
integer y = 500
integer width = 302
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Gravar"
end type

event clicked;boolean vlb_Ok							// status da operação
string vls_MensagemErro				// mensagem de erro

// chamada ao evento de gravação
vlb_Ok = event ue_GravarDados (vls_MensagemErro)

// exibe mensagem de erro, se houver
if (not vlb_Ok) then
	messageBox ('Gravação', 'Erro ao gravar departamentos' + '~r~n' + vls_MensagemErro, StopSign!)
end if

return

end event

type cb_excluir from commandbutton within w_manut_departamento_backup
integer x = 2290
integer y = 344
integer width = 302
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Excluir"
end type

event clicked;integer vli_NumLinha				// número da linha criada

// número da linha corrente
vli_NumLinha = dw_Departamento.getRow()

// apaga a linha na posição corrente da datawindow
dw_Departamento.deleteRow (vli_NumLinha)


return

end event

type cb_inserir from commandbutton within w_manut_departamento_backup
integer x = 2290
integer y = 188
integer width = 302
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Inserir"
end type

event clicked;integer vli_NumLinha				// número da linha corrente

// número da linha corrente
vli_NumLinha = dw_Departamento.getRow()

// chamada ao evento que realiza a operação de inserção
event ue_InserirLinha (vli_NumLinha)

return

end event

type cb_adicionar from commandbutton within w_manut_departamento_backup
integer x = 2290
integer y = 32
integer width = 302
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Adicionar"
end type

event clicked;// chamada ao evento que realiza a operação de adição
event ue_InserirLinha (0)

return

end event

type dw_departamento from datawindow within w_manut_departamento_backup
integer x = 27
integer y = 32
integer width = 2185
integer height = 908
integer taborder = 10
string title = "none"
string dataobject = "d_manut_departamento"
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

