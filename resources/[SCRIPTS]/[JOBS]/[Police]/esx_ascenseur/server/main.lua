ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


  ESX.RegisterUsableItem('badgepolice', function(source)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
  
    TriggerClientEvent('jackMarker:onBadge', _source)
    -- TriggerClientEvent('esx:showNotification', _source, 'Carte magnétique utiliser')
  end)