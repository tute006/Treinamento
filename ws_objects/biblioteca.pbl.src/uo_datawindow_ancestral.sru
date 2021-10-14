$PBExportHeader$uo_datawindow_ancestral.sru
$PBExportComments$Estender as funcionalidades de datawindow
forward
global type uo_datawindow_ancestral from datawindow
end type
end forward

global type uo_datawindow_ancestral from datawindow
integer width = 686
integer height = 400
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
event ue_exportardados ( )
end type
global uo_datawindow_ancestral uo_datawindow_ancestral

type variables
protected:
boolean ib_AjustarLarguraDw = false
boolean ib_AjustarAlturaDw = false
boolean ib_GerarAuditoria = false
end variables

event ue_exportardados();return

end event

on uo_datawindow_ancestral.create
end on

on uo_datawindow_ancestral.destroy
end on

event sqlpreview;date ld_Hoje
time ldt_HoraAtual
datetime ldt_HojeAgora

// dia / hora atual
ld_Hoje = today()
ldt_HoraAtual = now()


// busca a hora da máquina
ldt_HojeAgora = datetime (ld_Hoje, ldt_HoraAtual)


if (ib_GerarAuditoria) then
	// grava o comando no banco de dados
	// inserir nova linha
	// buscar informações do usuário (login / usuário do windows
	// buscar dia/hora
	// grava auditoria
end if


return
end event

