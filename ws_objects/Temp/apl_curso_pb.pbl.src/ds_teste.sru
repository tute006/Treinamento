$PBExportHeader$ds_teste.sru
forward
global type ds_teste from datastore
end type
end forward

global type ds_teste from datastore
end type
global ds_teste ds_teste

forward prototypes
public function integer of_teste ()
end prototypes

public function integer of_teste ();return 1
end function

on ds_teste.create
call super::create
TriggerEvent( this, "constructor" )
end on

on ds_teste.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

