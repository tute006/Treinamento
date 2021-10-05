$PBExportHeader$w_manut_empregado_unico.srw
forward
global type w_manut_empregado_unico from window
end type
type tab_empregado from tab within w_manut_empregado_unico
end type
type tabpage_dadospessoais from userobject within tab_empregado
end type
type dw_dadospessoais from datawindow within tabpage_dadospessoais
end type
type tabpage_dadospessoais from userobject within tab_empregado
dw_dadospessoais dw_dadospessoais
end type
type tabpage_endereco from userobject within tab_empregado
end type
type dw_endereco from datawindow within tabpage_endereco
end type
type tabpage_endereco from userobject within tab_empregado
dw_endereco dw_endereco
end type
type tab_empregado from tab within w_manut_empregado_unico
tabpage_dadospessoais tabpage_dadospessoais
tabpage_endereco tabpage_endereco
end type
end forward

global type w_manut_empregado_unico from window
integer width = 4754
integer height = 2056
boolean titlebar = true
string title = "Untitled"
string menuname = "m_gestaoempresa_cadastro"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
tab_empregado tab_empregado
end type
global w_manut_empregado_unico w_manut_empregado_unico

on w_manut_empregado_unico.create
if this.MenuName = "m_gestaoempresa_cadastro" then this.MenuID = create m_gestaoempresa_cadastro
this.tab_empregado=create tab_empregado
this.Control[]={this.tab_empregado}
end on

on w_manut_empregado_unico.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tab_empregado)
end on

type tab_empregado from tab within w_manut_empregado_unico
integer x = 82
integer y = 64
integer width = 2304
integer height = 1056
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 67108864
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_dadospessoais tabpage_dadospessoais
tabpage_endereco tabpage_endereco
end type

on tab_empregado.create
this.tabpage_dadospessoais=create tabpage_dadospessoais
this.tabpage_endereco=create tabpage_endereco
this.Control[]={this.tabpage_dadospessoais,&
this.tabpage_endereco}
end on

on tab_empregado.destroy
destroy(this.tabpage_dadospessoais)
destroy(this.tabpage_endereco)
end on

type tabpage_dadospessoais from userobject within tab_empregado
integer x = 18
integer y = 116
integer width = 2267
integer height = 924
long backcolor = 67108864
string text = "Dados Pessoais"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_dadospessoais dw_dadospessoais
end type

on tabpage_dadospessoais.create
this.dw_dadospessoais=create dw_dadospessoais
this.Control[]={this.dw_dadospessoais}
end on

on tabpage_dadospessoais.destroy
destroy(this.dw_dadospessoais)
end on

type dw_dadospessoais from datawindow within tabpage_dadospessoais
integer x = 64
integer y = 44
integer width = 2171
integer height = 832
integer taborder = 10
string title = "none"
string dataobject = "dw_manut_empregado_dadospessoais"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type tabpage_endereco from userobject within tab_empregado
integer x = 18
integer y = 116
integer width = 2267
integer height = 924
long backcolor = 67108864
string text = "Endereço"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_endereco dw_endereco
end type

on tabpage_endereco.create
this.dw_endereco=create dw_endereco
this.Control[]={this.dw_endereco}
end on

on tabpage_endereco.destroy
destroy(this.dw_endereco)
end on

type dw_endereco from datawindow within tabpage_endereco
integer x = 64
integer y = 44
integer width = 2171
integer height = 832
integer taborder = 20
string title = "none"
string dataobject = "dw_manut_empregado_endereco"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

