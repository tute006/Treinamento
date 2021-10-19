$PBExportHeader$u_nv_processafolhapagamento.sru
$PBExportComments$Métodos de processo de folha de pagamento
forward
global type u_nv_processafolhapagamento from nonvisualobject
end type
end forward

global type u_nv_processafolhapagamento from nonvisualobject
end type
global u_nv_processafolhapagamento u_nv_processafolhapagamento

forward prototypes
public function boolean of_processafolhames (integer ai_mes, integer a_ano)
end prototypes

public function boolean of_processafolhames (integer ai_mes, integer a_ano);// =========================================================================================================
// = Função: verificar se o código da linha informada já existe.
// =
// = Parâmetros:  1. número da linha em análise.
// =              2. menasgem erro (retorno).
// = Retorno:		indica se o código já foi utilizado.
// = Observação:  .
// ===================================================+======================================================

datastore lds_HorasTrabalhadasEmpregado					// busca quantidade de horas trabalhadas pelo empregado
datastore lds_SalarioBaseEmpregado							// busca informação de salário base do empregado
long i																// índice
long ll_NumEmpregados											// número de empregados da empresa

// inicialização
lds_SalarioBaseEmpregado = create datastore
lds_SalarioBaseEmpregado.dataObject = 'd_lista_empregado_salario_hora'
lds_SalarioBaseEmpregado.setTransObject (SQLCA)


// lê salário-hora de cada empregado
ll_NumEmpregados = lds_SalarioBaseEmpregado.retrieve()

// processa cada empregado
for i = 1 to ll_NumEmpregados
	
next

// processo

// Gravar
lds_SalarioBaseEmpregado.update()

// finalizar
destroy lds_SalarioBaseEmpregado

return true
end function

on u_nv_processafolhapagamento.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_nv_processafolhapagamento.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

