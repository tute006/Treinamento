$PBExportHeader$uo_folha_pagamento.sru
$PBExportComments$folha de pagamento
forward
global type uo_folha_pagamento from nonvisualobject
end type
end forward

global type uo_folha_pagamento from nonvisualobject
end type
global uo_folha_pagamento uo_folha_pagamento

forward prototypes
public function boolean of_calcula_folha_pagamento (integer ai_mes, integer ai_ano, transaction atr_transacao, ref string as_menssagem_erro)
public function long of_verifica_folha_processada (integer ai_mes, integer ai_ano, ref transaction atr_transacao)
end prototypes

public function boolean of_calcula_folha_pagamento (integer ai_mes, integer ai_ano, transaction atr_transacao, ref string as_menssagem_erro); datastore lds_Salario_Empregado
 datastore lds_Salario_Hora
 decimal ldc_Carga_Horaria_Mes
 decimal ldc_Salario_Empregado
 decimal ldc_Salario_Mensal
 integer li_retorno 
 long i 
 long ll_num_Empregado
 long ll_num_Linha_Salario_Empregado
 long ll_qtd_Empregados

 
 lds_Salario_Empregado = create datastore 
 lds_Salario_Empregado.dataobject = 'd_salario_empregado'
 lds_Salario_Empregado.settransobject(atr_transacao)
 
 lds_Salario_Hora = create datastore 
 lds_Salario_Hora.dataobject = 'd_salario_hora_empregado'
 lds_Salario_Hora.settransobject(atr_transacao)
 
 
 // limpa salários mês e ano já processados 
 DELETE FROM Salario_Empregado  
   WHERE ( Salario_Empregado.Mes = :ai_mes ) AND  
         ( Salario_Empregado.Ano = :ai_ano )   
			using atr_transacao
			;
if (atr_transacao.sqlcode<> 0) then
    as_menssagem_erro = 'Erro ao excluir Salário'
	return false 
end if 

// ler dados empregados e salário
ll_qtd_Empregados = lds_Salario_Hora.retrieve(ai_mes, ai_ano)
if (ll_qtd_Empregados < 0) then
    as_menssagem_erro = 'Erro ao recuperar empregado'
	return false 
end if 

// para cada empregado: 
for i = 1 to ll_qtd_Empregados
	// pegar salário
	ldc_Salario_Empregado = lds_Salario_Hora.getitemnumber( i, 'salario_hora' )
	ll_num_Empregado = lds_Salario_Hora.getitemnumber( i, 'matricula' )
	// horas trabalhadas 
	ldc_Carga_Horaria_Mes = lds_Salario_Hora.getitemnumber( i, 'carga_horaria' )
	// calcular salário 
	ldc_Salario_Mensal = ldc_Salario_Empregado * ldc_Carga_Horaria_Mes
	// gravar salário
//	  INSERT INTO Salario_Empregado  
//         ( Matricula,   
//           Mes,   
//           Ano,   
//           Salario )  
//  VALUES ( :ll_num_Empregado,   
//               :ai_mes,   
//              :ai_ano,   
//               :ldc_Salario_Mensal)  ;
//					
//	if (atr_transacao.sqlcode<> 0) then
//		 as_menssagem_erro = 'Erro ao inserir Salário'
//		return false 
//	end if 
// gravar salário com datastore
	ll_num_Linha_Salario_Empregado = lds_Salario_Empregado.insertRow( 0 )
	lds_Salario_Empregado.setitem( ll_num_Linha_Salario_Empregado, 'matricula', ll_num_Empregado)
	lds_Salario_Empregado.setitem( ll_num_Linha_Salario_Empregado, 'mes',ai_mes )
	lds_Salario_Empregado.setitem( ll_num_Linha_Salario_Empregado, 'ano', ai_ano)
	lds_Salario_Empregado.setitem( ll_num_Linha_Salario_Empregado, 'salario', ldc_Salario_Mensal)

next 

//gravar dados 
li_retorno = lds_Salario_Empregado.update( ) 
if (li_retorno = -1 ) then
	 as_menssagem_erro = 'Erro ao gravar dados salário empregado'
	return false 
end if 
destroy lds_Salario_Empregado
destroy lds_Salario_Hora

return true 
end function

public function long of_verifica_folha_processada (integer ai_mes, integer ai_ano, ref transaction atr_transacao); long ll_qtd_Pagamentos
 
 
 SELECT count  (*) contador  
    INTO :ll_qtd_Pagamentos  
    FROM Salario_Empregado  
   WHERE ( Salario_Empregado.Mes = :ai_mes ) AND  
         ( Salario_Empregado.Ano = :ai_ano )   ;

 if (atr_Transacao.sqlcode <> 0 ) then
	return -1 
 end if
 
 return ll_qtd_Pagamentos
end function

on uo_folha_pagamento.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_folha_pagamento.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

