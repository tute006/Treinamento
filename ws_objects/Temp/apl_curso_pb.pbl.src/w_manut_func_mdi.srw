$PBExportHeader$w_manut_func_mdi.srw
$PBExportComments$Manutenção de funcionários
forward
global type w_manut_func_mdi from w_manut_ancestral
end type
end forward

global type w_manut_func_mdi from w_manut_ancestral
end type
global w_manut_func_mdi w_manut_func_mdi

on w_manut_func_mdi.create
call super::create
end on

on w_manut_func_mdi.destroy
call super::destroy
end on

event u_validadados;call super::u_validadados;// =========================================================================================================
// = Função: valida os campos da datawindow.
// =
// = Parâmetros:  1. mensagem de erro (retorno).
// = Retorno:		status da operação - se os dados estão ok
// ===================================================+======================================================

boolean vlb_Ok														// status da operação
char vlc_Sexo														// sexo do funcionário
date vld_DataNasc													// data de nascimento
decimal{2} vldc_Salario											// salário
integer i, j														// índice genérico
integer vli_CodCargo												// código do cargo
integer vli_CodDepto												// código do departamento
integer vli_Matricula											// matrícula do funcionário
integer vli_NumLinhas											// número de linhas da datawindow
string vls_Nome													// nome do funcionário

// inicialização
vlb_Ok = true
vli_NumLinhas = dw_Manut.rowCount()


// validação de campos
for i = 1 to vli_NumLinhas
	// valida código
	vli_Matricula = dw_Manut.getItemNumber (i, 'matricula')
	if (isNull (vli_Matricula)) then
		as_MensagemErro = 'Matrícula não informada na linha ' + string (i)
		return false
	end if
	if (vli_Matricula < 1) then
		as_MensagemErro = 'Matrícula deve ser maior que 0 (zero) na linha ' + string (i)
		return false
	end if
	
	// valida nome
	vls_Nome = dw_Manut.getItemString (i, 'nome')
	if (isNull (vls_Nome) or (trim (vls_Nome) = '')) then
		as_MensagemErro = 'Nome não informado na linha ' + string (i)
		return false
	end if

	// valida sexo
	vlc_Sexo = dw_Manut.getItemString (i, 'sexo')
	if (isNull (vlc_Sexo) or (trim (vlc_Sexo) = '')) then
		as_MensagemErro = 'Sexo não informado na linha ' + string (i)
		return false
	end if

	// valida data de nascimento
	vld_DataNasc = dw_Manut.getItemDate (i, 'data_nasc')
	if (isNull (vld_DataNasc)) then
		as_MensagemErro = 'Data de nascimento não informada na linha ' + string (i)
		return false
	end if

	// valida cargo
	vli_CodCargo = dw_Manut.getItemNumber (i, 'cod_cargo')
	if (isNull (vli_CodCargo)) then
		as_MensagemErro = 'Cargo não informado na linha ' + string (i)
		return false
	end if
	
	// valida departamento
	vli_CodDepto = dw_Manut.getItemNumber (i, 'cod_depto')
	if (isNull (vli_CodDepto)) then
		as_MensagemErro = 'Departamento não informado na linha ' + string (i)
		return false
	end if


	// verifica se código do carga está duplicado
	vlb_Ok = of_VerificaRegistroDuplicado ('matricula', i, as_MensagemErro)
	if (not vlb_Ok) then
		return false
	end if

	// alternativo
	//	vlb_Ok = (not isNull (vli_Matricula))
	//	if (not vlb_Ok) then
	//		as_MensagemErro = 'Código não informado na linha ' + string (i)
	//		return false
	//	end if
next

// finalização

return true

end event

type cb_exportar from w_manut_ancestral`cb_exportar within w_manut_func_mdi
end type

type cb_inserir from w_manut_ancestral`cb_inserir within w_manut_func_mdi
end type

type cb_excluir from w_manut_ancestral`cb_excluir within w_manut_func_mdi
end type

type cb_adicionar from w_manut_ancestral`cb_adicionar within w_manut_func_mdi
end type

type cb_gravar from w_manut_ancestral`cb_gravar within w_manut_func_mdi
end type

type cb_recuperar from w_manut_ancestral`cb_recuperar within w_manut_func_mdi
end type

type dw_manut from w_manut_ancestral`dw_manut within w_manut_func_mdi
string dataobject = "dw_funcionario"
end type

