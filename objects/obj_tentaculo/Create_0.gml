/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

#region Variáveis

timer_teste = random_range(60, 300);

#endregion


#region estados
estado_saindo = new estado();
estado_idle   = new estado();
estado_volta  = new estado();



#region saindo

estado_saindo.inicia = function()
{
    sprite_index = spr_tentaculo_saindo;
    image_index  = 0;
}

estado_saindo.roda = function()
{
    //Animação acabou, eu fico idle
    if (acabou_animacao())
    {
        troca_estado(estado_idle);
    }
}

#endregion

#region idle
estado_idle.inicia = function()
{
    sprite_index = spr_tentaculo_idle;
    image_index  = 0;
}

estado_idle.roda = function()
{
    timer_teste--;
    
    if (timer_teste <= 0)
    {
        troca_estado(estado_volta);
    }
}

#endregion


#region volta
estado_volta.inicia = function()
{
    sprite_index = spr_tentaculo_voltando;
    image_index  = 0;
}

estado_volta.roda = function()
{
    if (acabou_animacao())
    {
        instance_destroy();
    }
}

#endregion

#endregion

inicia_estado(estado_saindo);