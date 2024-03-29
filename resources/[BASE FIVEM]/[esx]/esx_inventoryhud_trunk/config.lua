-------------------------------------------------
--Created and modified by Dominic Stanfford 
---aka Manta aka Anthony Maertens
-------------------------------------------------------

local Keys = {
    ["ESC"] = 322,
    ["F1"] = 288,
    ["F2"] = 289,
    ["F3"] = 170,
    ["F5"] = 166,
    ["F6"] = 167,
    ["F7"] = 168,
    ["F8"] = 169,
    ["F9"] = 56,
    ["F10"] = 57,
    ["~"] = 243,
    ["1"] = 157,
    ["2"] = 158,
    ["3"] = 160,
    ["4"] = 164,
    ["5"] = 165,
    ["6"] = 159,
    ["7"] = 161,
    ["8"] = 162,
    ["9"] = 163,
    ["-"] = 84,
    ["="] = 83,
    ["BACKSPACE"] = 177,
    ["TAB"] = 37,
    ["Q"] = 44,
    ["W"] = 32,
    ["E"] = 38,
    ["R"] = 45,
    ["T"] = 245,
    ["Y"] = 246,
    ["U"] = 303,
    ["P"] = 199,
    ["["] = 39,
    ["]"] = 40,
    ["ENTER"] = 18,
    ["CAPS"] = 137,
    ["A"] = 34,
    ["S"] = 8,
    ["D"] = 9,
    ["F"] = 23,
    ["G"] = 47,
    ["H"] = 74,
    ["K"] = 311,
    ["L"] = 182,
    ["LEFTSHIFT"] = 21,
    ["Z"] = 20,
    ["X"] = 73,
    ["C"] = 26,
    ["V"] = 0,
    ["B"] = 29,
    ["N"] = 249,
    ["M"] = 244,
    [","] = 82,
    ["."] = 81,
    ["-"] = 84,
    ["LEFTCTRL"] = 36,
    ["LEFTALT"] = 19,
    ["SPACE"] = 22,
    ["RIGHTCTRL"] = 70,
    ["HOME"] = 213,
    ["PAGEUP"] = 10,
    ["PAGEDOWN"] = 11,
    ["DELETE"] = 178,
    ["LEFT"] = 174,
    ["RIGHT"] = 175,
    ["TOP"] = 27,
    ["DOWN"] = 173,
    ["NENTER"] = 201,
    ["N4"] = 108,
    ["N5"] = 60,
    ["N6"] = 107,
    ["N+"] = 96,
    ["N-"] = 97,
    ["N7"] = 117,
    ["N8"] = 61,
    ["N9"] = 118
}

Config = {}

Config.CheckOwnership = false -- If true, Only owner of vehicle can store items in trunk.
Config.AllowPolice = true -- If true, police will be able to search players' trunks.

Config.Locale = "fr"

Config.OpenKey = Keys["L"]

-- LLimite sur soi 30kg
Config.Limit = 30000

-- Default weight for an item:
-- weight == 0 : The item do not affect character inventory weight
-- weight > 0 : The item cost place on inventory
-- weight < 0 : The item add place on inventory. Smart people will love it.
Config.DefaultWeight = 100

