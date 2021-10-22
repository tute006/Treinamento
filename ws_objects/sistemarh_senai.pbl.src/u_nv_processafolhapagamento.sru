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
public function boolean of_processafolhames_original (integer ai_mes, integer a_ano)
public function boolean of_processafolhames (integer ai_mes, integer a_ano)
public function decimal of_cargahorariaempregado (long al_matricula)
public function boolean of_processafolhames_cursor (integer ai_mes, integer a_ano)
end prototypes

public function boolean of_processafolhames_original (integer ai_mes, integer a_ano);// =========================================================================================================
// = Função: verificar se o código da linha informada já existe.
// =
// = Parâmetros:  1. número da linha em análise.
// =              2. menasgem erro (retorno).
// = Retorno:		indica se o código já foi utilizado.
// = Observação:  .
// ===================================================+======================================================

datastore lds_HorasTrabalhadasEmpregado					// busca quantidade de horas trabalhadas pelo empregado
datastore lds_SalarioBaseEmpregado							// busca informação de salário base do empregado
decimal ldc_HorasTrabalhadasEmpregado						// horas que o empregado tabalhou no mês
decimal ldc_SalarioEmpregado									// salário do empregado
decimal ldc_SalarioHoraEmpregado								// salário/hora do empregado
long i																// índice
long ll_MatriculaEmpregado										// matrícula do empregado
long ll_NumEmpregados											// número de empregados da empresa
long ll_NumLinhaCargaHorariaEmpregado						// número da linha onde tem a informação da carga horária do empregado
string ls_CriterioBusca											// critério de busca

// inicialização
lds_SalarioBaseEmpregado = create datastore
lds_SalarioBaseEmpregado.dataObject = 'd_lista_empregado_salario_hora'
lds_SalarioBaseEmpregado.setTransObject (SQLCA)

lds_HorasTrabalhadasEmpregado = create datastore
lds_HorasTrabalhadasEmpregado.dataObject = 'd_manut_cargahoraria_mes_empregado'
lds_HorasTrabalhadasEmpregado.setTransObject (SQLCA)


// Ler tabela de Matrícula/SalarioHora
ll_NumEmpregados = lds_SalarioBaseEmpregado.retrieve()

// ler todas as cargas horárias de todos os empregados
lds_HorasTrabalhadasEmpregado.retrieve()


// lê salário-hora de cada empregado

// processa cada empregado
for i = 1 to ll_NumEmpregados
	// determina o empregado que está sendo processado no momento
	ll_MatriculaEmpregado = lds_SalarioBaseEmpregado.getItemNumber (i, 'matricula')
	ldc_SalarioHoraEmpregado = lds_SalarioBaseEmpregado.getItemNumber (i, 'salario_hora')
	
	// procurar hora trabalhada o quanto a pessoa trabalhou no mês
	ls_CriterioBusca = 'matricula = ' + string (ll_MatriculaEmpregado)
	ll_NumLinhaCargaHorariaEmpregado = lds_HorasTrabalhadasEmpregado.Find (ls_CriterioBusca, 1, lds_HorasTrabalhadasEmpregado.rowCount())

	// verifica se acho horas do empregado no mês
	if (ll_NumLinhaCargaHorariaEmpregado = 0) then
		ldc_HorasTrabalhadasEmpregado = 0
	else
		ldc_HorasTrabalhadasEmpregado = lds_HorasTrabalhadasEmpregado.getItemNumber (ll_NumLinhaCargaHorariaEmpregado, 'carga_horaria')
	end if
	
	// Calcula o salário multiplicando SalarioHora por HoraTRabalhada
	ldc_SalarioEmpregado = ldc_SalarioHoraEmpregado * ldc_HorasTrabalhadasEmpregado
	
	// Grava na tabela salário total
	
next


// Gravar
lds_SalarioBaseEmpregado.update()

// finalizar
destroy lds_SalarioBaseEmpregado
destroy lds_HorasTrabalhadasEmpregado

return true
end function

public function boolean of_processafolhames (integer ai_mes, integer a_ano);// =========================================================================================================
// = Função: verificar se o código da linha informada já existe.
// =
// = Parâmetros:  1. número da linha em análise.
// =              2. menasgem erro (retorno).
// = Retorno:		indica se o código já foi utilizado.
// = Observação:  .
// ===================================================+======================================================

datastore lds_SalarioBaseEmpregado							// busca informação de salário base do empregado
decimal ldc_HorasTrabalhadasEmpregado						// horas que o empregado tabalhou no mês
decimal ldc_SalarioEmpregado									// salário do empregado
decimal ldc_SalarioHoraEmpregado								// salário/hora do empregado
long i																// índice
long ll_MatriculaEmpregado										// matrícula do empregado
long ll_NumEmpregados											// número de empregados da empresa

// inicialização
lds_SalarioBaseEmpregado = create datastore
lds_SalarioBaseEmpregado.dataObject = 'd_lista_empregado_salario_hora'
lds_SalarioBaseEmpregado.setTransObject (SQLCA)


// Ler tabela de Matrícula/SalarioHora
ll_NumEmpregados = lds_SalarioBaseEmpregado.retrieve()


