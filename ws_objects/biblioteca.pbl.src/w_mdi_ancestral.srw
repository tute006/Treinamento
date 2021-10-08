$PBExportHeader$w_mdi_ancestral.srw
$PBExportComments$Janela MDI (Multiple Document Interface) ancestral.
forward
global type w_mdi_ancestral from window
end type
type mdi_1 from mdiclient within w_mdi_ancestral
end type
end forward

global type w_mdi_ancestral from window
integer width = 3803
integer height = 1660
boolean titlebar = true
string menuname = "m_ancestral"
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
global w_mdi_ancestral w_mdi_ancestral

on w_mdi_ancestral.create
if this.MenuName = "m_ancestral" then this.MenuID = create m_ancestral
this.mdi_1=create mdi_1
this.Control[]={this.mdi_1}
end on

on w_mdi_ancestral.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
end on

type mdi_1 from mdiclient within w_mdi_ancestral
long BackColor=268435456
end type

