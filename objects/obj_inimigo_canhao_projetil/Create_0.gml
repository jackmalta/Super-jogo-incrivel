/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

event_inherited();
vel = 4;
velh = 0;
velv = 0;

dir = 0;

temp_velh = 0;
temp_velv = 0;

pai = noone;

estado_indo     = new estado();
estado_voltando = new estado();
estado_impacto  = new estado();



//Minha estrutura de sprites
minhas_sprites = 
{
    indo:
    {
        cima    : spr_inimigo_canhao_projetil_indo_back,
        lado    : spr_inimigo_canhao_projetil_indo_side,
        baixo   : spr_inimigo_canhao_projetil_indo_front,
    },
    
    voltando:
    {
        cima    : spr_inimigo_canhao_projetil_voltando_back,
        lado    : spr_inimigo_canhao_projetil_voltando_side,
        baixo   : spr_inimigo_canhao_projetil_voltando_front,
    },
    
    impacto:
    {
        cima    : spr_inimigo_canhao_projetil_impacto_back,
        lado    : spr_inimigo_canhao_projetil_impacto_side,
        baixo   : spr_inimigo_canhao_projetil_impacto_front,
    },
    
}

estado_indo.inicia = function()
{
    
    var _sprites_indo = minhas_sprites.indo;
    
    troca_sprite(dir, _sprites_indo);
}

estado_indo.roda = function()
{
    //Se eu me movi mais de 100 pixels, eu posso começar a voltar
    var _difx = abs(xstart - x);
    var _dify = abs(ystart - y);
    
    if (_difx + _dify >= 100)
    {
        troca_estado(estado_impacto);
    }
}

estado_impacto.inicia = function()
{
    
    var _sprites = minhas_sprites.impacto;
    
    troca_sprite(dir, _sprites);
    
    image_index  = 0;
    temp_velh = velh;
    temp_velv = velv;
    velh = 0;
    velv = 0;
}

estado_impacto.roda = function()
{
    //Animação acabou, eu começo a voltar
    if (image_index >= image_number-1)
    {
        troca_estado(estado_voltando);
    }
}

estado_voltando.inicia = function()
{
    var _sprites = minhas_sprites.voltando;
    
    troca_sprite(dir, _sprites);
    velh = -temp_velh;
    velv = -temp_velv;
}

estado_voltando.roda = function()
{
    //TODO destruir ele e avisar o pai dele que acabou o tiro
}

inicia_estado(estado_indo);