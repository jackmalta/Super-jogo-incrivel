// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações

function troca_sprite(_dir, _struct_sprites)
{
    
    switch(_dir)
    {
        case 0: sprite_index = _struct_sprites.lado;  break;
        case 1: sprite_index = _struct_sprites.cima;  break;
        case 2: sprite_index = _struct_sprites.lado;  break;
        case 3: sprite_index = _struct_sprites.baixo; break;
    }
}

//Função para avisar se a animação acabou
function acabou_animacao()
{
    //Checando se tem uma sprite
    if (sprite_index != -1)
    {
        //Checando se a animação acabou
        var _spd = sprite_get_speed(sprite_index) / game_get_speed(gamespeed_fps);
        if (image_index + _spd >= image_number)
        {
            return true;
        }
    }
    
    return false;
}


//Função para definir as minhas sprites
function define_sprite(_entidade_txt, _cor_txt, _estado_txt)
{
    var _entidade   = _entidade_txt == undefined    ? entidade_txt  : _entidade_txt;
    var _cor        = _cor_txt == undefined         ? cor_txt       : _cor_txt;
    var _estado     = _estado_txt == undefined      ? estado_txt    : _estado_txt;
    
    minhas_sprites  = global.lista_sprites[$ _entidade][$ _cor][$ _estado];
    
    image_index     = 0;
}

//Minha função para criar as colisões
function cria_colisao()
{
    //Determinando o tamanho do tileset
    var _tam = 32;
    //Determinando a quantidade de linhas e colunas
    var _cols = round(room_width / _tam);
    var _lins = round(room_height / _tam);
    
    //Tilemaps que eu vou trabalhar
    var _fundo      = layer_tilemap_get_id("Fundo");
    var _colisao    = layer_tilemap_get_id("Colisao");
    var _tile       = tile_set_index(_cols, 1);
    
    
    //Rodando por toda a minha room
    for (var i = 0; i < _cols; i++)
    {
        for (var j = 0; j < _lins; j++)
        {
            //Descobrindo qual o tile atual
            var _atual = tilemap_get(_fundo, i, j);
            
            //Se o atual não for 8 ou 0, tem colisão
            if (_atual != 8 && _atual != 0)
            {
                //Aqui eu coloco um tile de colisão
                //Na camada de colisão
                tilemap_set(_colisao, _tile, i, j);
                
            }
            
        }
    }
    
}