$PBExportHeader$apl_curso_pb.sra
$PBExportComments$Generated Application Object
forward
global type apl_curso_pb from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
constant integer vgi_IdAluno = 44								// identificador do aluno
end variables

global type apl_curso_pb from application
string appname = "apl_curso_pb"
string appruntimeversion = "19.2.0.2670"
end type
global apl_curso_pb apl_curso_pb

on apl_curso_pb.create
appname="apl_curso_pb"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on apl_curso_pb.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;

// Profile Treinamento
SQLCA.DBMS = "ORA Oracle"
SQLCA.LogPass = 'dono'
SQLCA.ServerName = "adm_crp_ds.scl.corp"
SQLCA.LogId = "TREINAMENTO"
SQLCA.AutoCommit = False
SQLCA.DBParm = "DelimitIdentifier='No',OJSyntax='ANSI',DisableBind=1"


connect using sqlca;
if (sqlca.sqlCode = 0) then
//	messageBox ('Conexão banco de dados', 'Conexão efetuada com sucesso')
else
	messageBox ('Erro de conexão', 'Erro ao conectar com o banco de dados.~r~n' + sqlca.sqlErrText, StopSign!)
	return
end if


// abre tela principal
open (w_Selecao_Tela)


return
end event

