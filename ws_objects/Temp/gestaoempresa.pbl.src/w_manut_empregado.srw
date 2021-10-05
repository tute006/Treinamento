$PBExportHeader$w_manut_empregado.srw
$PBExportComments$Tela de manutenção de empregados
forward
global type w_manut_empregado from w_manut_multiplaslinhas_ancestral
end type
type tab_empregado from tab within w_manut_empregado
end type
type tabpage_dadospessoais from userobject within tab_empregado
end type
type dw_dadospessoais from datawindow within tabpage_dadospessoais
end type
type tabpage_dadospessoais from userobject within tab_empregado
dw_dadospessoais dw_dadospessoais
end type
type tabpage_endereco from userobject within tab_empregado
end type
type dw_endereco from datawindow within tabpage_endereco
end type
type tabpage_endereco from userobject within tab_empregado
dw_endereco dw_endereco
end type
type tab_empregado from tab within w_manut_empregado
tabpage_dadospessoais tabpage_dadospessoais
tabpage_endereco tabpage_endereco
end type
end forward

global type w_manut_empregado from w_manut_multiplaslinhas_ancestral
integer width = 3195
integer height = 2380
string menuname = "m_gestaoempresa_cadastro"
event type long ue_selecao ( )
tab_empregado tab_empregado
end type
global w_manut_empregado w_manut_empregado

type variables
constant integer cii_Cancelado = -1		// cancelado
constant integer cii_NovoEmpregado = 0	// novo empregado
long vil_NumMatricula						// número de matrícula

end variables

event type long ue_selecao();long vll_NumMatricula				// número de matrícula
str_sel_empregado vlstr_Selecao	// retorno da seleção

// abre janela de seleção
open (w_sel_empregado)

// recupera seleção do usuário
vlstr_Selecao = message.powerObjectParm

// retorna informações conforme seleção
choose case true
	case vlstr_Selecao.novoEmpregado
		vll_NumMatricula = cii_NovoEmpregado
		
	case vlstr_Selecao.cancelado
		vll_NumMatricula = cii_Cancelado
		
	case else
		vll_NumMatricula = vlstr_Selecao.matricula
end choose
		

return vll_NumMatricula
end event

on w_manut_empregado.create
int iCurrent
call super::create
if this.MenuName = "m_gestaoempresa_cadastro" then this.MenuID = create m_gestaoempresa_cadastro
this.tab_empregado=create tab_empregado
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_empregado
end on

on w_manut_empregado.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tab_empregado)
end on

event ue_inicializacao;call super::ue_inicializacao;// compartilhando buffer entre datawindow
dw_Manut.shareData (tab_Empregado.tabpage_DadosPessoais.dw_DadosPessoais)
dw_Manut.shareData (tab_Empregado.tabpage_Endereco.dw_Endereco)


// chamada ao evento para inclusão de nova linha
event ue_AdicionarLinha()

// recupera dados - abre seleção
event ue_RecuperarDados()


return
end event

event ue_excluirlinha;call super::ue_excluirlinha;integer vli_NumLinha				// número da linha criada
integer vli_Resposta				// Resposta do usuário
long vll_NumMatricula			// número de matrícula

// número da linha corrente
vli_NumLinha = dw_Manut.getRow()

// testa se linha é válida
if (vli_NumLinha <= 0 ) then
	return false
end if

// verifica se a matrícula já existe
vll_NumMatricula = dw_Manut.getItemNumber (vli_NumLinha, 'cod_empregado')

// analise registro
if (vll_NumMatricula > 0) then
	// excluir registro já existente
	vli_Resposta = messageBox ('Exclusão', 'Confirma exclusão do empregado ' + string (vli_Resposta), Question!, YesNo!, 2)
	if (vli_Resposta = 2) then  // resposta não
		return false
	end if
	
	// apaga a linha na posição corrente da datawindow
	dw_Manut.deleteRow (vli_NumLinha)
	
	// grava alteração
	dw_Manut.update();
	
	// confirma gravação
	Commit;

end if

// limpa o buffer 
dw_Manut.reset()

// chamada ao evento para inclusão de nova linha
event ue_AdicionarLinha()


return true

end event

event ue_recuperardados;call super::ue_recuperardados;long vll_NumMatricula						// número de matrícula
long vll_QtdLinhas							// quantidade de linhas recuperadas
string vls_MensagemErro						// mensagem de erro


// verifca opção de seleção do usuário
vll_NumMatricula = event ue_Selecao()

// verifica opção do usuário
choose case vll_NumMatricula
	case cii_Cancelado		// usuário cancelou edição
		return 0
		
	case cii_NovoEmpregado		// usuário selecionou novo empregado
		event ue_Adicionarlinha()
		return 0
	
	case else	// usuário selecionou empregado para edição
		vil_NumMatricula = vll_NumMatricula
end choose		



// recupera as linhas gravadas
vll_QtdLinhas = dw_Manut.retrieve (vgl_CodAluno, vil_NumMatricula)


