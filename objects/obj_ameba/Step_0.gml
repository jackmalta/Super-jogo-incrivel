/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

event_inherited();

roda_estado();


timer_perigo--;
if (timer_perigo <= 0)
{
    var _obj = obj_olho;
    var _chance = random(10);
    if (_chance > 8)
    {
        _obj = obj_tentaculo;
    }
    //cria_perigo(_obj, 4);
    
    timer_perigo = tempo_perigo;
}

ajusta_direcao();

if (keyboard_check_pressed(ord("R"))) room_restart();