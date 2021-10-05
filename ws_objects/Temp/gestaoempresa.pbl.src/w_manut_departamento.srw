$PBExportHeader$w_manut_departamento.srw
$PBExportComments$Tela de manutenção de departamentos
forward
global type w_manut_departamento from w_manut_multiplaslinhas_ancestral
end type
end forward

global type w_manut_departamento from w_manut_multiplaslinhas_ancestral
integer height = 1152
string menuname = "m_gestaoempresa_cadastro"
boolean vib_dwredimensionahorizontalmente = true
boolean vib_dwredimensionaverticalmente = true
end type
global w_manut_departamento w_manut_departamento

type variables

end variables
on w_manut_departamento.create
call super::create
if this.MenuName = "m_gestaoempresa_cadastro" then this.MenuID = create m_gestaoempresa_cadastro
end on

on w_manut_departamento.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_inicializacao;call super::ue_inicializacao;long vll_QtdLinhas						// quantidade de linhas recuperadas

// chamada ao evento de recuperação de dados
vll_QtdLinhas = event ue_RecuperarDados()

// tratamento de acordo com o número de linhas retornadas
choose case vll_QtdLinhas
	case -1		// erro
		Close (this)
		
	case 0		// nenhuma linha recuperada
	case else	// qualquer número de linhas
end choose

return
end event

event ue_recuperardados;call super::ue_recuperardados;long vll_QtdLinhas							// quantidade de linhas recuperadas
string vls_MensagemErro						// mensagem de erro

// recupera as linhas gravadas
vll_QtdLinhas = dw_Manut.retrieve (vgl_CodAluno)


// tratamento de acordo com o número de linhas retornadas
choose case vll_QtdLinhas
	case -1		// erro
		messageBox ('Erro', 'Erro ao recuperar departamentos' + '~r~n' + vls_MensagemErro, StopSign!)
		
	case 0		// nenhuma linha recuperada
		messageBox ('Departamentos', 'Não há departamentos cadastrados', Exclamation!)
		
	case else	// qualquer número de linhas
		messageBox ('Departamentos', 'Foram recuperados ' + string (vll_QtdLinhas) + ' registros')
end choose


return vll_QtdLinhas
end event

event ue_excluirlinha;call super::ue_excluirlinha;integer vli_NumLinha				// número da linha criada

// número da linha corrente
vli_NumLinha = dw_Manut.getRow()

// testa se linha é válida
if (vli_NumLinha <= 0 ) then
	return false
end if

// apaga a linha na posição corrente da datawindow
dw_Manut.deleteRow (vli_NumLinha)

return true

end event

event ue_validadados;call super::ue_validadados;// =========================================================================================================
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
vli_NumLinhas = dw_Manut.rowCount()


// validação de campos
for i = 1 to vli_NumLinhas
	// valida código
	vli_CodDepartamento = dw_Manut.getItemNumber (i, 'cod_depto')
	if (isNull (vli_CodDepartamento)) then
		as_MensagemErro = 'Código não informado na linha ' + string (i)
		return false
	end if
	if (vli_CodDepartamento < 1) then
		as_MensagemErro = 'Código deve ser maior que 0 (zero) na linha ' + string (i)
		return false
	end if
	
	// valida descrição
	vls_NomeDepartamento = dw_Manut.getItemString (i, 'nome_depto')
	if (isNull (vls_NomeDepartamento) or (trim (vls_NomeDepartamento) = '')) then
		as_MensagemErro = 'Nome não informado na linha ' + string (i)
		return false
	end if

	// verifica se código do carga está duplicado
	vlb_Ok = of_VerificaRegistroDuplicado (i, 'cod_depto', as_MensagemErro)
	if (not vlb_Ok) then
		return false
	end if
next

// finalização

return true

end event

type dw_manut from w_manut_multiplaslinhas_ancestral`dw_manut within w_manut_departamento
string dataobject = "d_manut_departamento"
end type

