/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor
roda_estado();





//Checando se o player esta olhando na minha direção
//TODO arrumar a referência
var _player_dir = obj_ameba.dir;
var _player_olha = round(point_direction(obj_ameba.x, obj_ameba.y, x, y) / 90);

//Se ele esta olhando na minha direção, eu vou diminuir a distancia do olho
if (_player_dir == _player_olha)
{
    
    dist_olho = lerp(dist_olho, 0, 0.1);
    
    //Se o player esta me olhando continuamente, eu vou sumir
    timer_timido--;
}
else
{
    //Player parou de olhar, eu fico sem vergonha
    timer_timido = tempo_timido;
    //Aumentando a distância que ele vai olhar para o player
    if (estado_atual == estado_idle)
    {
        dist_olho = lerp(dist_olho, dist_olho_max, 0.1);
    }
}



