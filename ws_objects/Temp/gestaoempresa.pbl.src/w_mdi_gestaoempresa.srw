$PBExportHeader$w_mdi_gestaoempresa.srw
$PBExportComments$Janela principal
forward
global type w_mdi_gestaoempresa from window
end type
type mdi_1 from mdiclient within w_mdi_gestaoempresa
end type
end forward

global type w_mdi_gestaoempresa from window
integer width = 4754
integer height = 2056
boolean titlebar = true
string title = "Gestão de Empresa"
string menuname = "m_gestaoempresa_mdi"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = mdihelp!
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
mdi_1 mdi_1
end type
global w_mdi_gestaoempresa w_mdi_gestaoempresa

on w_mdi_gestaoempresa.create
if this.MenuName = "m_gestaoempresa_mdi" then this.MenuID = create m_gestaoempresa_mdi
this.mdi_1=create mdi_1
this.Control[]={this.mdi_1}
end on

on w_mdi_gestaoempresa.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
end on

type mdi_1 from mdiclient within w_mdi_gestaoempresa
long BackColor=268435456
end type

