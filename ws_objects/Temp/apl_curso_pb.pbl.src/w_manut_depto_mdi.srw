$PBExportHeader$w_manut_depto_mdi.srw
$PBExportComments$Manutenção de departamento.
forward
global type w_manut_depto_mdi from w_manut_ancestral
end type
end forward

global type w_manut_depto_mdi from w_manut_ancestral
end type
global w_manut_depto_mdi w_manut_depto_mdi

on w_manut_depto_mdi.create
call super::create
end on

on w_manut_depto_mdi.destroy
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
integer vli_CodDepto												// código do departamento
integer vli_NumLinhas											// número de linhas da datawindow
string vls_DescCargo												// descrição do cargo	

// inicialização
vlb_Ok = true
vli_NumLinhas = dw_Manut.rowCount()


// validação de campos
for i = 1 to vli_NumLinhas
	// valida código
	vli_CodDepto = dw_Manut.getItemNumber (i, 'cod_depto')
	if (isNull (vli_CodDepto)) then
		as_MensagemErro = 'Código não informado na linha ' + string (i)
		return false
	end if
	if (vli_CodDepto < 1) then
		as_MensagemErro = 'Código deve ser maior que 0 (zero) na linha ' + string (i)
		return false
	end if
	
	// valida descrição
	vls_DescCargo = dw_Manut.getItemString (i, 'desc_depto')
	if (isNull (vls_DescCargo) or (trim (vls_DescCargo) = '')) then
		as_MensagemErro = 'Descrição não informada na linha ' + string (i)
		return false
	end if


	// verifica se código do carga está duplicado
	vlb_Ok = of_VerificaRegistroDuplicado ('cod_depto', i, as_MensagemErro)
	if (not vlb_Ok) then
		return false
	end if

	// alternativo
	//	vlb_Ok = (not isNull (vli_CodDepto))
	//	if (not vlb_Ok) then
	//		as_MensagemErro = 'Código não informado na linha ' + string (i)
	//		return false
	//	end if
next

// finalização

return true

end event

type cb_exportar from w_manut_ancestral`cb_exportar within w_manut_depto_mdi
end type

type cb_inserir from w_manut_ancestral`cb_inserir within w_manut_depto_mdi
end type

type cb_excluir from w_manut_ancestral`cb_excluir within w_manut_depto_mdi
end type

type cb_adicionar from w_manut_ancestral`cb_adicionar within w_manut_depto_mdi
end type

type cb_gravar from w_manut_ancestral`cb_gravar within w_manut_depto_mdi
end type

type cb_recuperar from w_manut_ancestral`cb_recuperar within w_manut_depto_mdi
end type

type dw_manut from w_manut_ancestral`dw_manut within w_manut_depto_mdi
string dataobject = "dw_departamento"
end type

