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