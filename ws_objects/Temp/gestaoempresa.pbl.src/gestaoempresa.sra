$PBExportHeader$gestaoempresa.sra
$PBExportComments$Generated Application Object
forward
global type gestaoempresa from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
long vgl_CodAluno = 12345					// matrícula do aluno

end variables

global type gestaoempresa from application
string appname = "gestaoempresa"
string microhelpdefault = "Ok"
string themepath = "C:\Program Files (x86)\Appeon\PowerBuilder 19.0\IDE\theme"
string themename = "Do Not Use Themes"
boolean nativepdfvalid = false
boolean nativepdfincludecustomfont = false
string nativepdfappname = ""
long richtextedittype = 2
long richtexteditx64type = 3
long richtexteditversion = 1
string richtexteditkey = ""
string appicon = ""
string appruntimeversion = "19.2.0.2670"
end type
global gestaoempresa gestaoempresa

on gestaoempresa.create
appname="gestaoempresa"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on gestaoempresa.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;// Profile TreinamentoPB
SQLCA.DBMS = "ODBC"
SQLCA.AutoCommit = false
SQLCA.DBParm = "ConnectString='DSN=TreinamentoPB-32;UID=dba;PWD=sql',DelimitIdentifier='No',OJSyntax='ANSI'"


// conecta com o banco de dados
CONNECT using SQLCA;

// verifica a conexão - verifique propriedade SQLCode do objeto transaction
choose case SQLCA.sqlCode
	case 0	// comando bem sucedido
		//messageBox ('Conexão ao banco de dados', 'Conexão bem sucedida')
	case -1	// erro de conexão
		// sqlErrText - mensagem de erro do banco de dados
		// StopSign - ícone de erro para exibição de mensagem
		messageBox ('Erro de conexão', SQLCA.sqlErrText, StopSign!)
end choose


//// abre janela de manutenção de departamento
//open (w_Manut_Departamento)

// abre janela principal
open (w_mdi_GestaoEmpresa)

return

end event

event close;// desconecta com o banco de dados
// como SQLCA é a transação padrão, ela pode ser suprimida. Vale também para connect
DISCONNECT;

// verifica a conexão - verifique propriedade SQLCode do objeto transaction
choose case SQLCA.sqlCode
	case 0	// comando bem sucedido
		//messageBox ('Desconexão ao banco de dados', 'Desconexão bem sucedida')
	case -1	// erro de conexão
		messageBox ('Erro ao desconectar', SQLCA.sqlErrText, StopSign!)
end choose


return
end event

