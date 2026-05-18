/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor


#region Variaveis

dist_olho_max = sprite_width/6;
dist_olho = 0;

contador_piscadas = 0;
tempo_idle = 300;
timer_idle = tempo_idle;

img_ind = 0;

tempo_timido = 120;
timer_timido = tempo_timido;

//Definindo meu alvo
alvo = global.player_atual;

txt_estado = "idle";
#endregion


#region Estados
estado_abrindo  = new estado();
estado_idle     = new estado();
estado_fechando = new estado();
estado_pisca1   = new estado();
estado_pisca2   = new estado();  
estado_sumindo  = new estado();


#region abrindo
estado_abrindo.inicia = function()
{
    txt_estado = "abrindo";
    sprite_index = spr_olho_frente_abre;
    image_index  = 0;
}


estado_abrindo.roda = function()
{
    //Se a animação acabou, eu vou para o estado de idle
    if (acabou_animacao())
    {
        var _estado = choose(estado_pisca2, estado_pisca1, estado_idle)
        troca_estado(_estado);
    }
}

#endregion


#region idle

estado_idle.inicia = function()
{
    txt_estado = "idle";
    sprite_index = spr_olho_frente_idle;
    image_index  = 0;
    timer_idle   = tempo_idle;
}

estado_idle.roda = function()
{
    //Dar uma chance dele piscar né
    //Se o timer de idle acabou, eu posso trocar de estado
    timer_idle--;
    if (timer_idle <= 0)
    {
        var _estado = choose(estado_pisca1, estado_pisca2);
        troca_estado(_estado);
    }
    
    //Se ele ficou timido, eu vou sumir
    if (timer_timido <= 0)
    {
        troca_estado(estado_sumindo);
    }
}


estado_idle.finaliza = function()
{
    timer_idle = tempo_idle;
}
#endregion


#region pisca1

estado_pisca1.inicia = function()
{
    txt_estado = "pisca1";
    sprite_index = spr_olho_frente_pisca;
    image_index  = 0;
}

estado_pisca1.roda = function()
{
    if (acabou_animacao())
    {
        troca_estado(estado_idle);
    }
}

#endregion


#region Pisca 2

estado_pisca2.inicia = function()
{
    txt_estado = "pisca2";
    sprite_index = spr_olho_frente_pisca;
    image_index  = 0;
    image_speed  = 6;
    contador_piscadas = 0;
    img_ind = 0;
}

estado_pisca2.roda = function()
{
    //Se o img_ind for maior do que o image index, quer dizer
    //Que a animação acabou e eu ainda não atualizei o img_ind
    if (img_ind > image_index)
    {
        contador_piscadas++;
    }
    
    //Eu estou acompanhando a minha animação
    img_ind = image_index;
    
        
    
    
    //Se ele piscou 5x, ele fica idle
    if (contador_piscadas >= 3)
    {
        troca_estado(estado_idle);
    }
}

estado_pisca2.finaliza = function()
{
    image_speed = 1;
}

#endregion

#region sumingo
estado_sumindo.inicia = function()
{
    txt_estado = "sumindo";
    sprite_index = spr_olho_frente_fecha;
    image_index  = 0;
}

estado_sumindo.roda = function()
{
    if (acabou_animacao())
    {
        instance_destroy();
    }
}

#endregion


#endregion


#region metodos

//Método para atualizar o meu... alvo
atualiza_alvo = function()
{
    alvo = global.player_atual;
}

#endregion

//Iniciando o estado
inicia_estado(estado_abrindo);