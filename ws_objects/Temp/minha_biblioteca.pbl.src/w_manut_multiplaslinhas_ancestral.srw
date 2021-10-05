$PBExportHeader$w_manut_multiplaslinhas_ancestral.srw
$PBExportComments$Tela ancestral de manutenção de cadastro de múltiplas linhas
forward
global type w_manut_multiplaslinhas_ancestral from window
end type
type dw_manut from datawindow within w_manut_multiplaslinhas_ancestral
end type
end forward

global type w_manut_multiplaslinhas_ancestral from window
integer width = 2711
integer height = 1076
boolean titlebar = true
string title = "Manutenção Departamento"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
event type boolean ue_excluirlinha ( )
event type boolean ue_gravardados ( )
event type long ue_recuperardados ( )
event ue_inicializacao ( )
event type boolean ue_verificagravacaopendente ( )
event type boolean ue_validadados ( ref string as_mensagemerro )
event ue_inserirlinha ( )
event ue_adicionarlinha ( )
event type boolean ue_pregravacao ( ref string as_mensagemerro )
event type boolean ue_posgravacao ( ref string as_mensagemerro )
dw_manut dw_manut
end type
global w_manut_multiplaslinhas_ancestral w_manut_multiplaslinhas_ancestral

type variables
protected:
boolean vib_DWRedimensionaHorizontalmente		// redimensiona dw na horizontal
boolean vib_DWRedimensionaVerticalmente		// redimensiona dw na vertical

end variables

forward prototypes
public function boolean of_verificaregistroduplicado (integer ai_numlinha, string as_nomecolunacodigo, ref string as_mensagemerro)
end prototypes

event type boolean ue_excluirlinha();// exclusão da linha corrente
// deve retornar true/false para o processo de exclusão

return true


end event

event type boolean ue_gravardados();boolean vlb_Ok							// status da operação
integer vli_Retorno					// retorno de função
string vls_MensagemErro				// mensagem de erro

// carrega dado editado no buffer
vli_Retorno = dw_Manut.acceptText()
if (vli_Retorno = -1) then
	return false
end if

// valida se os dados estão ok
vlb_Ok = event ue_ValidaDados (vls_MensagemErro)
if (not vlb_Ok) then
	messageBox ('Erro', vls_MensagemErro, Exclamation!)
	return vlb_Ok
end if

// pré-gravação
vlb_Ok = event ue_PreGravacao (vls_MensagemErro)
if (not vlb_Ok) then
	messageBox ('Erro', vls_MensagemErro, Exclamation!)
	return vlb_Ok
end if

// atualiza os dados na tabela
vli_Retorno = dw_Manut.update()

// pós-gravação
vlb_Ok = event ue_PosGravacao (vls_MensagemErro)
if (not vlb_Ok) then
	messageBox ('Erro', vls_MensagemErro, Exclamation!)
	return vlb_Ok
end if

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
	vls_MensagemErro = sqlca.sqlErrText

	// desfaz alterações do banco de dados
	rollback;
end if

// exibe mensagem de erro
if (not vlb_Ok) then
	messageBox ('Erro', vls_MensagemErro, Exclamation!)
	return vlb_Ok
end if


return vlb_Ok

end event

event ue_inicializacao();
// conecta a transação sqlca à datawindow
dw_Manut.setTransObject (sqlca)


return


end event

event type boolean ue_verificagravacaopendente();boolean vlb_GravacaoPendente					// indica se há pendência de gravação
integer vli_QtdLinhasModificadas				// número de linhas alteradas

// verifica número de linhas modificadas ou apagadas
vli_QtdLinhasModificadas = dw_Manut.deletedCount() + dw_Manut.modifiedCount()

// se quantidade maior que zero significa que há linhas pendentes de gravação
vlb_GravacaoPendente = (vli_QtdLinhasModificadas > 0)

return vlb_GravacaoPendente

end event

