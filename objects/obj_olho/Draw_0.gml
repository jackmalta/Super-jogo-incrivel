/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//Desenhando o fundo do olho
draw_sprite(spr_olho_base, 0, x, y);

var _larg   = sprite_width;
var _alt    = sprite_height;

var _x      = x + _larg/2;
var _y      = y + _alt/2;

//TODO arruma a referência
var _alvo_x = obj_ameba.x;
var _alvo_y = obj_ameba.y;

var _dir_mouse = point_direction(_x, _y, _alvo_x, _alvo_y);

//Só vou olhar na direção do player, se, somente se, eu não estou abrindo
if (estado_atual != estado_abrindo)
{
    _x += lengthdir_x(dist_olho, _dir_mouse);
    _y += lengthdir_y(dist_olho, _dir_mouse);
}

//Desenhando a bolinha do olho
draw_sprite(spr_olho_pupila, 0, _x, _y);

draw_self();

var _txt_sprite = sprite_get_name(sprite_index);

//draw_text(x, y - 30, txt_estado);