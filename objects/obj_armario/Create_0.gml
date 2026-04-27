/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

estado_idle     = new estado();
estado_pega     = new estado();
estado_solta    = new estado();



tempo_tremida = 20;
timer_tremida = 20;


x_draw = x;

tempo_cuspir  = 60;
timer_cuspir  = tempo_cuspir;

//Posso cuspir o player?
pode_cuspir = false;

//Multiplicador peguei player
multi_pegou = 1;

//Timer para pegar o player
tempo_pega_player = 60;
timer_pega_player = 60;

estado_idle.inicia = function()
{
    sprite_index    = spr_armario_fechado;
    image_index     = 0;
    
    timer_pega_player = tempo_pega_player * multi_pegou;
}

estado_idle.roda = function()
{

    //Se eu posso cuspir o player, eu vou ficar tremendo
    if (pode_cuspir)
    {
        timer_cuspir--;
        
        timer_tremida = timer_cuspir;
        
        if (timer_cuspir <= 0)
        {
            troca_estado(estado_solta);
        }
    }
    
    //Checando se o player esta na minha frente
    var _player = collision_rectangle(x - 5, y, x + 5, y + 10, obj_ameba, 0, 1);
    
    if (_player)
    {
        //image_blend = c_yellow;
        //Diminuir o timer para pegar o player
        //Se o player não esta sendo comido
        if (_player.estado_atual != _player.estado_comido)
        {
        
            timer_pega_player--;
            
            if (timer_pega_player <= 0)
            {
                troca_estado(estado_pega);
            }
        }
        
    }
    else
    {
        image_blend = c_white;
        //Player não ta aqui, eu reseto o timer para pegar ele
        timer_pega_player = tempo_pega_player;
        
        //Se o player não esta na minha colisão a multi pegou volta a ser 1
        multi_pegou = 1;
    }
    
    tremidinha();
}

estado_pega.inicia = function()
{
    sprite_index    = spr_armario_pega;
    image_index     = 0;
    multi_pegou     = 3;
    
    
}

estado_pega.roda = function()
{
    //Terminou a animação eu fico parado novamente
    if (acabou_animacao())
    {
        troca_estado(estado_idle);
    }
    
    if (image_index > 2)
    {
        //comendo a ameba
        var _ameba = collision_rectangle(x - 20, y, x + 20, y + 30, obj_ameba, 0, 1);
        
        if (_ameba)
        {
            _ameba.sendo_comido();
            
            pode_cuspir = true;
        }
        
        depth -= 200;
    }
}


estado_solta.inicia = function()
{
    sprite_index = spr_armario_solta;
    image_index  = 0;
    
    //A ameba pode ficar visivel novamente
    var _ameba = collision_rectangle(x - 20, y, x + 20, y + 30, obj_ameba, 0, 1);
    
    if (_ameba)
    {
        _ameba.sendo_cuspido();
    }
    
}

estado_solta.roda = function()
{
    //Terminou a animação eu fico parado novamente
    if (acabou_animacao())
    {
        troca_estado(estado_idle);
    }
}

estado_solta.finaliza = function()
{
    pode_cuspir = false;
    multi_pegou = 3;
    timer_cuspir = tempo_cuspir;
}


come_player = function()
{
    if (estado_atual != estado_pega)
    {
        troca_estado(estado_pega);
    }
}
//Criando um método para ele dar uma tremidinha
tremidinha = function()
{
    timer_tremida--;
    if (timer_tremida > 0)
    {
        x_draw = xstart + random_range(-1, 1);
        
    }
    
    if (timer_tremida < -200)
    {
        timer_tremida = tempo_tremida;
        x_draw = xstart;
    }
}


inicia_estado(estado_idle);