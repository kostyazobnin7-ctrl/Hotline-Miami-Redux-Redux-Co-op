/// net_kills_fill()
// КЛИЕНТ: убийства считает хост; дополнить killx/killy нулями до global.kills,
// иначе экран очков (scrCountMobilityScore) падает «not an array».
for (var k = 0; k < global.kills; k += 1)
{
    if (!is_array(global.killx) || k >= array_length_1d(global.killx))
    {
        global.killx[k] = 0;
    }
    if (!is_array(global.killy) || k >= array_length_1d(global.killy))
    {
        global.killy[k] = 0;
    }
}
