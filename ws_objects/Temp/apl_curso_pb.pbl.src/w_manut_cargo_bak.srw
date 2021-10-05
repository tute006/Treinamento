$PBExportHeader$w_manut_cargo_bak.srw
$PBExportComments$Manutenção de cargo (backup)
forward
global type w_manut_cargo_bak from window
end type
type cb_exportar from commandbutton within w_manut_cargo_bak
end type
type cb_inserir from commandbutton within w_manut_cargo_bak
end type
type cb_excluir from commandbutton within w_manut_cargo_bak
end type
type cb_adicionar from commandbutton within w_manut_cargo_bak
end type
type cb_gravar from commandbutton within w_manut_cargo_bak
end type
type cb_recuperar from commandbutton within w_manut_cargo_bak
end type
type dw_manut_cargo from datawindow within w_manut_cargo_bak
end type
end forward

global type w_manut_cargo_bak from window
integer width = 2821
integer height = 1212
boolean titlebar = true
string title = "Manutenção cargo"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
event type boolean u_validadados ( ref string as_mensagemerro )
event type boolean u_pregravacao ( ref string as_mensagemerro )
event u_adicionalinha ( )
event u_inserirlinha ( )
event u_excluirlinha ( )
event u_recuperardados ( )
event u_exportardados ( )
event u_gravardados ( )
event u_copiadadocompute ( )
cb_exportar cb_exportar
cb_inserir cb_inserir
cb_excluir cb_excluir
cb_adicionar cb_adicionar
cb_gravar cb_gravar
cb_recuperar cb_recuperar
dw_manut_cargo dw_manut_cargo
end type
global w_manut_cargo_bak w_manut_cargo_bak

type variables

end variables

forward prototypes
public function boolean of_verificaregistroduplicado (integer ai_numlinha, ref string as_mensagemerro)
end prototypes

event type boolean u_validadados(ref string as_mensagemerro);// =========================================================================================================
// = Função: valida os campos da datawindow.
// =
// = Parâmetros:  1. mensagem de erro (retorno).
// = Retorno:		status da operação - se os dados estão ok
// ===================================================+======================================================

boolean vlb_Ok														// status da operação
decimal{2} vldc_Salario											// salário
integer i, j														// índice genérico
integer vli_CodCargo												// código do cargo
integer vli_NumLinhas											// número de linhas da datawindow
string vls_DescCargo												// descrição do cargo	

// inicialização
vlb_Ok = true
vli_NumLinhas = dw_Manut_Cargo.rowCount()


// validação de campos
for i = 1 to vli_NumLinhas
	// valida código
	vli_CodCargo = dw_Manut_Cargo.getItemNumber (i, 'cod_cargo')
	if (isNull (vli_CodCargo)) then
		as_MensagemErro = 'Código não informado na linha ' + string (i)
		return false
	end if
	if (vli_CodCargo < 1) then
		as_MensagemErro = 'Código deve ser maior que 0 (zero) na linha ' + string (i)
		return false
	end if
	
	// valida descrição
	vls_DescCargo = dw_Manut_Cargo.getItemString (i, 'desc_cargo')
	if (isNull (vls_DescCargo) or (trim (vls_DescCargo) = '')) then
		as_MensagemErro = 'Descrição não informada na linha ' + string (i)
		return false
	end if

	// valida salário
	vldc_Salario = dw_Manut_Cargo.getItemNumber (i, 'salario')
	if (isNull (vldc_Salario)) then
		as_MensagemErro = 'Salário não informado na linha ' + string (i)
		return false
	end if
	if (vldc_Salario < 0) then
		as_MensagemErro = 'Salário não pdoe ser negativo na linha ' + string (i)
		return false
	end if

	// verifica se código do carga está duplicado
	vlb_Ok = of_VerificaRegistroDuplicado (i, as_MensagemErro)
	if (not vlb_Ok) then
		return false
	end if

	// alternativo
	//	vlb_Ok = (not isNull (vli_CodCargo))
	//	if (not vlb_Ok) then
	//		as_MensagemErro = 'Código não informado na linha ' + string (i)
	//		return false
	//	end if
next

// finalização

return true

end event

event type boolean u_pregravacao(ref string as_mensagemerro);// =========================================================================================================
// = Função: permitir ações antes de se gravar os dados
// =
// = Parâmetros:  1. mensagem de erro (retorno).
// = Retorno:		status da operação - se os dados estão ok
// ===================================================+======================================================

boolean vlb_Ok														// status da operação
long i																// índice genérico
long vll_QtdLinhas												// quantidade de linhas da datawindow

// inicialização
vlb_Ok = true
vll_QtdLinhas = dw_Manut_Cargo.rowCount()


// inclui informações obrigatório
for i = 1 to vll_QtdLinhas
	dw_Manut_Cargo.setItem (i, 'id_aluno', 2)
next


// finalização

return vlb_Ok

end event

