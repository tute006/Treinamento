$PBExportHeader$ou_empregado.sru
$PBExportComments$Médotos sobre tabela empregado
forward
global type ou_empregado from nonvisualobject
end type
end forward

global type ou_empregado from nonvisualobject
end type
global ou_empregado ou_empregado

forward prototypes
public function long of_gerasequencial (ref string as_mensagemerro)
end prototypes

public function long of_gerasequencial (ref string as_mensagemerro);long vll_NumSequencial		// sequencial do empregado


// recupera maior sequencial da tabela de empregado
  SELECT Max (empregado.cod_empregado)
    INTO :vll_NumSequencial
    FROM empregado  
   WHERE empregado.cod_aluno = :vgl_CodAluno   ;
	
// verifica se valor é nulo
if (isNull (vll_NumSequencial)) then
	vll_NumSequencial = 0
end if

// verifica status do banco de dados
choose case sqlca.sqlCode 
	case 0	// encontrou o valor máximo
		vll_NumSequencial = vll_NumSequencial + 1
		
	case 100	// valor não encontrado - considera 1
		vll_NumSequencial = 1
		
	case else // erro
		vll_NumSequencial = 0
		as_MensagemErro = sqlca.sqlErrText
end choose


return vll_NumSequencial

end function

on ou_empregado.create
call super::create
TriggerEvent( this, "constructor" )
end on

on ou_empregado.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

