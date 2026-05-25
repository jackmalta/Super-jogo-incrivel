/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//Convertendo a largura da sprite em escala relativa ao tamanho da sprite da sombra
var _sombra_larg = sprite_get_width(spr_sombra);
//Pegando a largura da minha sprite
var _larg = sprite_width;

var _esc_x = _larg / _sombra_larg;

draw_sprite_ext(spr_sombra, 0, x, bbox_bottom + marg_sombra, _esc_x * image_xscale, .5, 0, c_black, 0.2);
draw_self();