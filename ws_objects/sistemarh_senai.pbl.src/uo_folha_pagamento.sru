$PBExportHeader$uo_folha_pagamento.sru
$PBExportComments$Folha de Pagamento.
forward
global type uo_folha_pagamento from nonvisualobject
end type
end forward

global type uo_folha_pagamento from nonvisualobject
end type
global uo_folha_pagamento uo_folha_pagamento

forward prototypes
public function boolean of_calcula_folha_pagamento (integer ai_mes, integer ai_ano, transaction atr_transacao, ref string as_mensagem_erro)
end prototypes

public function boolean of_calcula_folha_pagamento (integer ai_mes, integer ai_ano, transaction atr_transacao, ref string as_mensagem_erro);datastore lds_Salario_Hora

lds_Salario_Hora = create datastore
lds_Salario_Hora.dataobject = 'd_salario_hora_empregado'
lds_Salario_Hora.settransobject(atr_transacao)

  DELETE FROM Salario_Empregado  
   WHERE ( Salario_Empregado.mes = :ai_mes ) AND  
         ( Salario_Empregado.ano = :ai_ano ) 
			using atr_transacao;
			
			 if(atr_transacao.sqlcode<>0)then
			 as_mensagem_erro = "Erro ao excluir Salário"
			 return false
			 
		end if
		//ler dados empregados e salário
		
		//parar cada empregado:
		//pegar salario
		//horas trabalhadas
		//calcular salário
		//gravar salário
end function

on uo_folha_pagamento.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_folha_pagamento.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