event ue_inserirlinha();integer vli_NumLinha							// número da linha corrente
integer vli_NumLinhaInserida				// número da linha inserida

// número da linha corrente
vli_NumLinha = dw_Manut.getRow()

// insere na posição da linha corrente da datawindow
vli_NumLinhaInserida = dw_Manut.insertRow(vli_NumLinha)

// atribui o código do aluno à nova linha
dw_Manut.setItem (vli_NumLinhaInserida, 'cod_aluno', vgl_CodAluno)

Return

end event

event ue_adicionarlinha();integer vli_NumLinhaInserida				// número da linha adicionada

// insere última linha da datawindow
vli_NumLinhaInserida = dw_Manut.insertRow(0)

// atribui o código do aluno à nova linha
dw_Manut.setItem (vli_NumLinhaInserida, 'cod_aluno', vgl_CodAluno)

Return

end event

public function boolean of_verificaregistroduplicado (integer ai_numlinha, string as_nomecolunacodigo, ref string as_mensagemerro);// =========================================================================================================
// = Função: verificar se o código da linha informada já existe.
// =
// = Parâmetros:  1. número da linha em análise.
// =              2. menasgem erro (retorno).
// = Retorno:		indica se o código já foi utilizado.
// ===================================================+======================================================

boolean vlb_Ok														// status da operação
integer vli_NumLinhaDuplicada									// número da linha duplicada
integer vli_QtdLinhas											// quantidade de linhas da datawindow
long vll_CodLinha													// código da linha que está em análise
string vls_ExpressaoBusca										// expressão de busca


// inicialização
vlb_Ok = true
vll_CodLinha = dw_Manut.getItemNumber (ai_NumLinha, as_NomeColunaCodigo)
vli_QtdLinhas = dw_Manut.rowCount()
vls_ExpressaoBusca = as_NomeColunaCodigo + '= ' + string (vll_CodLinha)

// verifica se está tratando a última linha evitando que ela seja identificada como repetida - vide comando find
if (ai_NumLinha = vli_QtdLinhas) then
	return true
end if


// verifica se o código já existe a partir da linha informada
vli_NumLinhaDuplicada = dw_Manut.find (vls_ExpressaoBusca, ai_NumLinha + 1, vli_QtdLinhas) 
vlb_Ok = (vli_NumLinhaDuplicada = 0)
if (not vlb_Ok) then
	as_MensagemErro = 'O código ' + string (vll_CodLinha) + ' está duplicado ~r~nnas linhas ' + &
							string (ai_NumLinha) + ' e ' + string (vli_NumLinhaDuplicada)
end if

// finalização

return vlb_Ok
end function

on w_manut_multiplaslinhas_ancestral.create
this.dw_manut=create dw_manut
this.Control[]={this.dw_manut}
end on

on w_manut_multiplaslinhas_ancestral.destroy
destroy(this.dw_manut)
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
			vlb_Ok = event ue_GravarDados()
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

event resize;long vll_DWPosX		// posição x da datawindow
long vll_DWPosY		// posição y da datawindow

// determina posição x e y da datawindow
vll_DWPosX = dw_Manut.X
vll_DWPosY = dw_Manut.Y

//verifica se redimensiona datawindow horizontalmente
if (vib_DWRedimensionaHorizontalmente) then
	// calcula nova largura mantendo margem direita e esquerda iguais
	dw_Manut.width = newWidth - (2 * vll_DWPosX)
end if

//verifica se redimensiona datawindow verticalmente
if (vib_DWRedimensionaVerticalmente) then
	// calcula nova altura mantendo margem superior e inferior iguais
	dw_Manut.height = newHeight - (2 * vll_DWPosX)
end if


return
end event

type dw_manut from datawindow within w_manut_multiplaslinhas_ancestral
integer x = 27
integer y = 32
integer width = 2615
integer height = 908
integer taborder = 10
string title = "none"
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

