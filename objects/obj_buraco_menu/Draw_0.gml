/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor
//Vou me desenhar
draw_self();

//definindo a minha fonte
draw_set_font(fnt_buracos);
//Ajustando o alinhamento do meu textículo
draw_set_halign(1);
draw_set_valign(1);
//Eu vou desenhar o meu textículo
draw_text(x, bbox_top - 10, texto);
//Resetando a minha fonte
draw_set_font(-1);
draw_set_halign(-1);
draw_set_valign(-1);
