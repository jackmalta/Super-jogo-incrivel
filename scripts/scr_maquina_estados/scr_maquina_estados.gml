// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações

function estado() constructor 
{
    //Iniciando o estado
    static inicia = function(){};
    //Roda o estado
    static roda = function(){};
    //Finaliza o estado
    static finaliza = function(){};
}

//Funçao para iniciar um estado específico
function inicia_estado(_estado)
{
    //Vou definir o meu estado atual como o estado que foi passado
    estado_atual = _estado;
    //Vou rodar o método de iniciar o estado atual
    estado_atual.inicia();
}


//Função para trocar de estado
function troca_estado(_estado)
{
    //Eu vou finalizar o estado atual
    estado_atual.finaliza();
    
    estado_atual = _estado;
    
    //Iniciando o estado atual
    estado_atual.inicia();
}

//Rodar o meu estado
function roda_estado()
{
    estado_atual.roda();
}