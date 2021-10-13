$PBExportHeader$w_lista_empregado_pessoas.srw
$PBExportComments$Lista de empregados e pessoas
forward
global type w_lista_empregado_pessoas from w_manutencao
end type
end forward

global type w_lista_empregado_pessoas from w_manutencao
string menuname = "m_manutencao_sistemarh"
boolean ib_ajustalargura = true
boolean ib_ajustaaltura = true
event ue_inicializacao2 ( )
end type
global w_lista_empregado_pessoas w_lista_empregado_pessoas

event ue_inicializacao2();long ll_MatriculaSelecionada

open (w_Sel_Pessoa)

// recupera retorno
ll_MatriculaSelecionada = message.Doubleparm


if (ll_MatriculaSelecionada = -1) then
	messageBox ('', 'Operação cancelada')
	return
end if


return

end event

on w_lista_empregado_pessoas.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_manutencao_sistemarh" then this.MenuID = create m_manutencao_sistemarh
end on

on w_lista_empregado_pessoas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_recuperar;call super::ue_recuperar;long ll_QtdLinha							// quantidade de linhas recuperadas do banco de dados

// recupera os dados através do comando sql associado com a datawindow.
// este comando retorna o número de linha recuperadas. Caso ocorra algum erro, esse comando retornará -1.
ll_QtdLinha = dw_Manutencao.retrieve(40)

// verifica se houve erro
if (ll_QtdLinha < 0) then
	messageBox ('', 'Houve erro na recuperação de dados', StopSign!)
	return
end if

return

end event

event ue_inicializacao;call super::ue_inicializacao;long ll_MatriculaSelecionada
str_EmpregadoSelecionado lstr_EmpregadoSelecionado

open (w_Sel_Pessoa)

// recupera retorno
lstr_EmpregadoSelecionado = message.powerObjectParm

//ll_MatriculaSelecionada = message.doubleParm
if (lstr_EmpregadoSelecionado.usuarioCancelou) then
	messageBox ('', 'Operação cancelada')
	return
end if


return

end event

type dw_manutencao from w_manutencao`dw_manutencao within w_lista_empregado_pessoas
string dataobject = "d_lista_empregado_pessoas"
end type

