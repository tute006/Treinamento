$PBExportHeader$w_manut_pessoa.srw
$PBExportComments$Tela de manutenção pessoas
forward
global type w_manut_pessoa from w_manutencao
end type
end forward

global type w_manut_pessoa from w_manutencao
string title = "Manutenção de Pessoas"
string menuname = "m_manutencao_sistemarh"
end type
global w_manut_pessoa w_manut_pessoa

type variables
long il_MatriculaSelecionada
end variables

on w_manut_pessoa.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_manutencao_sistemarh" then this.MenuID = create m_manutencao_sistemarh
end on

on w_manut_pessoa.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_inicializacao;call super::ue_inicializacao;str_parametros lstr_Parametros_Retorno

dw_manutencao.insertRow(0)
open (w_Sel_Pessoa)


// recupera retorno
lstr_Parametros_Retorno = message.powerObjectParm

if lstr_Parametros_Retorno.cancelado then
	return
end if

il_MatriculaSelecionada = lstr_Parametros_Retorno.long_arg[1]

event ue_Recuperar()
return

end event

event ue_recuperar;call super::ue_recuperar;
dw_manutencao.retrieve(il_MatriculaSelecionada)

return
end event

type dw_manutencao from w_manutencao`dw_manutencao within w_manut_pessoa
integer x = 27
integer width = 3131
integer height = 1380
string dataobject = "d_manut_pessoa"
end type

