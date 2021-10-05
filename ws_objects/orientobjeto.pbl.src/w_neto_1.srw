$PBExportHeader$w_neto_1.srw
$PBExportComments$Herança de nível 3.
forward
global type w_neto_1 from w_filho_1
end type
end forward

global type w_neto_1 from w_filho_1
end type
global w_neto_1 w_neto_1

on w_neto_1.create
call super::create
end on

on w_neto_1.destroy
call super::destroy
end on

type r_1 from w_filho_1`r_1 within w_neto_1
end type

type r_2 from w_filho_1`r_2 within w_neto_1
end type

type r_3 from w_filho_1`r_3 within w_neto_1
end type

