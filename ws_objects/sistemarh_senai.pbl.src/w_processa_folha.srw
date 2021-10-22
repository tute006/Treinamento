$PBExportHeader$w_processa_folha.srw
forward
global type w_processa_folha from window
end type
type cb_processar from commandbutton within w_processa_folha
end type
type em_ano from editmask within w_processa_folha
end type
type em_mes from editmask within w_processa_folha
end type
type st_ano from statictext within w_processa_folha
end type
type st_mes from statictext within w_processa_folha
end type
end forward

global type w_processa_folha from window
integer width = 3365
integer height = 1408
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_processar cb_processar
em_ano em_ano
em_mes em_mes
st_ano st_ano
st_mes st_mes
end type
global w_processa_folha w_processa_folha

on w_processa_folha.create
this.cb_processar=create cb_processar
this.em_ano=create em_ano
this.em_mes=create em_mes
this.st_ano=create st_ano
this.st_mes=create st_mes
this.Control[]={this.cb_processar,&
this.em_ano,&
this.em_mes,&
this.st_ano,&
this.st_mes}
end on

on w_processa_folha.destroy
destroy(this.cb_processar)
destroy(this.em_ano)
destroy(this.em_mes)
destroy(this.st_ano)
destroy(this.st_mes)
end on

type cb_processar from commandbutton within w_processa_folha
integer x = 288
integer y = 532
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "processar"
end type

event clicked;boolean lb_ok
decimal ldc_ano
decimal ldc_mes
integer li_ano
integer li_mes
integer li_resposta
long ll_qto_pessoas_processadas
string ls_mensagem_erro
uo_folha_pagamento luo_folha_pgto 


 luo_folha_pgto = create uo_folha_pagamento
 
  em_mes.getdata( ldc_mes)
  em_ano.getdata( ldc_ano)
  li_mes = integer( ldc_mes)
  li_ano = integer( ldc_ano)
  
  if isnull (li_mes) or  isnull (li_ano) then 
	messagebox ('Atenção', 'Mes e Ano invalidos', exclamation!)
  	return 
end if 
 
 // verificar se mes e ano ja foi processado 
 ll_qto_pessoas_processadas = luo_folha_pgto.of_verifica_folha_processada( li_mes, li_ano, sqlca)
 
 choose case ll_qto_pessoas_processadas
	case -1
		messagebox ('Atenção', 'Erro ao verificar processamento', stopsign!)
		return
	case 0
	case else 
		li_resposta = messagebox ('Atenção', 'Ja tem registro processado para este mês quer continuar?', question!, YesNo!)
		if (li_resposta= 2 ) then 
			return
		end if 
end choose

lb_ok = luo_folha_pgto.of_calcula_folha_pagamento(  li_mes, li_ano, sqlca,ls_mensagem_erro)
 
 if not lb_ok  then 
	 rollback using sqlca;
	 
	 messagebox ('Atenção', ls_mensagem_erro, stopsign!)
	 
	 return 
end if 

commit ; 
return 
	 
end event

type em_ano from editmask within w_processa_folha
integer x = 722
integer y = 280
integer width = 402
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
string mask = "####"
end type

type em_mes from editmask within w_processa_folha
integer x = 718
integer y = 132
integer width = 402
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
string mask = "##"
double increment = 1
string minmax = "1~~12"
end type

type st_ano from statictext within w_processa_folha
integer x = 238
integer y = 300
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ano:"
boolean focusrectangle = false
end type

type st_mes from statictext within w_processa_folha
integer x = 238
integer y = 156
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Mês:"
boolean focusrectangle = false
end type

