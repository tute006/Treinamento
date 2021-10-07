$PBExportHeader$sistemarh.sra
$PBExportComments$Generated Application Object
forward
global type sistemarh from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global type sistemarh from application
string appname = "sistemarh"
string microhelpdefault = "Pronto"
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
string appruntimeversion = "19.2.0.2728"
end type
global sistemarh sistemarh

on sistemarh.create
appname="sistemarh"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on sistemarh.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;// parâmetros para conexão com o banco de dados
// este script pode ser obtido através do menu Tools / Database Profile / Conexão que deseja conectar / Edit
// selecione a aba preview. Lá será apresentado os parâmetros de conexão. Pressione o botão Copy para copiar e cole
// no script abaixo.
// Profile Adventure Works Conection
SQLCA.DBMS = "ADO.Net"
SQLCA.AutoCommit = False
SQLCA.DBParm = "Namespace='System.Data.SqlClient',DataSource='DESKTOP-DBV4DMD\SQLEXPRESS',TrustedConnection=1,Database='AdventureWorks2017'"


// conecta com o banco de dados utilizando a transação (conexão) sqlca.
// como sqlca é a padrão do Powerbuilder, ela pode ser suprimida, ou seja, 
// o comando poderia ser somente connect ; (não precisa ser connect using sqlca).
// para efeito didático, o sufixo using sqlca.
connect using sqlca ;

// testa se a conexão foi bem sucedida. Quando o último comando sql executado foi bem sucedido o atributo SqlCode retorna
if (sqlca.sqlCode <> 0) then
	messageBox ('Conexão', 'Erro na conexão. ' + sqlca.SQLErrText, StopSign!)
	return
end if

// abre a janela de cadastro de departamento
//open (w_CadastroDepartamento)
//open (w_Lista_Empregado_Pessoas)

open (w_mdi_Principal)


return

end event

