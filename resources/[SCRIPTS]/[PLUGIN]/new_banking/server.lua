ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

--===============================================
--==          Quick Withdraws                 ==
--==============================================

RegisterServerEvent('bank:fastdep')
AddEventHandler('bank:fastdep', function(base)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local base = 0
    base = xPlayer.getMoney()
    
    if base == nil or base <= 0 then
        TriggerClientEvent('mythic_notify:client:SendAlert',  _source, { type = 'error', text = 'Pas d\'argent en plus!'})
    else

    TriggerClientEvent('mythic_notify:client:SendAlert',  _source, { type = 'inform', text = 'Vous avez déposé 100 $ à la banque.'})
    xPlayer.addAccountMoney('bank', 100)
    xPlayer.removeMoney(100)
    end
end)

   

RegisterServerEvent('bank:fastw')
AddEventHandler('bank:fastw', function(base)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local base = 0
    base = xPlayer.getAccount('bank').money
    
    if base == nil or base <= 0 then
        TriggerClientEvent('mythic_notify:client:SendAlert',  _source, { type = 'error', text = 'Pas d\'argent à la banque!'})
    else

    TriggerClientEvent('mythic_notify:client:SendAlert',  _source, { type = 'inform', text = 'Vous avez retiré 100 $ de votre compte.'})   
    xPlayer.addMoney(100)
    xPlayer.removeAccountMoney('bank', 100) 
    end
end)

RegisterServerEvent('bank:fastwt')
AddEventHandler('bank:fastwt', function(base)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local base = 0
    base = xPlayer.getAccount('bank').money
    
    if base == nil or base <= 0 then
        TriggerClientEvent('mythic_notify:client:SendAlert',  _source, { type = 'error', text = 'Pas d\'argent à la banque!'})
    else
    
    TriggerClientEvent('mythic_notify:client:SendAlert',  _source, { type = 'inform', text = 'Vous avez retiré 200 $ de votre compte.'})    
    xPlayer.addMoney(200)
    xPlayer.removeAccountMoney('bank', 200) 
    end

end)

--================================================
--==          Quick Withdraw Events -End-     --==  
--================================================


RegisterServerEvent('bank:deposit')
AddEventHandler('bank:deposit', function(amount)
    local _source = source

    local xPlayer = ESX.GetPlayerFromId(_source)
    if amount == nil or amount <= 0 then
        TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = 'Montant invalide!'})
    else
        if amount > xPlayer.getMoney() then
            amount = xPlayer.getMoney()
        end
        xPlayer.removeMoney(amount)
        xPlayer.addAccountMoney('bank', tonumber(amount))
    end
end)

RegisterServerEvent('bank:withdraw')
AddEventHandler('bank:withdraw', function(amount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local base = 0
    amount = tonumber(amount)
    base = xPlayer.getAccount('bank').money
    if amount == nil or amount <= 0 then
        TriggerClientEvent('mythic_notify:client:SendAlert',  _source, { type = 'error', text = 'Montant invalide!'})
    else
        if amount > base then
            amount = base
        end
        xPlayer.removeAccountMoney('bank', amount)
        xPlayer.addMoney(amount)

    end
end)


RegisterServerEvent('bank:balance')
AddEventHandler('bank:balance', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
  
    balance = ESX.Math.GroupDigits(xPlayer.getAccount('bank').money)
    TriggerClientEvent('currentbalance1', _source, balance)

end)

RegisterServerEvent('bank:transfer')
AddEventHandler('bank:transfer', function(to, amountt)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local zPlayer = ESX.GetPlayerFromId(to)
    local balance = 0
    if zPlayer ~= nil and GetPlayerEndpoint(to) ~= nil then
        balance = xPlayer.getAccount('bank').money
        zbalance = zPlayer.getAccount('bank').money

        if tonumber(_source) == tonumber(to) then
            TriggerClientEvent('mythic_notify:client:SendAlert',  _source, { type = 'error', text = 'Vous ne pouvez pas vous transférer d\'argent!'})
        else
            if balance <= 0 or balance < tonumber(amountt) or tonumber(amountt) <= 0 then
                    TriggerClientEvent('mythic_notify:client:SendAlert',  _source, { type = 'error', text = 'Vous n\'avez pas d\'argent à transférer!'})
            else
                xPlayer.removeAccountMoney('bank', tonumber(amountt))
                zPlayer.addAccountMoney('bank', tonumber(amountt))

                TriggerClientEvent('mythic_notify:client:SendAlert',  _source, { type = 'error', text = 'Vous avez fait le transfert!'})

                TriggerClientEvent('mythic_notify:client:SendAlert',  to, { type = 'inform', text = 'L\'argent vous a été transféré!'})

            end

        end
    end

end)
