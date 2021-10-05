$PBExportHeader$w_mdi_principal.srw
$PBExportComments$Janela principal do sistema.
forward
global type w_mdi_principal from w_mdi_ancestral
end type
end forward

global type w_mdi_principal from w_mdi_ancestral
string title = "Sistema de RH"
string menuname = "m_principal_sistemarh"
end type
global w_mdi_principal w_mdi_principal

on w_mdi_principal.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_principal_sistemarh" then this.MenuID = create m_principal_sistemarh
end on

on w_mdi_principal.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

