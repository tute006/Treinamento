$PBExportHeader$w_manut_cargo.srw
$PBExportComments$Tela de manutenção de cargos
forward
global type w_manut_cargo from w_manut_multiplaslinhas_ancestral
end type
end forward

global type w_manut_cargo from w_manut_multiplaslinhas_ancestral
integer height = 1152
string title = "Cadastro de Cargo"
string menuname = "m_gestaoempresa_cadastro"
end type
global w_manut_cargo w_manut_cargo

event ue_inicializacao;call super::ue_inicializacao;long vll_QtdLinhas			// quantidade de linhas recuperadas

// chamada ao evento de recuperação de dados
vll_QtdLinhas = event ue_RecuperarDados()

// tratamento de acordo com o número de linhas retornadas
choose case vll_QtdLinhas
    case -1		// erro
        Close (this)
		
    case 0	// nenhuma linha recuperada
    case else	// qualquer número de linhas
end choose


return

end event

on w_manut_cargo.create
call super::create
if this.MenuName = "m_gestaoempresa_cadastro" then this.MenuID = create m_gestaoempresa_cadastro
end on

on w_manut_cargo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_recuperardados;call super::ue_recuperardados;long vll_QtdLinhas							// quantidade de linhas recuperadas
string vls_MensagemErro						// mensagem de erro

integer ll
ll = dw_Manut.setTransObject (SQLCA)

// recupera as linhas gravadas
vll_QtdLinhas = dw_Manut.retrieve (vgl_CodAluno)


// tratamento de acordo com o número de linhas retornadas
choose case vll_QtdLinhas
	case -1		// erro
		messageBox ('Erro', 'Erro ao recuperar cargos' + '~r~n' + vls_MensagemErro, StopSign!)
		
	case 0		// nenhuma linha recuperada
		messageBox ('Cargos', 'Não há cargos cadastrados', Exclamation!)
		
	case else	// qualquer número de linhas
		messageBox ('Cargos', 'Foram recuperados ' + string (vll_QtdLinhas) + ' registros')
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
decimal{2} vldc_Salario											// salário
integer i															// índice genérico
integer vli_CodCargo												// código do cargo
integer vli_NumLinhas											// número de linhas da datawindow
string vls_NomeCargo												// nome do cargo

// inicialização
vlb_Ok = true
vli_NumLinhas = dw_Manut.rowCount()


// validação de campos
for i = 1 to vli_NumLinhas
	// valida código
	vli_CodCargo = dw_Manut.getItemNumber (i, 'cod_cargo')
	if (isNull (vli_CodCargo)) then
		as_MensagemErro = 'Código não informado na linha ' + string (i)
		return false
	end if
	if (vli_CodCargo < 1) then
		as_MensagemErro = 'Código deve ser maior que 0 (zero) na linha ' + string (i)
		return false
	end if
	
	// valida descrição
	vls_NomeCargo = dw_Manut.getItemString (i, 'nome_cargo')
	if (isNull (vls_NomeCargo) or (trim (vls_NomeCargo) = '')) then
		as_MensagemErro = 'Nome não informado na linha ' + string (i)
		return false
	end if

	// Salário
	vldc_Salario = dw_Manut.getItemDecimal (i, 'salario_cargo')
	if (isNull (vldc_Salario)) then	
		as_MensagemErro = 'Salário não informado na linha ' + string (i)
		return false
	end if

	// verifica se código do carga está duplicado
	vlb_Ok = of_VerificaRegistroDuplicado (i, 'cod_cargo', as_MensagemErro)
	if (not vlb_Ok) then
		return false
	end if
next

// finalização

return true

end event

type dw_manut from w_manut_multiplaslinhas_ancestral`dw_manut within w_manut_cargo
string dataobject = "d_manut_cargo"
end type

