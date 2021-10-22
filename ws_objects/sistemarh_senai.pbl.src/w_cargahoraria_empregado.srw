$PBExportHeader$w_cargahoraria_empregado.srw
forward
global type w_cargahoraria_empregado from w_manutencao
end type
end forward

global type w_cargahoraria_empregado from w_manutencao
string menuname = "m_manutencao_sistemarh"
end type
global w_cargahoraria_empregado w_cargahoraria_empregado

on w_cargahoraria_empregado.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_manutencao_sistemarh" then this.MenuID = create m_manutencao_sistemarh
end on

on w_cargahoraria_empregado.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_recuperar;call super::ue_recuperar;dw_Manutencao.retrieve()
end event

type dw_manutencao from w_manutencao`dw_manutencao within w_cargahoraria_empregado
string dataobject = "d_manut_cargahoraria_mes_empregado"
end type