// processa cada empregado
for i = 1 to ll_NumEmpregados
	// determina o empregado que está sendo processado no momento
	ll_MatriculaEmpregado = lds_SalarioBaseEmpregado.getItemNumber (i, 'matricula')
	ldc_SalarioHoraEmpregado = lds_SalarioBaseEmpregado.getItemNumber (i, 'salario_hora')
	
	// procurar hora trabalhada o quanto a pessoa trabalhou no mês
	ldc_HorasTrabalhadasEmpregado = of_CargaHorariaEmpregado (ll_MatriculaEmpregado)

	// Calcula o salário multiplicando SalarioHora por HoraTRabalhada
	ldc_SalarioEmpregado = ldc_SalarioHoraEmpregado * ldc_HorasTrabalhadasEmpregado
	
	// Grava na tabela salário total
next


// finalizar
destroy lds_SalarioBaseEmpregado

return true
end function

public function decimal of_cargahorariaempregado (long al_matricula);// =========================================================================================================
// = Função: verificar se o código da linha informada já existe.
// =
// = Parâmetros:  1. número da linha em análise.
// =              2. menasgem erro (retorno).
// = Retorno:		indica se o código já foi utilizado.
// = Observação:  .
// ===================================================+======================================================

datastore lds_HorasTrabalhadasEmpregado					// busca quantidade de horas trabalhadas pelo empregado
decimal ldc_HorasTrabalhadasEmpregado						// horas que o empregado tabalhou no mês
long ll_NumLinhaCargaHorariaEmpregado						// número da linha onde tem a informação da carga horária do empregado
string ls_CriterioBusca											// critério de busca

// inicialização

lds_HorasTrabalhadasEmpregado = create datastore
lds_HorasTrabalhadasEmpregado.dataObject = 'd_manut_cargahoraria_mes_empregado'
lds_HorasTrabalhadasEmpregado.setTransObject (SQLCA)


// ler todas as cargas horárias de todos os empregados
lds_HorasTrabalhadasEmpregado.retrieve()


// procurar hora trabalhada o quanto a pessoa trabalhou no mês
al_Matricula = 6
ls_CriterioBusca = 'matricula = ' + string (al_Matricula)
ll_NumLinhaCargaHorariaEmpregado = lds_HorasTrabalhadasEmpregado.Find (ls_CriterioBusca, 1, lds_HorasTrabalhadasEmpregado.rowCount())

// verifica se acho horas do empregado no mês
if (ll_NumLinhaCargaHorariaEmpregado = 0) then
	ldc_HorasTrabalhadasEmpregado = 0
else
	ldc_HorasTrabalhadasEmpregado = lds_HorasTrabalhadasEmpregado.getItemNumber (ll_NumLinhaCargaHorariaEmpregado, 'carga_horaria')
end if

destroy lds_HorasTrabalhadasEmpregado

return ldc_HorasTrabalhadasEmpregado
end function

public function boolean of_processafolhames_cursor (integer ai_mes, integer a_ano);// =========================================================================================================
// = Função: verificar se o código da linha informada já existe.
// =
// = Parâmetros:  1. número da linha em análise.
// =              2. menasgem erro (retorno).
// = Retorno:		indica se o código já foi utilizado.
// = Observação:  .
// ===================================================+======================================================

decimal ldc_HorasTrabalhadasEmpregado						// horas que o empregado tabalhou no mês
decimal ldc_SalarioEmpregado									// salário do empregado
decimal ldc_SalarioHoraEmpregado								// salário/hora do empregado
long i																// índice
long ll_MatriculaEmpregado										// matrícula do empregado
long ll_NumEmpregados											// número de empregados da empresa

	 
  SELECT matricula
    INTO :ll_NumEmpregados  
    FROM Empregado  ;
	if sqlca.sqlcode <> 0 then
		// gera erro
	end if



// inicialização
 DECLARE CR_SalarioBaseEmpregado CURSOR FOR  
  SELECT Empregado.matricula,   
         Empregado.salario_hora  
    FROM Empregado  ;
	if sqlca.sqlcode <> 0 then
		// gera erro
	end if

OPEN CR_SalarioBaseEmpregado; 
	if sqlca.sqlcode <> 0 then
		// gera erro
	end if


FETCH CR_SalarioBaseEmpregado 
   INTO :ll_MatriculaEmpregado, :ldc_SalarioHoraEmpregado;


do while sqlca.sqlcode = 0
	// procurar hora trabalhada o quanto a pessoa trabalhou no mês
	ldc_HorasTrabalhadasEmpregado = of_CargaHorariaEmpregado (ll_MatriculaEmpregado)

	// Calcula o salário multiplicando SalarioHora por HoraTRabalhada
	ldc_SalarioEmpregado = ldc_SalarioHoraEmpregado * ldc_HorasTrabalhadasEmpregado
	
	FETCH CR_SalarioBaseEmpregado 
   	INTO :ll_MatriculaEmpregado, :ldc_SalarioHoraEmpregado;
loop


CLOSE CR_SalarioBaseEmpregado;
	if sqlca.sqlcode <> 0 then
		// gera erro
	end if


// finalizar


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