event u_adicionalinha();dw_Manut_Cargo.insertRow (0)

return

end event

event u_inserirlinha();long vll_NumLinhaAtual											// número da linha atual

// busca a linha corrente da datawindow
vll_NumLinhaAtual = dw_Manut_Cargo.getRow()

// insere linha
dw_Manut_Cargo.insertRow (vll_NumLinhaAtual)

return
end event

event u_excluirlinha();long vll_NumLinhaAtual											// número da linha atual

// busca a linha corrente da datawindow
vll_NumLinhaAtual = dw_Manut_Cargo.getRow()

// insere linha
dw_Manut_Cargo.deleteRow (vll_NumLinhaAtual)

return
end event

event u_recuperardados();
long vll_QtdLinhas												// quantidade de linhas recuperadas

vll_QtdLinhas = dw_Manut_Cargo.retrieve()


messageBox ('Qtd Linhas', vll_QtdLinhas)

return

end event

event u_exportardados();integer i															// índice genérico
integer vli_LinhaDuplo
integer vli_NumArquivo											// número do arquivo
integer vli_NumLinhas											// número de linhas da datawindow
integer vli_Retorno												// retorno de função
string vls_ExtensaoArquivo										// extensão do arquivo
string vls_NomeArquivo											// nome do arquivo a ser exportado
string vls_NomeArquivoCompleto								// nome do arquivo a ser exportado + path
SaveAsType vlsat_TipoArquivo									// tipo de arquivo

// inicialização
vli_NumLinhas = dw_Manut_Cargo.rowCount()
//vls_NomeArquivo = 'J:\TreinamentoPB\ExportaçãoArquivo.xls'

// selecona o nome do arquivo
vli_Retorno = getFileSaveName ( 'Selecione o arquivo', vls_NomeArquivoCompleto, &
											vls_NomeArquivo, 'TXT', 'Excel (*.xls),*.xls, Texto (*.txt),*.txt')
choose case vli_Retorno
	case 0	// cancelado pelo usuário
		return
	case -1
		messageBox ('Exportação', 'Erro ao selecionar arquivo')
		return
end choose

// define extensão do arquivo
vls_ExtensaoArquivo = lower (mid (vls_NomeArquivoCompleto, lastPos (vls_NomeArquivoCompleto, '.') + 1))
choose case vls_ExtensaoArquivo
	case 'xls', 'xlsx'
		vlsat_TipoArquivo = Excel8!
	case 'txt'
		vlsat_TipoArquivo = Text!
	case else
		messageBox ('Exportação', 'Extensão do arquivo não reconhecida')
		return
end choose


// copia dados de campos compute para exportação
event u_CopiaDadoCompute()


// verifica se o arquivo já está aberto
vli_NumArquivo = fileOpen (vls_NomeArquivoCompleto, StreamMode!, Write!, LockWrite!)
if (vli_NumArquivo = -1) then
	messageBox ('Exportação', 'Verifique se o arquivo não está aberto por outro usuário')
	return
end if
fileClose (vli_NumArquivo)


// exporta arquivo
vli_Retorno = dw_Manut_Cargo.saveAs (vls_NomeArquivoCompleto, vlsat_TipoArquivo, true)
choose case vli_Retorno
	case 1
		messageBox ('Exportação', 'Arquivo exportado com sucesso')
	case -1
		messageBox ('Exportação', 'Erro ao exportar arquivo')
end choose


return

end event

event u_gravardados();boolean vlb_Ok															// indica se os dados estão ok
integer vll_Retorno													// quantidade de linhas recuperadas
string vls_MensagemErro												// mensagem de erro da gravação

// carrega dado editado no buffer
vll_Retorno = dw_Manut_Cargo.acceptText( )
if (vll_Retorno = -1) then
	return
end if

// valida se os dados estao ok
vlb_Ok = event u_ValidaDados (vls_MensagemErro)
if (not vlb_Ok) then
	messageBox ('Erro de validação', vls_MensagemErro, StopSign!)
	return
end if

// verifica se há dados a serem gravados
if (dw_Manut_Cargo.modifiedCount() = 0) and (dw_Manut_Cargo.deletedCount() = 0) then
	messageBox ('Gravação', 'Não há dados a serem gravados')
	return
end if


// grava os dados no banco de dados
vll_Retorno = dw_Manut_Cargo.update()

if (vll_Retorno = 1) then
	commit;
	messageBox ('Gravação', 'Dados gravados com sucesso')
else
	// define mensagem de erro
	vls_MensagemErro = 'Erro ao gravar dados'
	rollback;

	// verifica se tem erro de banco de dados
	if (sqlca.sqlCode <> 0) then
		vls_MensagemErro = vls_MensagemErro + '~r~n' + 'Erro banco de dados: ' + sqlca.sqlErrText
	end if	
	
	// exibe mensagem
	messageBox ('Gravação', vls_MensagemErro, StopSign!)
	
end if


return

end event