Config.localWeight = {
            acetone = 200,
            acier = 10,
           baguette = 100,
           bait = 10,
           bandage = 50,
           beer = 50,
           billet = 50,
           billet_pooch = 100,
           biereblonde = 100,
           birerbrune = 100,
           bierenoel = 100,
           blowpipe = 50,
           blowtorch = 50,
           boitethon = 50,
           bolcacahuetes = 20,
           bolchips = 20,
           bolnoixcajou = 20,
           bolpistache = 20,
           bread = 100,
           bigmac = 20,
           cagoule = 20,
           carbon = 10,
           carokit = 20,
           carotool = 20,
           cchip = 1,
           champagne = 20,
           chips = 20,
           chocolate = 20,
           cocacola = 20,
           clothe = 100,
           coffe = 20,
           contrat = 10,
           coke = 50,
           coke_pooch = 100,
           copper = 50,
           crack = 50,
           crack_pooch = 100,
           crevette = 50,
           cupcake = 20,
           cutted_wood = 100,
           diamond = 100,
           douille = 50,
           drill = 200,
           drpepper = 20,
           ecstasy = 50,
           ecstasy_pooch = 100,
           essence = 100,
           fabric = 50,
           fish = 20,
           fishingrod = 50,
           fixkit = 20,
           flashlight = 50,
           gazbottle = 100,
           gintonic = 20,
           gitanes = 50,
           gold = 100,
           golem = 20,
           grandcru = 100,
           grapperaisin = 100,
           hamburger = 20,
           houblon = 50,
           ice = 5,
           iron = 50,
           jager = 20,
           jagerbomb = 20,
           jagercerber = 20,
           jewels = 20,
           jus_raisin = 50,
           ketamine = 50,
           ketamine_pooch = 100,
           lingot = 100,
           lithium = 200,
           lockpick = 10,
           lsd = 3,
           lsd_pooch = 30,
           malbora = 50,
           malt = 50,
           medikit = 20,
           menthe = 5,
           methlab = 200,
           meth = 50,
           meth_pooch = 70,
           metreshooter = 20,
           milk = 20,
           mixapero = 20,
           mojito = 20,
           opium = 50,
           opium_pooch = 100,
           orge = 50,
           packaged_chicken = 20,
           packaged_plank = 50,
           patate = 50,
           sacpatate = 100,
           pepite = 100,
           pepite_raffin = 100,
           packaged_plank = 100,
           petrol = 100,
           petrol_raffin = 100,
           piluleoubli = 10,
           pizza = 20,
           poudre = 50,
           powerade = 20,
           protein_shake = 20,
           raisin = 50,
           raspberry = 50,
           repairkit = 50,
           rhumcoca = 20,
           rhumfruit = 20,
           rope = 50,
           run_avocat_final = 50,
           run_avocat_item = 50,
           sacbillets = 200,
           samoussa_crevette = 50,
           sandwich = 20,
           saucisson = 20,
           saumon = 50,
           saumon_fume = 50,
           silencieux = 20,
           slaughtered_chicken = 50,
           souptomate = 100,
           sportlunch = 20,
           stone = 200,
           tabacblond = 50,
           tabacblondsec = 50,
           tabacbrun = 50,
           tabacbrunsec = 50,
           teqpaf = 20,
           thon = 50,
           tomate = 50,
           tunerchip = 100,
           viande = 50,
           vine = 50,
           vodka = 20,
           vodkaenergy = 20,
           vodkafruit = 20,
           washed_stone = 200,
           water = 20,
           weed = 50,
           weed_pooch = 100,
           whisky = 100,
           whiskycoca = 20,
           wine = 100,
           wood = 100,
           ble = 50,
           wool = 40,
       
        burger = 20,  		--30
        icetea = 20,		--30
        cola = 2,		--30
        redbull = 20,		--30
        lighter = 2,		--30
        phone = 20,		--30
        limonade = 20,		--30
        martini = 20,		--30
        rhum = 20,		--30
        soda = 20,		--30
        tequila = 20,		--30
        
         gps = 50,		
         handcuff = 20,			
         headbag = 30,		
         jumelles = 30,
         key = 20,
         mask = 50,
         rasperry = 100,
        energy = 20,
        anti = 50,
        turtle = 200, 
        turtle_meat = 100, 
        meat = 100, 
    
        contract = 50,
        coyotte = 50,
        poolreceipt = 50,
        bucket = 100,
        fish = 50,
        farine = 50,
        gazbottle = 200,	
        fixtool = 50,		
        carotool = 50,	
        blowpipe = 50,	
        blowtorch = 50,	
        fixkit = 20,		
        carokit = 20,		
        bandage = 20,		
        medikit = 20,		
        croquettes = 30,	
        jusfruit = 20,				
        brolly = 30,		
        bong = 60,		
        rose = 20,			
        notepad = 10,		
        defibrillateur = 30,
        poubelle = 100,
        latex = 150,
        borracha = 100,
        borracha_embalada = 50,
        drill = 120,
        gazbottle = 300,
        
        clip = 50,
        advanced_scope = 50,
        compansator = 50,
        flashlight = 50,
        armor = 100,
        barrel = 50,
        fmj = 30,
        hollow = 20,
        tracer_clip = 50,
        lazer_scope = 50,
        incendiary = 50,
        metreshooter = 20,
        scope = 50,
        silent = 50,
        very_extended_magazine = 90,
        nightvision_scope = 90,
        extended_magazine = 50,
        thermal_scope = 50,
        pecas = 20,
        grip = 50,
        c4_bank = 100,
        lowrider = 50,
        nurek = 20,
        yusuf = 50,
        alarm1 = 50,
        alarm2 = 50,
        alarm3 = 50,
        alarminterface = 20,
        hammerwirecutter = 30,
        highrim = 30,
        jammer = 10,
        lowradio = 10,
        stockrim = 50,
        unlockingtool = 50,
        
           WEAPON_NIGHTSTICK       = 50,
           WEAPON_STUNGUN          = 100,
           WEAPON_FLASHLIGHT       = 50,
           weapon_battleaxe        = 100,
           weapon_petrolcan        = 100,
           weapon_switchblade      = 100,
           WEAPON_FLAREGUN         = 100,
           WEAPON_MACHETE          = 100,
           WEAPON_FLARE            = 100,
           weapon_vintagepistol    = 50,
           WEAPON_COMBATPISTOL     = 100,
           WEAPON_HEAVYPISTOL      = 100,
           WEAPON_ASSAULTSMG       = 100,
           WEAPON_COMBATPDW        = 100,
           WEAPON_BULLPUPRIFLE     = 100,
           WEAPON_PUMPSHOTGUN      = 100,
           WEAPON_BULLPUPSHOTGUN   = 100,
           WEAPON_CARBINERIFLE     = 100,
           WEAPON_ADVANCEDRIFLE    = 100,
           WEAPON_MARKSMANRRIFLE   = 100,
           WEAPON_SNIPERRIFLE      = 100,
           WEAPON_FIREEXTINGUISHER = 100, 
           GADGET_PARACHUTE        = 100,
           WEAPON_BAT              = 100,
           WEAPON_BALL             = 100,
           WEAPON_PISTOL           = 100,
           black_money = 1, -- poids pour un argent
        
       }

Config.VehicleLimit = {
    [0] = 50000, --Compact
[1] = 60000, --Sedan
[2] = 70000, --SUV
[3] = 45000, --Coupes
[4] = 50000, --Muscle
[5] = 40000, --Sports Classics
[6] = 40000, --Sports
[7] = 40000, --Super
[8] = 10000, --Motorcycles
[9] = 100000, --Off-road
[10] = 200000, --Industrial
[11] = 160000, --Utility
[12] = 160000, --Vans
[13] = 0, --Cycles
[14] = 200000, --Boats
[15] = 40000, --Helicopters
[16] = 40000, --Planes
[17] = 100000, --Service
[18] = 120000, --Emergency
[19] = 160000, --Military
[20] = 200000, --Commercial
[21] = 0, --Trains
}

Config.VehiclePlate = {
    taxi = "TAXI"
}
