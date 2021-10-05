$PBExportHeader$w_filho_1.srw
$PBExportComments$Primeira herança.
forward
global type w_filho_1 from w_pai
end type
type st_1 from statictext within w_filho_1
end type
end forward

global type w_filho_1 from w_pai
string title = "Filho 1"
st_1 st_1
end type
global w_filho_1 w_filho_1

on w_filho_1.create
int iCurrent
call super::create
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
end on

on w_filho_1.destroy
call super::destroy
destroy(this.st_1)
end on

type r_1 from w_pai`r_1 within w_filho_1
end type

type r_2 from w_pai`r_2 within w_filho_1
end type

type r_3 from w_pai`r_3 within w_filho_1
long fillcolor = 16711935
integer width = 311
integer height = 272
end type

type rr_1 from w_pai`rr_1 within w_filho_1
end type

type st_1 from statictext within w_filho_1
integer x = 1408
integer y = 456
integer width = 402
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