event u_copiadadocompute();// =========================================================================================================
// = Função: copia dados de campos computed field para campos de datawindow (buffer)
// ===================================================+======================================================

integer i															// índice genérico
integer vli_NumLinhas											// número de linhas da datawindow
string vls_Faixa													// faixa de salário

// inicialização
vli_NumLinhas = dw_Manut_Cargo.rowCount()


// copia o campo duplo linha para o buffer
for i = 1 to vli_NumLinhas
	vls_Faixa = dw_Manut_Cargo.getItemString (i, 'cf_faixa')
	dw_Manut_Cargo.setItem (i, 'faixa', vls_Faixa)
next


return

end event

public function boolean of_verificaregistroduplicado (integer ai_numlinha, ref string as_mensagemerro);// =========================================================================================================
// = Função: verificar se o código da linha informada já existe.
// =
// = Parâmetros:  1. número da linha em análise.
// =              2. menasgem erro (retorno).
// = Retorno:		indica se o código já foi utilizado.
// ===================================================+======================================================

boolean vlb_Ok														// status da operação
integer vli_NumLinhaDuplicada									// número da linha duplicada
integer vli_QtdLinhas											// quantidade de linhas da datawindow
long vll_CodCargoLinha											// código do cargo da linha que está em análise
string vls_ExpressaoBusca										// expressão de busca


// inicialização
vlb_Ok = true
vll_CodCargoLinha = dw_Manut_Cargo.getItemNumber (ai_NumLinha, 'cod_cargo')
vli_QtdLinhas = dw_Manut_Cargo.rowCount()
vls_ExpressaoBusca = 'cod_cargo = ' + string (vll_CodCargoLinha)

// verifica se está tratando a última linha evitando que ela seja identificada como repetida - vide comando find
if (ai_NumLinha = vli_QtdLinhas) then
	return true
end if


// verifica se o código já existe a partir da linha informada
vli_NumLinhaDuplicada = dw_Manut_Cargo.find (vls_ExpressaoBusca, ai_NumLinha + 1, vli_QtdLinhas) 
vlb_Ok = (vli_NumLinhaDuplicada = 0)
if (not vlb_Ok) then
	as_MensagemErro = 'O código ' + string (vll_CodCargoLinha) + ' está duplicado ~r~nnas linhas ' + &
							string (ai_NumLinha) + ' e ' + string (vli_NumLinhaDuplicada)
end if

// finalização

return vlb_Ok
end function

on w_manut_cargo_bak.create
this.cb_exportar=create cb_exportar
this.cb_inserir=create cb_inserir
this.cb_excluir=create cb_excluir
this.cb_adicionar=create cb_adicionar
this.cb_gravar=create cb_gravar
this.cb_recuperar=create cb_recuperar
this.dw_manut_cargo=create dw_manut_cargo
this.Control[]={this.cb_exportar,&
this.cb_inserir,&
this.cb_excluir,&
this.cb_adicionar,&
this.cb_gravar,&
this.cb_recuperar,&
this.dw_manut_cargo}
end on

on w_manut_cargo_bak.destroy
destroy(this.cb_exportar)
destroy(this.cb_inserir)
destroy(this.cb_excluir)
destroy(this.cb_adicionar)
destroy(this.cb_gravar)
destroy(this.cb_recuperar)
destroy(this.dw_manut_cargo)
end on

event open;dw_Manut_Cargo.setTransObject (SQLCA)

return


end event

type cb_exportar from commandbutton within w_manut_cargo_bak
integer x = 1175
integer y = 908
integer width = 402
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Exportar"
end type

event clicked;event u_ExportarDados()

return

end event

type cb_inserir from commandbutton within w_manut_cargo_bak
integer x = 2359
integer y = 224
integer width = 334
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Inserir"
end type

event clicked;event u_InserirLinha( )

return
end event

type cb_excluir from commandbutton within w_manut_cargo_bak
integer x = 2359
integer y = 364
integer width = 334
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Excluir"
end type

event clicked;event u_ExcluirLinha( )

return

end event

type cb_adicionar from commandbutton within w_manut_cargo_bak
integer x = 2359
integer y = 84
integer width = 334
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Adicionar"
end type

event clicked;event u_AdicionaLinha()

return
end event

type cb_gravar from commandbutton within w_manut_cargo_bak
integer x = 649
integer y = 908
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Gravar"
end type

event clicked;event u_GravarDados()

return
end event

type cb_recuperar from commandbutton within w_manut_cargo_bak
integer x = 123
integer y = 908
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Recuperar"
end type

event clicked;event u_RecuperarDados()

return

end event

type dw_manut_cargo from datawindow within w_manut_cargo_bak
integer x = 18
integer y = 28
integer width = 2263
integer height = 820
integer taborder = 10
string title = "Cargos"
string dataobject = "dw_Cargo"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event sqlpreview;messageBox ('SQL - Linha ' + string (row), sqlSyntax)
end event

