$PBExportHeader$w_pai.srw
$PBExportComments$Janela pai
forward
global type w_pai from window
end type
type r_1 from rectangle within w_pai
end type
type r_2 from rectangle within w_pai
end type
type r_3 from rectangle within w_pai
end type
type rr_1 from roundrectangle within w_pai
end type
end forward

global type w_pai from window
integer width = 3803
integer height = 1584
boolean titlebar = true
string title = "Pai José"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
r_1 r_1
r_2 r_2
r_3 r_3
rr_1 rr_1
end type
global w_pai w_pai

on w_pai.create
this.r_1=create r_1
this.r_2=create r_2
this.r_3=create r_3
this.rr_1=create rr_1
this.Control[]={this.r_1,&
this.r_2,&
this.r_3,&
this.rr_1}
end on

on w_pai.destroy
destroy(this.r_1)
destroy(this.r_2)
destroy(this.r_3)
destroy(this.rr_1)
end on

event open;
MessageBox ('', 'Pai')
end event

type r_1 from rectangle within w_pai
long linecolor = 33554432
integer linethickness = 4
long fillcolor = 15780518
integer x = 375
integer y = 92
integer width = 329
integer height = 176
end type

type r_2 from rectangle within w_pai
long linecolor = 33554432
integer linethickness = 4
long fillcolor = 128
integer x = 1083
integer y = 116
integer width = 329
integer height = 176
end type

type r_3 from rectangle within w_pai
long linecolor = 33554432
integer linethickness = 4
long fillcolor = 65280
integer x = 658
integer y = 644
integer width = 82
integer height = 64
end type

type rr_1 from roundrectangle within w_pai
long linecolor = 33554432
integer linethickness = 4
long fillcolor = 32896
integer x = 1632
integer y = 228
integer width = 329
integer height = 176
integer cornerheight = 40
integer cornerwidth = 46
end type

