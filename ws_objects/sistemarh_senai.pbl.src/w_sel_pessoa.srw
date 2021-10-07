$PBExportHeader$w_sel_pessoa.srw
$PBExportComments$Seleção de pessoa
forward
global type w_sel_pessoa from w_sel_geral
end type
end forward

global type w_sel_pessoa from w_sel_geral
end type
global w_sel_pessoa w_sel_pessoa

on w_sel_pessoa.create
call super::create
end on

on w_sel_pessoa.destroy
call super::destroy
end on

event ue_selecao_linha;call super::ue_selecao_linha;//desmarca todas as linhas
d_selecao.selectRow( 0, false)
//marca a linha selecionada 
d_selecao.selectRow( al_num_linha, true)
istr_Parametros_Retorno.long_arg[1] = d_selecao.getItemNumber( al_Num_Linha, 'codigo')
end event

type cb_cancela from w_sel_geral`cb_cancela within w_sel_pessoa
end type

type cb_ok from w_sel_geral`cb_ok within w_sel_pessoa
end type

type d_selecao from w_sel_geral`d_selecao within w_sel_pessoa
string dataobject = "d_sel_pessoa"
end type

