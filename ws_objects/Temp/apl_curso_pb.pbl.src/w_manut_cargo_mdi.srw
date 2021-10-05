$PBExportHeader$w_manut_cargo_mdi.srw
$PBExportComments$Manutenção de cargo
forward
global type w_manut_cargo_mdi from w_manut_ancestral
end type
end forward

global type w_manut_cargo_mdi from w_manut_ancestral
end type
global w_manut_cargo_mdi w_manut_cargo_mdi

on w_manut_cargo_mdi.create
call super::create
end on

on w_manut_cargo_mdi.destroy
call super::destroy
end on

event u_validadados;call super::u_validadados;// =========================================================================================================
// = Função: valida os campos da datawindow.
// =
// = Parâmetros:  1. mensagem de erro (retorno).
// = Retorno:		status da operação - se os dados estão ok
// ===================================================+======================================================

boolean vlb_Ok														// status da operação
decimal{2} vldc_Salario											// salário
integer i, j														// índice genérico
integer vli_CodCargo												// código do cargo
integer vli_NumLinhas											// número de linhas da datawindow
string vls_DescCargo												// descrição do cargo	

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
	vls_DescCargo = dw_Manut.getItemString (i, 'desc_cargo')
	if (isNull (vls_DescCargo) or (trim (vls_DescCargo) = '')) then
		as_MensagemErro = 'Descrição não informada na linha ' + string (i)
		return false
	end if

	// valida salário
	vldc_Salario = dw_Manut.getItemNumber (i, 'salario')
	if (isNull (vldc_Salario)) then
		as_MensagemErro = 'Salário não informado na linha ' + string (i)
		return false
	end if
	if (vldc_Salario < 0) then
		as_MensagemErro = 'Salário não pdoe ser negativo na linha ' + string (i)
		return false
	end if

	// verifica se código do carga está duplicado
	vlb_Ok = of_VerificaRegistroDuplicado ('cod_cargo', i, as_MensagemErro)
	if (not vlb_Ok) then
		return false
	end if

	// alternativo
	//	vlb_Ok = (not isNull (vli_CodCargo))
	//	if (not vlb_Ok) then
	//		as_MensagemErro = 'Código não informado na linha ' + string (i)
	//		return false
	//	end if
next

// finalização

return true

end event

type cb_exportar from w_manut_ancestral`cb_exportar within w_manut_cargo_mdi
end type

type cb_inserir from w_manut_ancestral`cb_inserir within w_manut_cargo_mdi
end type

type cb_excluir from w_manut_ancestral`cb_excluir within w_manut_cargo_mdi
end type

type cb_adicionar from w_manut_ancestral`cb_adicionar within w_manut_cargo_mdi
end type

type cb_gravar from w_manut_ancestral`cb_gravar within w_manut_cargo_mdi
end type

type cb_recuperar from w_manut_ancestral`cb_recuperar within w_manut_cargo_mdi
end type

type dw_manut from w_manut_ancestral`dw_manut within w_manut_cargo_mdi
string dataobject = "dw_cargo"
end type

