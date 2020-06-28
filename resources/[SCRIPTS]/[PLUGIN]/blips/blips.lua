
	local blips = {
    --TATOOS
    {title="Salon de Tattouage", colour=1, id=75, x=1322.6, y=-1651.9, z=51.2},
    {title="Salon de Tattouage", colour=1, id=75, x=-1153.6, y=-1425.6, z=4.9},
    {title="Salon de Tattouage", colour=1, id=75, x=322.1, y=180.4, z=103.5},
    {title="Salon de Tattouage", colour=1, id=75, x=-3170.0, y=1075.0, z=20.8},
    {title="Salon de Tattouage", colour=1, id=75, x=1864.6, y=3747.7, z=33.0},
    {title="Salon de Tattouage", colour=1, id=75, x=-293.7, y=6200.0, z=31.4},

    --PHARMACIE
    {title="Pharmacie", colour=1, id=403, x = 68.71, y = -1569.78, z = 28.59},
    {title="Pharmacie", colour=1, id=403, x = 98.45, y = -225.41, z = 53.64},
    {title="Pharmacie", colour=1, id=403, x = 591.24, y = 2744.42, z = 41.04},
    {title="Pharmacie", colour=1, id=403, x = 318.5932, y = -1077.0811, z = 28.48},
    {title="Pharmacie", colour=1, id=403, x = 213.69, y = -1835.14, z = 26.56},
    {title="Pharmacie", colour=1, id=403, x = -3157.74, y = 1095.24, z = 19.85},  

    --BIJOUTERIE
    {title="Bijouterie", colour=46, id=617, x = -622.04, y = -230.74, z = 38.05},   

    --TIG
     {title="Zone T.I.G", colour=37, id=464, x = 158.25, y = -993.24, z = 29.34}, 
     
     --Masque pos 
     {title="Magasin de masque", colour=37, id=362, x = -1338.129, y = -1278.200, z = 3.872},  
     {title="Magasin de masque", colour=37, id=362, x = 1894.343, y = 3714.61, z = 32.764},  

     -- UNICORN
     {title="Unicorn", colour=27, id=279, x = 122.87312316895,y = -1289.0061035156,z = 35.009784698486},


}

Citizen.CreateThread(function()

    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 0.9)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
	    BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)


