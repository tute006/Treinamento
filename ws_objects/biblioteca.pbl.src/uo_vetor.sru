$PBExportHeader$uo_vetor.sru
$PBExportComments$Métodos sobre vetor
forward
global type uo_vetor from nonvisualobject
end type
end forward

global type uo_vetor from nonvisualobject
end type
global uo_vetor uo_vetor

type variables
integer ii_Idade
end variables
forward prototypes
public function long of_adicionaritem (ref long al_vetor[], long al_item)
public function long of_inseriritem (ref long al_vetor[], long al_item, long al_posicaoinsercao)
end prototypes

public function long of_adicionaritem (ref long al_vetor[], long al_item);// =========================================================================================================
// = Função: adicionar um item ao final do vetor
// =
// = Parâmetros:  1. vetor a ser mantido  (retorno).
// =              2. item a ser adicionado.
// = Retorno:		quantidade de itens no vetor.
// ===================================================+======================================================

long ll_QtdItemVetor												// quantidade de itens no vetor


// inicialização
ll_QtdItemVetor = upperBound (al_Vetor)


al_Vetor [ll_QtdItemVetor + 1] = al_Item


// finalização
ll_QtdItemVetor = ll_QtdItemVetor + 1


return ll_QtdItemVetor

end function

public function long of_inseriritem (ref long al_vetor[], long al_item, long al_posicaoinsercao);// =========================================================================================================
// = Função: insere um item na posição informado no vetor. Se a posição de inserção for maior do que a 
// =         quantidade de elementos, insere no final na próxima posição disponível.
// =
// = Parâmetros:  1. vetor a ser mantido  (retorno).
// =              2. item a ser adicionado.
// = Retorno:		quantidade de itens no vetor.
// ===================================================+======================================================

long ll_PosicaoItem
long ll_QtdItemVetor												// quantidade de itens no vetor


// inicialização
ll_QtdItemVetor = upperBound (al_Vetor)


// verifica se a posição de inserção é maior do que a quantidade de itens
if (al_PosicaoInsercao > ll_QtdItemVetor) then
	ll_QtdItemVetor = of_AdicionarItem (al_Vetor, al_Item)
	return ll_QtdItemVetor
end if
	

// reposionar o vetor, incrementando a posição a partir da posição informada em 1
for ll_PosicaoItem = ll_QtdItemVetor to al_PosicaoInsercao step -1
	al_Vetor [ll_PosicaoItem + 1] = al_Vetor [ll_PosicaoItem]
next

// insero o item (al_Item) na posição de inserção
al_Vetor [al_PosicaoInsercao] = al_item


// finalização
ll_QtdItemVetor = ll_QtdItemVetor + 1


return ll_QtdItemVetor
end function

on uo_vetor.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_vetor.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

