$PBExportHeader$w_cadastrodepartamento.srw
$PBExportComments$Janela de manutenção de departamentos
forward
global type w_cadastrodepartamento from w_manutencao
end type
end forward

global type w_cadastrodepartamento from w_manutencao
string menuname = "m_manutencao_sistemarh"
end type
global w_cadastrodepartamento w_cadastrodepartamento

on w_cadastrodepartamento.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_manutencao_sistemarh" then this.MenuID = create m_manutencao_sistemarh
end on

on w_cadastrodepartamento.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_recuperar;call super::ue_recuperar;long ll_QtdLinha							// quantidade de linhas recuperadas do banco de dados

// recupera os dados através do comando sql associado com a datawindow.
// este comando retorna o número de linha recuperadas. Caso ocorra algum erro, esse comando retornará -1.
ll_QtdLinha = dw_Manutencao.retrieve()

// verifica se houve erro
if (ll_QtdLinha < 0) then
	messageBox ('', 'Houve erro na recuperação de dados', StopSign!)
	return
end if

return

end event

event ue_validardados;call super::ue_validardados;integer li_LinhaAtual					// linha que está atualmente sendo analisada
integer li_QtdLinhas						// quantidade de linhas
string ls_NomeInformado					// nome do departamento informado

// número de linhas da datawindow
li_QtdLinhas = dw_Manutencao.rowCount()

// ler os dados linha a linha para validar se departamento não foi preenchido
for li_LinhaAtual = 1 to li_QtdLinhas
	ls_NomeInformado = dw_Manutencao.getItemString (li_LinhaAtual, 'nome_departamento') 
	// verificar se o nome foi informado
	if (ls_NomeInformado = '') or (IsNull (ls_NomeInformado)) then
		as_MensagemErro = 'Nome de departamento não informado na linha ' + string (li_LinhaAtual)
		return false
	end if
next


return true
end event

type dw_manutencao from w_manutencao`dw_manutencao within w_cadastrodepartamento
string dataobject = "d_lista_departamento"
end type