// tratamento de acordo com o número de linhas retornadas
choose case vll_QtdLinhas
	case -1		// erro
		vls_MensagemErro = sqlca.sqlErrText
		messageBox ('Erro', 'Erro ao recuperar empregado' + '~r~n' + vls_MensagemErro, StopSign!)
		
	case 0		// nenhuma linha recuperada
		messageBox ('Empregado', 'Não há emmpregado com a matrícula' + string (vil_NumMatricula), Exclamation!)
		
	case else	// qualquer número de linhas
end choose


return vll_QtdLinhas
end event

event ue_validadados;call super::ue_validadados;// =========================================================================================================
// = Função: valida os campos da datawindow.
// =
// = Parâmetros:  1. mensagem de erro (retorno).
// = Retorno:		status da operação - se os dados estão ok
// ===================================================+======================================================

boolean vlb_Ok														// status da operação
decimal vldc_FatorSalarial										// fator salarial
string vls_NomeEmpregado										// nome do empregado

// inicialização
vlb_Ok = true

// validação de campos

// valida nome do empregado
vls_NomeEmpregado = dw_Manut.getItemString (1, 'nome_empregado')
if (isNull (vls_NomeEmpregado) or (trim (vls_NomeEmpregado) = '')) then
	as_MensagemErro = 'Nome do empregado não foi informado'
	return false
end if

// valida fator salarial
vldc_FatorSalarial = dw_Manut.getItemDecimal (1, 'fator_salario_empregado')
if (isNull (vldc_FatorSalarial) or (vldc_FatorSalarial <= 0)) then
	as_MensagemErro = 'Fator salarial deve ser maior que zero'
	return false
end if


// verifica se o registro é novo
if (vil_NumMatricula = 0) then
	// gera novo código de matrícula
end if

// finalização

return vlb_Ok
end event

event ue_adicionarlinha;// Este evento deve estar em override
// significa que o evento ancestral não será executado
// para colocar um evento em override clique com o botão direito do mouse no evento e
// desmarque a opção Extend Ancestor Script 

// indica que empregado é novo
vil_NumMatricula = 0

// apaga dados da datawindow para que a datawindow somente tenha uma linha
dw_Manut.reset()


// chama ancestral para inclusão de linha
super::event ue_AdicionarLinha()

return
end event

event ue_pregravacao;call super::ue_pregravacao;long vll_NovoNumMatricula			// número de matrícula
ou_empregado vluo_Empregado		// classe de empregado

// verifica se matrícula já existe (caso de edição - não necessita gerar um próximo)
if (vil_NumMatricula > 0) then
	return true
end if

// inicializa user object antes do uso
vluo_Empregado = create ou_empregado

// gera sequencial
vll_NovoNumMatricula = vluo_Empregado.of_GeraSequencial (as_MensagemErro)

// verifica erro - vide retorno função
if (vll_NovoNumMatricula = 0) then
	return false
end if


// seta nova matrícula
dw_Manut.setItem (1, 'cod_empregado', vll_NovoNumMatricula)


return true
end event

type dw_manut from w_manut_multiplaslinhas_ancestral`dw_manut within w_manut_empregado
string dataobject = "dw_manut_empregado"
end type

type tab_empregado from tab within w_manut_empregado
integer x = 82
integer y = 1000
integer width = 2304
integer height = 944
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 67108864
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_dadospessoais tabpage_dadospessoais
tabpage_endereco tabpage_endereco
end type

on tab_empregado.create
this.tabpage_dadospessoais=create tabpage_dadospessoais
this.tabpage_endereco=create tabpage_endereco
this.Control[]={this.tabpage_dadospessoais,&
this.tabpage_endereco}
end on

on tab_empregado.destroy
destroy(this.tabpage_dadospessoais)
destroy(this.tabpage_endereco)
end on

type tabpage_dadospessoais from userobject within tab_empregado
integer x = 18
integer y = 116
integer width = 2267
integer height = 812
long backcolor = 67108864
string text = "Dados Pessoais"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_dadospessoais dw_dadospessoais
end type

on tabpage_dadospessoais.create
this.dw_dadospessoais=create dw_dadospessoais
this.Control[]={this.dw_dadospessoais}
end on

on tabpage_dadospessoais.destroy
destroy(this.dw_dadospessoais)
end on

type dw_dadospessoais from datawindow within tabpage_dadospessoais
integer x = 18
integer y = 24
integer width = 2231
integer height = 768
integer taborder = 20
string title = "none"
string dataobject = "dw_manut_empregado_dadospessoais"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type tabpage_endereco from userobject within tab_empregado
integer x = 18
integer y = 116
integer width = 2267
integer height = 812
long backcolor = 67108864
string text = "Endereço"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_endereco dw_endereco
end type

on tabpage_endereco.create
this.dw_endereco=create dw_endereco
this.Control[]={this.dw_endereco}
end on

on tabpage_endereco.destroy
destroy(this.dw_endereco)
end on

type dw_endereco from datawindow within tabpage_endereco
integer x = 18
integer y = 24
integer width = 2231
integer height = 768
integer taborder = 10
string title = "none"
string dataobject = "dw_manut_empregado_endereco"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

