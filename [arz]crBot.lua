script_name('[arz]crBot')
script_version(3.00)

require 'moonloader'
requests = require 'requests'
sampev = require'samp.events'
imgui = require 'imgui'
encoding = require("encoding"); encoding.default = 'CP1251'; u8 = encoding.UTF8  
json = {
    defPath = getWorkingDirectory()..'/config/',
    save = function(t,path) 
        if not path:find('/') or not path:find('\\') then;  path = json.defPath..path end
        t = (t == nil and {} or (type(t) == 'table' and t or {}))
        local f = io.open(path,'w');    f:write(encodeJson(t) or {});   f:close()
    end,
    load = function(t,path) 
        if not path:find('/') or not path:find('\\') then;  path = json.defPath..path end
        if not doesFileExist(path) then;    json.save(t,path);  end
        local f = io.open(path,'r+');   local T = decodeJson(f:read('*a')); f:close()
        return T
    end
}
j = json.load({
    tg = {
        token = '123456:qwerty',
        chat_id = 123123123,
    },
    lavki = {
        colors = {
            ['редактирует'] = {1,0,0,1},
            ['продаёт'] = {0,1,0,1},
            ['покупает'] = {0,1,1,1},
            ['продаёт и покупает'] = {1,0,1,1},
            ['свободная лавка'] = {1,1,1,1},
        },
        coordmaster = {
            step = 5,
            delay = 69,
        },
    },
    bot = {
        delay = 10,
        coords = {}, 
        items = {},
    }
},'[arz]crBot.json')
crItems = json.load({},'[arz]crBot_Items.json')

lavki = {
    lavki = {
        {imgui=imgui.ImVec2(125-10,50),pos={1133.8615722656, -1515.1368408203}},
        {imgui=imgui.ImVec2(125-30,50),pos={1137.6138916016, -1513.7829589844}},
        {imgui=imgui.ImVec2(125-30-40,60),pos={1147.3572998047, -1507.4227294922}},
        {imgui=imgui.ImVec2(125+10,50),pos={1122.9432373047, -1515.4566650391}},
        {imgui=imgui.ImVec2(125+30,50),pos={1118.6518554688, -1513.9273681641}},
        {imgui=imgui.ImVec2(125+30+40,60),pos={1109.0301513672, -1506.6022949219}},
        {imgui=imgui.ImVec2(125+30,90),pos={1116.8221435547,-1502.4484863281}},
        {imgui=imgui.ImVec2(125+30,90+20),pos={1116.8892822266,-1493.3395996094}},
        {imgui=imgui.ImVec2(125+30,90+40),pos={1116.8883056641,-1488.8804931641}},
        {imgui=imgui.ImVec2(125+30,90+60),pos={1116.8883056641,-1484.2327880859}},
        {imgui=imgui.ImVec2(125+30,90+80),pos={1116.8859863281,-1475.4976806641}},
        {imgui=imgui.ImVec2(125+30+40,100+40-5),pos={1107.1037597656,-1478.1535644531}},
        {imgui=imgui.ImVec2(125+30+40,100+60-5),pos={1108.6922607422,-1473.6702880859}},
        {imgui=imgui.ImVec2(125-30-40,100+60-5),pos={1150.3121337891,-1478.5914306641}},
        -- {imgui=imgui.ImVec2(125-30-40,100+60-5),pos={1148.5478515625,-1473.7545166016}},
        {imgui=imgui.ImVec2(125+30+40,100+80),pos={1110.6108398438,-1465.3223876953}},
        {imgui=imgui.ImVec2(125+30+40,100+80+20),pos={1110.6101074219,-1460.9644775391}},
        {imgui=imgui.ImVec2(125+30+40,100+80+40),pos={1110.6107177734,-1456.3336181641}},
        {imgui=imgui.ImVec2(125+30+40,100+80+60),pos={1110.6134033203,-1449.4990234375}},
        {imgui=imgui.ImVec2(125+30+40,100+80+80),pos={1110.6119384766,-1442.9114990234}},
        {imgui=imgui.ImVec2(125+30+40,100+80+100),pos={1110.6101074219,-1438.4370117188}},
        {imgui=imgui.ImVec2(125+30+40,100+80+120),pos={1110.6103515625,-1433.7307128906}},
        {imgui=imgui.ImVec2(125-30-40,100+80),pos={1148.5134277344,-1473.6695556641}},
        {imgui=imgui.ImVec2(125-30-40,100+80+20),pos={1146.6704101563,-1465.4056396484}},
        {imgui=imgui.ImVec2(125-30-40,100+80+40),pos={1146.6697998047,-1460.9720458984}},
        {imgui=imgui.ImVec2(125-30-40,100+80+60),pos={1146.6704101563,-1456.4584960938}},
        {imgui=imgui.ImVec2(125-30-40,100+80+80),pos={1146.6704101563,-1442.8240966797}},
        {imgui=imgui.ImVec2(125-30-40,100+80+100),pos={1146.6704101563,-1438.4714355469}},
        {imgui=imgui.ImVec2(125-30-40,100+80+120),pos={1146.6483154297,-1433.8829345703}},
        {imgui=imgui.ImVec2(125+10,100+80+20),pos={1125.6596679688,-1460.8344726563}},
        {imgui=imgui.ImVec2(125+10,100+80+20+20),pos={1125.6607666016,-1456.4132080078}},
        {imgui=imgui.ImVec2(125+10,100+80+20+40),pos={1125.6608886719,-1451.9625244141}},
        {imgui=imgui.ImVec2(125+10,100+80+20+60),pos={1125.6491699219,-1447.2241210938}},
        {imgui=imgui.ImVec2(125+10,100+80+20+80),pos={1125.6608886719, -1442.8026123047}},
        {imgui=imgui.ImVec2(125+10,100+80+20+100),pos={1125.6608886719, -1438.3663330078}},
        {imgui=imgui.ImVec2(125-10,100+80+20),pos={1132.1005859375,-1460.8640136719}},
        {imgui=imgui.ImVec2(125-10,100+80+20+20),pos={1132.1091308594,-1456.4731445313}},
        {imgui=imgui.ImVec2(125-10,100+80+20+40),pos={1132.1005859375,-1451.8995361328}},
        {imgui=imgui.ImVec2(125-10,100+80+20+60),pos={1132.109375,-1447.3287353516}},
        {imgui=imgui.ImVec2(125-10,100+80+20+80),pos={1132.1014404297,-1442.8031005859}},
        {imgui=imgui.ImVec2(125-10,100+80+20+100),pos={1132.1007080078,-1438.1531982422}},
    },
    window = imgui.ImBool(false),
    colors = {},
    coordmaster = {
        work = false,
        step = imgui.ImFloat(j.lavki.coordmaster.step),
        delay = imgui.ImInt(j.lavki.coordmaster.delay),
        buyingClock = 0,
    },
}
for k,v in pairs(j.lavki.colors) do
    lavki.colors[k] = imgui.ImFloat4(unpack(v))
end

bot = {
    listItems = false,
    --
    viewItems = imgui.ImBool(false),
    parsing = false,
    --
    lavka = imgui.ImBool(false),
    --
    work = false,
    bool = imgui.ImBool(false),
    delay = imgui.ImInt(j.bot.delay),
    int = 0,
    --
    search = imgui.ImBuffer(256),
    int = imgui.ImInt(1),
    cost = imgui.ImInt(10),
    buy = imgui.ImBool(false),
    --
    td = {
        int = 0,
        page = 0,
        shop = {0,0, 0,0, 0,0},
        items = {},
    },
}

tg = {
    window = imgui.ImBool(false),
    token = imgui.ImBuffer(j.tg.token,256),
    chat_id = imgui.ImInt(j.tg.chat_id),
}

window,setPos = imgui.ImBool(false),{0,0}

active = u8'О скрипте'
font = renderCreateFont('Arial',10,0x4)
function main()
    while not isSampAvailable() do wait(0) end
    -- while not sampIsLocalPlayerSpawned() do wait(0) end
    update = nil

    sampRegisterChatCommand('crb',function() window.v = not window.v end)

    for k,v in ipairs(lavki.lavki) do
        v.text = {
            id = 0,
            text ='свободная лавка!',
        }
        v.buy = false
        v.render = false
    end

    asyncHttpRequest('GET',
        'https://raw.githubusercontent.com/Affarsi/CR_bot/main/update.lua',nil,function(r)
        r.text = u8:decode(r.text)
        print(r.text)
        local f,e = load('return {'..r.text..'}')
        if e == nil then
            for k,v in pairs(f()) do
                if v.version > tonumber(thisScript().version) then
                   downloadUrlToFile(
                        'https://raw.githubusercontent.com/Affarsi/CR_bot/main/%5Barz%5DcrBot.lua',
                        thisScript().path,
                        function(id,status,_,_)
                            if status == 58 then
                                sampAddChatMessage('{0CC726}Успешно{cccccc} установлено обновление! Актуальаня версия загружена!')
                                thisScript():reload()
                            end
                        end
                    )
                end
            end
        else
            print(e)
            sampAddChatMessage('{CA2222}Ошибка получения обновлений на скрипт!')
        end
        end,nil
    )
    

    while true do wait(0)
        imgui.Process = window.v or bot.viewItems.v
        MY_ID = select(2,sampGetPlayerIdByCharHandle(PLAYER_PED))
        MY_NICK = sampGetPlayerNickname(MY_ID)
        MYPOS = {getCharCoordinates(PLAYER_PED)}
        sw,sh = getScreenResolution()

        if bot.viewItems.v and not bot.bool.v then; bot.viewItems.v = false;    end

-- anim.file PED,anim.name FALL_FALL[1130]
        for k,v in ipairs(lavki.lavki) do
            if v.text.text == 'свободная лавка!' and v.render then
                local _,x,y,z = convert3DCoordsToScreenEx(v.pos[1],v.pos[2],MYPOS[3])
                if z > 1 then
                    local xx,yy = convert3DCoordsToScreen(unpack(MYPOS))
                    renderFontDrawTextFromAlign(font,'Свободная лавка!',x,y,0xff28ED28,2)
                end
                if lavki.coordmaster.buyingClock ~= 0 and v.buy and getDistanceBetweenCoords3d(MYPOS[1], MYPOS[2], MYPOS[3],v.pos[1],v.pos[2],MYPOS[3]) <= 1.5 and not lavki.coordmaster.work  then
                    if os.clock()-lavki.coordmaster.buyingClock <= 10 then
                        if sampIsDialogActive() and sampGetDialogText():find('^%{%x+%}Стоимость аренды лавки%: %{%x+%}%$%d+') then
                            wait(1)
                            sampCloseCurrentDialogWithButton(1)
                        end
                        sendSyncKey('ALT')
                        wait(10)
                    else
                        lavki.coordmaster.work = false
                        lavki.coordmaster.buyingClock = 0
                        v.buy = false
                    end
                end
            end
        end

        for IDTEXT = 0, 2048 do
            if sampIs3dTextDefined(IDTEXT) then
                local text, _, posX, posY, posZ, _, _, _, _ = sampGet3dTextInfoById(IDTEXT)
                -- posZ = posZ - 2.1 !
                for k,v in ipairs(lavki.lavki) do
                    local d = getDistanceBetweenCoords3d(posX, posY, posZ,v.pos[1],v.pos[2],posZ) 
                    if d <= 1.9 and (text:find("^%w+_%w+ .+ товар$") or text:find('редактирует')) then
                        v.text.id = IDTEXT
                        v.text.text = (text):gsub('%{%x+%}','')
                    elseif d <= 1.9 and v.text.id == IDTEXT and not (text:find("^%w+_%w+ .+ товар$") or text:find('редактирует')) then
                        if v.buy and not lavki.coordmaster.work and lavki.coordmaster.buyingClock == 0 then
                            lavki.coordmaster.buyingClock = os.clock()
                            lavki.coordmaster.work = true
                            coordMaster(v.pos[1],v.pos[2],(posZ-2.1))
                        end
                        if v.render then 
                            sendTelegramMessage('Лавка(%s) освободилась!',k)
                        end
                        v.text.text = 'свободная лавка!'
                        v.text.id = 0
                    end
                end

            end
        end

        if bot.td.page ~= 0 and (not sampTextdrawIsExists(bot.td.page) or sampTextdrawGetString(bot.td.page) ~= gameConvertText('LD_SРАС:whitе','rustogame') ) then
            bot.td = {
                int = 0,
                page = 0,
                shop = {0,0, 0,0, 0,0},
                items = {},
            }
        end
        bot.td.items = {}
        for id = 1,3000 do
            if sampTextdrawIsExists(id) then
                local x, y = sampTextdrawGetPos(id)
                local xx, yy = convertGameScreenCoordsToWindowScreenCoords(sampTextdrawGetPos(id))
                local model, rotX, rotY, rotZ, zoom, clr1, clr2 = sampTextdrawGetModelRotationZoomVehColor(id)
                local box, boxColor, sizeX, sizeY = sampTextdrawGetBoxEnabledColorAndSize(id)
                local letterX,letterY,letterColor = sampTextdrawGetLetterSizeAndColor(id)
                local shadow,colorShadow = sampTextdrawGetShadowColor(id)
                local outline,outlineColor  = sampTextdrawGetOutlineColor(id)
                local text = sampTextdrawGetString(id)

                local td = bot.td

                if (text == 'SHOP' or text == gameConvertText('МАГАЗЙН', 'rustogame')) then
                    td.shop[1],td.shop[2] = x,y
                end

                if td.shop[1] ~= 0 and (text == 'INVENTORY' or text == gameConvertText('ЙНВЕНТАРЬ', 'rustogame')) then
                    td.shop[3],td.shop[4] = x,y
                end

                if td.shop[1] ~= 0 and td.shop[3] ~= 0 and
                    x >= (td.shop[1]-10) and x <= (td.shop[3]-10) and
                    model ~= 0 and model ~= 1649
                then
                    -- renderDrawPolygon(xx,yy,10,10,10,0,-1)
                    table.insert(td.items,{
                        id = id,
                        x=x,
                        y=y
                    })
                    -- if not bot.bool.v and bot.message.v and bot.td.int == 0 then
                    --     sampSendClickTextdraw(bot.td.items[1].id)
                    --     bot.td.int = 1
                    -- end
                end

                if td.shop[3] ~= 0 and
                    x >= (td.shop[3]-100) and x <= (td.shop[3]-10) and
                    text == '>' 
                then
                    td.shop[5] = x
                    td.shop[6] = y
                end
                if td.shop[5] ~= 0 and
                    x >= (td.shop[5]-20) and x <= (td.shop[5]) and
                    y >= (td.shop[6]-10) and
                    text == gameConvertText('LD_SРАС:whitе','rustogame') 
                then
                    td.page = id
                end

                if bot.bool.v and lavkaOpen() and (text == gameConvertText('СКУПКА','rustogame')) then
                    sampSendClickTextdraw(id-1)
                    wait(100)
                end

            end
        end

    end
end

function lavkaOpen()
    return bot.td.page ~= 0
end

local arial = nil
function imgui.BeforeDrawFrame()
    if arial == nil then
        arial = {}
        for i = 15,23 do
            arial[i] = imgui.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(0x14)..'/Arial.ttf',i,nil,imgui.GetIO().Fonts:GetGlyphRangesCyrillic())
        end
    end
end

function ins(data) return require('inspect').inspect(data) end

function imgui.OnDrawFrame()
    imgui.ShowCursor = true
    if isKeyDown(VK_RBUTTON) then
        imgui.ShowCursor = false
    end

    if bot.viewItems.v then
        imgui.SetNextWindowSize(imgui.ImVec2(450,200),2)
        imgui.SetNextWindowPos(imgui.ImVec2(sw/1.3-450/2,sh/2-200/2),2)
        imgui.Begin(u8'Предметы для скупки',bot.viewItems)
        imgui.Columns(2,'items',true)
        for k,v in ipairs(j.bot.items) do
            imgui.Text(u8(v.item))
            imgui.TextQuestion(nil,u8(v.item))
            imgui.NextColumn()
            local int,cost,buy = imgui.ImInt(v.int),imgui.ImInt(v.cost),imgui.ImBool(v.buy)
            if imgui.Checkbox('buy##'..k,buy) then
                v.buy = buy.v
                json.save(j,'[arz]crBot.json')
            end
            if buy.v then
                imgui.SameLine()
                imgui.PushItemWidth(75)
                if imgui.InputInt('$##'..k,cost,0,0) then
                    v.cost = cost.v
                    json.save(j,'[arz]crBot.json')
                end
                imgui.SameLine()
                if imgui.InputInt(u8'кол-во##'..k,int,0,0) then
                    v.int = int.v
                    json.save(j,'[arz]crBot.json')
                end
                imgui.PopItemWidth(2)
                imgui.SameLine()
                if imgui.Button('remove##'..k) then
                    table.remove(j.bot.items,k)
                    json.save(j,'[arz]crBot.json')
                end
            end
            imgui.NextColumn()
        end
        imgui.Columns()
        imgui.End()
    end

   if window.v then
        -- imgui.SetNextWindowSize(imgui.ImVec2(150,85),1)
        imgui.SetNextWindowPos(imgui.ImVec2(sw/3.5,sh/3.5), imgui.Cond.FirstUseEver)
        imgui.Begin(u8'цыганский барон у цр-crBot | '..thisScript().version ,window,32+64+1)

        imgui.NewLine()

        local b = {
            u8'О скрипте',
            u8'Телеграм',
            u8'Скупка вещей',
            u8'Лавки',
        }
        imgui.BeginChild('buttons',imgui.ImVec2(150,400),false)
        for k,v in ipairs(b) do
            if imgui.PageButton(active==v,'>',(v),130) then active = v end
            imgui.SetCursorPosY(100*k)
        end
        imgui.EndChild()

        imgui.SameLine()

        imgui.BeginChild('text',imgui.ImVec2(500,400),true)
        imgui.Spacing()

        if active == b[1] then

            imgui.SetCursorPosY(130)

            imgui.PushFont(arial[23])
            imgui.SetCursorPosX(250-imgui.CalcTextSize('script version '..thisScript().version).x/2)
            imgui.Text('script version '..thisScript().version);
            imgui.SetCursorPosX(250-imgui.CalcTextSize('idea-publisher KostLim\t\t').x/2)
            imgui.Text('idea-publisher KostLim'); imgui.SameLine();   if imgui.SmallButton('(profile)##1') then;  os.execute('explorer "https://www.blast.hk/members/269820/"'); end
            imgui.SetCursorPosX(250-imgui.CalcTextSize('developer vespan\t\t').x/2)
            imgui.Text('developer vespan'); imgui.SameLine();   if imgui.SmallButton('(profile)##2') then;  os.execute('explorer "https://www.blast.hk/members/295413/"'); end
            imgui.SetCursorPosX(250-imgui.CalcTextSize('github repository script').x/2)
            if imgui.Button('github repository script') then
                os.execute('explorer "https://github.com/Affarsi/CR_bot"')
            end
            imgui.PopFont()

        elseif active == b[2] then
            imgui.PushItemWidth(440)
            if imgui.InputText('token',tg.token) then; j.tg.token = tg.token.v; json.save(j,'[arz]crBot.json'); end
            if imgui.InputInt('chat_id',tg.chat_id) then; j.tg.chat_id = tg.chat_id.v;  json.save(j,'[arz]crBot.json'); end
            imgui.PopItemWidth(2)

            if imgui.Button('test message',imgui.ImVec2(-1,30)) then
                local r = requests.get('https://api.telegram.org/bot' .. tg.token.v .. '/sendMessage?chat_id=' .. tg.chat_id.v .. '&text='..'[BaronCr] test message!')
                local rj = decodeJson(r.text)
                sampAddChatMessage(rj.ok and '{13E01D}successfull sending!' or ('{D21C1C}error code %s - %s'):format(rj.error_code,rj.description))
            end
                imgui.Text(u8[[
Сообщение приходит..
Когда лавка освободилась(нужно на лавку включить рендер)
Когда скрипт словил лавку
Когда бот нашел определенный предмет в лавке (или когда купил)
Когда бот начал/сделал круг
]])
        elseif active == b[3] then


            if imgui.Checkbox(u8'запустить бота?',bot.bool) then
                bot.int = 1
                bot.td.int = 1
                bot.viewItems.v = true
                lua_thread.create(function()
                    local freeze,nextPage = true,false
                    local c,clock,clockWaitSlots = 1,0,0
                    while bot.bool.v do wait(0)

                        local h = {findAllRandomCharsInSphere(MYPOS[1],MYPOS[2],MYPOS[3],10,true,false)}
                        if h[1] and doesCharExist(h[2]) then
                            setCharCollision(h[2],false)
                        end

                        local t = j.bot.coords[bot.int]
                        if #j.bot.items == 0 then
                            sendTelegramMessage('Были выкуплены все предметы!\nБот отключен')
                            break
                        end

                        if t == nil and clock == 0 then
                            c = c + 1
                            clock = os.clock()
                            bot.int = 1
                            bot.td.int = 1
                            sendTelegramMessage('Был сделан %s круг!\nЖдем %s минут..',c,bot.delay.v)
                        end

                        if clock ~= 0 and ((os.clock()-clock)/60) >= bot.delay.v then
                            clock = 0
                            sendTelegramMessage('Вышло время!\nНачинаю круг..')
                        end

                        if clock == 0 then
                            local d = getDistanceBetweenCoords3d(t.pos[1],t.pos[2],0,MYPOS[1],MYPOS[2],0)
                            if d > 1 then
                                clockWaitSlots = 0
                                bot.td.int = 1
                                setAngle(t.pos[1],t.pos[2],t.pos[3])
                                setGameKeyState(1, -255)
                            else
                                if d <= 0.7 and freeze then
                                    freezeCharPosition(PLAYER_PED,true)
                                    wait(50)
                                    freezeCharPosition(PLAYER_PED,false)
                                    freeze = false
                                end
                                if t.lavka then
                                    -- local selling = false
                                    -- for IDTEXT = 0, 2048 do
                                    --     if sampIs3dTextDefined(IDTEXT) then
                                    --         local text, _, posX, posY, posZ, _, _, _, _ = sampGet3dTextInfoById(IDTEXT)
                                    --         if text:find('продаёт') and getDistanceBetweenCoords3d(posX, posY, 0,MYPOS[1],MYPOS[2],0) <= 2.5 then
                                    --             selling = true
                                    --         end
                                    --     end
                                    -- end
                                    -- if not selling then
                                    --     freeze = true
                                    --     bot.int = bot.int + 1
                                    --     goto s
                                    -- end

                                    if lavkaOpen() and not sampIsDialogActive() then
                                        if clockWaitSlots == 0 then clockWaitSlots = os.clock() end
                                        if #bot.td.items == 0 and os.clock()-clockWaitSlots >= 3 then
                                            freeze = true
                                            bot.int = bot.int + 1
                                            goto s
                                        end

                                        -- sampSendClickTextdraw(bot.td.items[bot.td.int].id)
                                        local b,_ = pcall(function() sampSendClickTextdraw(bot.td.items[bot.td.int].id) end)
                                        if not b then
                                            clockWaitSlots = 0
                                            sampSendClickTextdraw(bot.td.page)
                                            wait(3000)
                                            if #bot.td.items == 0 then
                                                sampSendClickTextdraw(0xffff)
                                                bot.int = bot.int + 1
                                                freeze = true
                                            end
                                            bot.td.int = 1
                                        end
                                        wait(150)

                                    elseif not lavkaOpen() then
                                        if sampIsDialogActive() then wait(1) sampCloseCurrentDialogWithButton(0) end
                                        sendSyncKey('ALT')
                                        wait(10)
                                    end
                                else
                                    freeze = true
                                    bot.int = bot.int + 1
                                end
                            end
                            ::s::
                        else
                            printStringNow(('%.3f - %.3f'):format( bot.delay.v-((os.clock()-clock)/60), (bot.delay.v*60)-((os.clock()-clock)) ),1)
                        end
                    end

                end)
            end
            
            if bot.bool.v then
                imgui.SameLine()
                if imgui.Button(u8'infobar') then
                    bot.viewItems.v = not bot.viewItems.v
                end
            end
            imgui.BeginChild('1',imgui.ImVec2(-1,50),true)
            if imgui.ActiveButton(u8'Предметы',imgui.ImVec2(250-10,-1),bot.listItems) then
                bot.listItems = true
            end
            imgui.SameLine()
            if imgui.ActiveButton(u8'Маршрут бота',imgui.ImVec2(250-10,-1),not bot.listItems) then
                bot.listItems = false
            end
            imgui.EndChild()

            if not bot.listItems then
                imgui.PushItemWidth(280)
                if imgui.DragInt(u8'Через сколько повторить круг?',bot.delay,0.005,1,1000) then;   j.bot.delay = bot.delay.v;  json.save(j,'[arz]crBot.json');   end
                imgui.PopItemWidth()
                imgui.TextQuestion(u8[[
Время в минутах!
После окончание работы бота - через сколько бот снова начнет круг
(Во время таймера бот ничего не делает)
]])
                if imgui.Button(u8'Поставить точку сюда!') then
                    -- MYPOS[3] = MYPOS[3]-1.5
                    table.insert(j.bot.coords,{
                        pos = MYPOS,
                        lavka = bot.lavka.v
                    })
                    json.save(j,'[arz]crBot.json')
                end
                imgui.SameLine()
                imgui.Checkbox('lavka?',bot.lavka)
                imgui.TextQuestion(u8[[
Если бот подошел к этой точке и тут стоит lavka?=true
то скрипт будет флудить АЛЬТ для открытия лавки
(если поблизости Свободная лавка то скрипт её пропустит)]])
                imgui.Separator()
                for k,v in ipairs(j.bot.coords) do
                    local _,x,y,z = convert3DCoordsToScreenEx(unpack(v.pos))
                    if z > 1 then
                        renderFontDrawText(font,tostring(k),x,y,-1)
                    end
                    if j.bot.coords[k+1] ~= nil then
                        local _,xx,yy,zz = convert3DCoordsToScreenEx(unpack(j.bot.coords[k+1].pos))
                        if zz > 1 and z > 1 then
                            renderDrawLine(x,y,xx,yy,2,-1)
                        end
                    end
                    drawCircleIn3d(v.pos[1],v.pos[2],v.pos[3],1,360,2,('0x%02xffffff'):format(100))
                    imgui.Text(k..',its lavka?='..tostring(v.lavka))
                    imgui.SameLine()
                    if imgui.Button(u8'lavka##'..k) then;  v.lavka = not v.lavka;  json.save(j,'[arz]crBot.json'); end
                    imgui.SameLine()
                    if imgui.Button(u8'thisPos##'..k) then;  v.pos = MYPOS;  json.save(j,'[arz]crBot.json'); end
                    imgui.SameLine()
                    if imgui.Button(u8'delete##'..k) then;  table.remove(j.bot.coords,k);   json.save(j,'[arz]crBot.json'); end
                end
            else
                if imgui.Button(u8'Хочу обновить предметы') then
                    imgui.OpenPopup('update items')
                end
                if imgui.CollapsingHeader(u8'\tЧто я скупаю?') then
                    imgui.Columns(2,'my items',true)
                    imgui.Text(u8'Предмет')
                    imgui.NextColumn()
                    imgui.Text(u8'Цена(за 1шт.)-кол-во')
                    imgui.Separator()
                    imgui.NextColumn()
                    for k,v in ipairs(j.bot.items) do
                        imgui.Text(u8(v.item))
                        imgui.TextQuestion(nil,u8(v.item))
                        imgui.NextColumn()
                        local int,cost,buy = imgui.ImInt(v.int),imgui.ImInt(v.cost),imgui.ImBool(v.buy)
                        if imgui.Checkbox('buy##'..k,buy) then
                            v.buy = buy.v
                            json.save(j,'[arz]crBot.json')
                        end
                        if buy.v then
                            imgui.SameLine()
                            imgui.PushItemWidth(75)
                            if imgui.InputInt('$##'..k,cost,0,0) then
                                v.cost = cost.v
                                json.save(j,'[arz]crBot.json')
                            end
                            imgui.SameLine()
                            if imgui.InputInt(u8'кол-во##'..k,int,0,0) then
                                v.int = int.v
                                json.save(j,'[arz]crBot.json')
                            end
                            imgui.PopItemWidth(2)
                            imgui.SameLine()
                            if imgui.Button('remove##'..k) then
                                table.remove(j.bot.items,k)
                                json.save(j,'[arz]crBot.json')
                            end
                        end
                        imgui.NextColumn()
                    end
                    imgui.Columns()
                    imgui.Separator()
                end

                if imgui.BeginPopup('update items') then
                    if imgui.Button(u8'Через сайт arz-wiki(ПЕРЕЗАПИСЬ ПРЕДМЕТОВ)') then
                        local res,er = pcall(requests.get,'https://arz-wiki.com/items/')
                        if not res then
                            sampShowDialog(1,'crBot',(
    [[Скрипту не удалось получить текст с сайта!
ошибка: 
    <%s>

Зайдите на github репозиторий скрипта, там должен быть json файл([arz]crBot_Items.json) со всеми предметами
закиньте этот json в папку config]]):format(er),'<','>',0)
                        else
                            sampAddChatMessage('Парсинг предметов начался! Для {CD1515}отмены{cccccc} зажмите цифру 0')
                            crItems = {}
                            local maxPage = 0
                            lua_thread.create(function()
                                local get = false
                                asyncHttpRequest('GET','https://arz-wiki.com/items/',nil,function(r)
                                    for l in r.text:gmatch('[^\n]+') do
                                        if l:find('^%<a class%=.page%-numbers. href%=.%S+.%>(%d+)%<%/a%>$') then
                                            local n = tonumber(l:match('^%<a class%=.page%-numbers. href%=.%S+.%>(%d+)%<%/a%>$'))
                                            if n > maxPage then;    maxPage = n;    end
                                        end
                                        get = true
                                    end
                                end,nil)
                                while not get do wait(5) end
                                
                                for page = 1,maxPage do
                                    if isKeyDown(VK_0) then
                                        sampShowDialog(1,'crBot',([[
Парсинг был отменен!
Было записано %s предметов из %s/%s страниц]]):format(#crItems,page,maxPage),'<','>',0)
                                        break
                                    end
                                    local get = false
                                    asyncHttpRequest('GET','https://arz-wiki.com/items/page/'..page..'/',nil,function(r)
                                        for l in r.text:gmatch('[^\n]+') do
                                            if l:find('%<a href%=.https%:%/%/arz%-wiki%.com%/items%/%S+/.%>(.+)%<%/a%>%<%/h2%>$') then
                                                table.insert(crItems,u8:decode(l:match('%<a href%=.https%:%/%/arz%-wiki%.com%/items%/%S+/.%>(.+)%<%/a%>%<%/h2%>$')))
                                            end
                                        end
                                        get = true
                                    end,nil)
                                    while (not get) do wait(10) end
                                    clearPrints()
                                    printStringNow('write item #'..#crItems..',page '..page..'/'..maxPage,1000)
                                end
                                json.save(crItems,'[arz]crBot_Items.json')
                                sampAddChatMessage('Парсинг {0CC726}успешно{cccccc} завершен!')
                            end)
                        end
                    end
                imgui.TextQuestion(u8[[
Скрипт парсит страницы 'https://arz-wiki.com/items/page/1+/' и берет название товаров
в одной странице 30 предметов

время парсинга всех страниц предметов на arz-wiki зависит от вашего интернета
(сайт возможно не будет работать в Украине(но у меня работал, тут зависит от вашего провайдера))
]])
                    if imgui.Button(u8'Установить json из github репозиторий скрипта') then
                        asyncHttpRequest('GET',
                            'https://raw.githubusercontent.com/Affarsi/CR_bot/main/%5Barz%5DcrBot_Items.json',nil,function(r)
                                sampAddChatMessage('[arz]crBot_Items.json был {0CC726}успешно{cccccc} перезаписан из github\'a! Скрипт будет перезагружен..')
                                local f = io.open('moonloader/config/[arz]crBot_Items.json','w')
                                f:write((r.text))
                                f:close()
                                thisScript():reload()
                        end,nil)

                    end
                    imgui.TextQuestion(u8[[
Возможные неактуальные товары!]])
                    imgui.Text(u8[[
Ну, или вручную добавить товар в json(moonloader/config/[arz]crBot_Items.json)..]])
                    imgui.EndPopup()
                end

                imgui.InputText('search items',bot.search)

                if #bot.search.v > 1 then
                    for k,v in ipairs(crItems) do
                        if (stringToLower(v)):find(u8:decode(bot.search.v)) then
                            if imgui.Button(u8(v)) then
                                imgui.OpenPopup(u8(v))
                            end
                        end
                        if imgui.BeginPopupModal(u8(v),nil,64) then
                            -- imgui.Text(string.rep(' ',(imgui.CalcTextSize(u8(v)).x/2+20) ))

                            local int = imgui.ImInt((bot.buy.v and 1 or 0))
                            imgui.RadioButton(u8'Чекнуть ли есть товар в лавке',int,0)
                            imgui.SameLine()
                            imgui.Text(string.rep(' ',(imgui.CalcTextSize(u8(v)).x/4) ))
                            imgui.RadioButton(u8'Купить товар',int,1)
                            bot.buy.v = (int.v == 1 and true or false)

                            if int.v == 1 then
                                imgui.Text(u8'Купить товар если цена ниже(<=)')
                                imgui.SameLine()
                                imgui.PushItemWidth(150)
                                imgui.InputInt(u8'(цена за одну штуку)##cost',bot.cost)
                                imgui.Text(u8'Сколько купить?')
                                imgui.SameLine()
                                imgui.InputInt(u8'##int',bot.int)
                                imgui.PopItemWidth(2)
                            end
                            if imgui.Button('add',imgui.ImVec2(-1,20)) then
                                table.insert(j.bot.items,{
                                    item = v,
                                    buy = bot.buy.v,
                                    cost = bot.cost.v,
                                    int = bot.int.v,
                                })
                                json.save(j,'[arz]crBot.json')
                                imgui.CloseCurrentPopup()
                            end

                            imgui.SetCursorPos(imgui.ImVec2(imgui.GetWindowSize().x-imgui.CalcTextSize('close').x-20,25))
                            if imgui.Button('close') then imgui.CloseCurrentPopup() end

                            imgui.EndPopup()
                        end
                    end
                end
            end

        elseif active == b[4] then

            if imgui.BeginMenu('edit colors') then
                for k,v in pairs(lavki.colors) do
                    if imgui.ColorEdit4(u8(k),v) then
                        j.lavki.colors[k] = {v.v[1],v.v[2],v.v[3],v.v[4]}
                        json.save(j,'[arz]crBot.json')
                    end
                end
                imgui.EndMenu()
            end

            if imgui.BeginMenu('coordmaster') then
                imgui.Text(u8[[
    Если к премеру вы сделали на пару лавок ловлю
    то если лавка слетит и скрипт успешно её купит все другие лавки отключат ловлю]])
                if imgui.DragFloat('step',lavki.coordmaster.step,0.5,1,10000) then j.lavki.coordmaster.step = lavki.coordmaster.step.v;    json.save(j,'[arz]crBot.json');   end
                if imgui.DragInt('delay',lavki.coordmaster.delay,0.5,10,10000) then j.lavki.coordmaster.delay = lavki.coordmaster.delay.v;    json.save(j,'[arz]crBot.json');   end
                imgui.EndMenu()
            end

            for k,v in pairs(lavki.lavki) do
                local r,g,b,a = unpack(j.lavki.colors['свободная лавка'])
                imgui.SetCursorPos(imgui.ImVec2(v.imgui.x+100,v.imgui.y+40))
                if v.text.text:find('^%S+ продаёт товар') then
                    r,g,b,a = unpack(j.lavki.colors['продаёт'])
                elseif v.text.text:find('^%S+ покупает товар') then
                    r,g,b,a = unpack(j.lavki.colors['покупает'])                
                elseif v.text.text:find('^%S+ продаёт и покупает товар') then
                    r,g,b,a = unpack(j.lavki.colors['продаёт и покупает'])                
                elseif v.text.text:find('^%S+ редактирует список') then
                    r,g,b,a = unpack(j.lavki.colors['редактирует'])
                end
                imgui.PushStyleColor(1,imgui.ImVec4(r,g,b,a))
                imgui.Text('<>')
                imgui.PopStyleColor()

                if imgui.IsItemHovered() then
                    if imgui.IsItemClicked(0) then
                        v.render = not v.render
                    elseif imgui.IsItemClicked(1) then
                        v.buy = not v.buy
                        lavki.coordmaster.buyingClock = 0
                        lavki.coordmaster.work = false
                        lua_thread.create(function()
                            if v.buy and not lavki.coordmaster.work and v.text.text == 'свободная лавка!' then
                                lavki.coordmaster.work = true
                                lavki.coordmaster.buyingClock = os.clock()
                                coordMaster(v.pos[1],v.pos[2],17)
                            end
                        end)
                    end
                    imgui.BeginTooltip()
                    imgui.Text(u8('Лавка '..k..'\n'..v.text.text))
                    imgui.Text(u8(v.render and 'Рендер включен' or 'Рендер выключен') ..u8'(ЛКМ)')
                    imgui.Text(u8(v.buy and 'Ловля включена' or 'Ловля выключена') ..u8'(ПКМ)(ловля курдмастером)')
                    imgui.EndTooltip()
                end
            end

            local b = {
                {'on render all',function(v) v.render = true end},
                {'on lovlya all',function(v) v.buy = true end},
                {'off render all',function(v) v.render = false end},
                {'off lovlya all',function(v) v.buy = false end},
            }
            imgui.SetCursorPos(imgui.ImVec2(8,170))
            for l,v in ipairs(b) do
                if l == 3 then
                    imgui.Spacing()
                end
                if imgui.Button(v[1]) then
                    for k,vv in ipairs(lavki.lavki) do;  v[2](vv);    end
                end
            end

            imgui.PushFont(arial[18])
            imgui.SetCursorPos(imgui.ImVec2(230-imgui.CalcTextSize(u8'Вход на ЦР').x/2,360))
            imgui.Text(u8'Вход на ЦР')
            imgui.PopFont()

        end--active
        imgui.EndChild()

        imgui.SetCursorPos(imgui.ImVec2(5,1))
        imgui.PushFont(arial[23])
        imgui.Text('[arz]crBot')
        imgui.PopFont()
        if update ~= nil and update.version ~= nil then
            imgui.SetCursorPos(imgui.ImVec2(imgui.GetWindowSize().x/2- imgui.CalcTextSize(u8"Вышло обновление!").x/2,1))
            imgui.PushFont(arial[23])
            imgui.TextColored(0xff4275d1,u8'Вышло обновление!')
            imgui.PopFont()
            imgui.SameLine()
            imgui.SetCursorPosY(3)

            imgui.PushFont(arial[15])
            if imgui.Button(u8'Подробнее') then
                imgui.OpenPopup(u8'Подробнее об обновлении на версию '..update.version)
            end
            imgui.PopFont()

            if imgui.BeginPopupModal(u8'Подробнее об обновлении на версию '..update.version,nil,64+1) then
                for l in update.upd:gmatch('[^\n]+') do
                    imgui.Text(u8(l))
                end
                if imgui.Button(u8'обновиться',imgui.ImVec2(0,20)) then
                    
                end
                imgui.SameLine()
                if imgui.Button(u8'та нахой оно мне нада',imgui.ImVec2(0,20)) then
                    imgui.CloseCurrentPopup()
                end
                imgui.EndPopup()
            end

        end

        imgui.SetCursorPos(imgui.ImVec2(imgui.GetWindowSize().x-40,1))
        if imgui.InvisibleButton('X##CLOSE_WINDOW',imgui.ImVec2(30,30)) then window.v = false end
        imgui.SetCursorPos(imgui.ImVec2(imgui.GetWindowSize().x-25,1))
        imgui.PushFont(arial[23])
        imgui.Text('X')
        imgui.PopFont()


        imgui.End()
    end

end

function sampev.onServerMessage(color,text)
    if text:find('Вы успешно арендовали лавку') and lavki.coordmaster.buyingClock ~= 0 then
        lavki.coordmaster.buyingClock = 0
        lavki.coordmaster.work = false
        sendTelegramMessage('Вы успешно арендовали лавку!\nЛовля отключена на все лавки!')
        for k,v in ipairs(lavki.lavki) do; v.buy = false;  end
    end
end

function sampev.onShowDialog(id, style, title, b1, b2, text)
    if title == '{BFBBBA}' and text:find('^%{%x+%}Стоимость аренды лавки%: %{%x+%}%$%d+') then

    end

    if title:find('Покупка предмета') and lavkaOpen() then
    -- if true then
        local item,int,cost = '',0,0
        for l in text:gmatch('[^\n]+') do
            if l:find('^%{%x+%}%W+%: ') and item == '' then
                item = (l:match('^%{%x+%}%W+%: (.+)')):gsub('%{%x+%}','') 
            end
            if l:find('^В наличии%: (%d+) шт%.') and int == 0 then
                int = tonumber(l:match('^В наличии%: (%d+) шт%.'))
            end
            if l:find('Стоимость%: %$(%S+) за (%d+) шт%.$') and cost == 0 then
                cost = ((l:match('Стоимость%: %$(%S+) за (%d+) шт%.$')):gsub('%.',''):gsub(',',''))
                cost = tonumber(cost)
            end
        end
        -- if bot.message.v and (bot.td.items[bot.td.int] ~= nil) and not bot.bool.v then
        --     bot.td.int = bot.td.int + 1
        --     lua_thread.create(function() wait(1) sampCloseCurrentDialogWithButton(0) wait(5) local _,_ = pcall(function() sampSendClickTextdraw(bot.td.items[bot.td.int].id) end) end)
        -- end
        if bot.bool.v then
            for k,v in ipairs(j.bot.items) do
                if v.item == item then
                    if v.buy and v.cost >= cost then
                        if style == 0 then
                            lua_thread.create(function() wait(1) sampCloseCurrentDialogWithButton(1) end)
                        else
                            sampSendDialogResponse(id,1,_,tostring((v.int > int and int or v.int)))
                        end
                        v.int = v.int - 1
                        sendTelegramMessage('Предмет %s был куплен за %s$(за 1шт)\nВсего было куплено %s количество,осталось %s',item,cost,int,v.int)
                        if v.int == 0 then
                            sendTelegramMessage('Предмет %s был весь выкуплен!\n(предмет для скупки удален из скрипта)',item)
                            table.remove(j.bot.items,k)
                        end
                        json.save(j,'[arz]crBot.json')
                    elseif not v.buy then
                        sendTelegramMessage('Предмет %s был найден в лавке за %s$(за 1шт)\nВсего количества %s',item,cost,int)
                    end
                end
            end

            bot.td.int = bot.td.int + 1
            lua_thread.create(function() wait(3) sampCloseCurrentDialogWithButton(0) end)
        end
    end

end

function imgui.ActiveButton(label,size,bool)
    local b = false
    if bool then
        imgui.PushStyleColor(23,imgui.GetStyle().Colors[25])
    end
    if imgui.Button(label,(size and size or imgui.ImVec2(0,0))) then b = true end
    if bool then imgui.PopStyleColor() end
    return b
end

local AI_PAGE = {}
function imgui.PageButton(bool, icon, name, but_wide)
    local sizeX,sizeY = 140,90
    but_wide = but_wide or 190 -- 100.00
    local duration = 0.25
    local DL = imgui.GetWindowDrawList()
    local p1 = imgui.GetCursorScreenPos()
    local p2 = imgui.GetCursorPos()
    local col = imgui.GetStyle().Colors[imgui.Col.ButtonActive]
        
    if not AI_PAGE[name] then;  AI_PAGE[name] = { clock = nil };  end
    local pool = AI_PAGE[name]

    imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0.00, 0.00, 0.00, 0.00))
    imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(0.00, 0.00, 0.00, 0.00))
    imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(0.00, 0.00, 0.00, 0.00))
    local result = imgui.InvisibleButton(name, imgui.ImVec2(but_wide, sizeY))
    if result and not bool then 
        pool.clock = os.clock() 
    end
    local pressed = imgui.IsItemActive()
    imgui.PopStyleColor(3)
    if bool then
        if pool.clock and (os.clock() - pool.clock) < duration then
            local wide = (os.clock() - pool.clock) * (but_wide / duration)
            DL:AddRectFilled(imgui.ImVec2(p1.x, p1.y), imgui.ImVec2((p1.x + sizeX) - wide, p1.y + sizeY), 0x10FFFFFF, 15, 10)
            DL:AddRectFilled(imgui.ImVec2(p1.x, p1.y), imgui.ImVec2(p1.x + 5, p1.y + sizeY), imgui.GetColorU32(col))
            DL:AddRectFilled(imgui.ImVec2(p1.x, p1.y), imgui.ImVec2(p1.x + wide, p1.y + sizeY), imgui.GetColorU32(imgui.ImVec4(col.x, col.y, col.z, 0.6)), 15, 10)
        else
            DL:AddRectFilled(imgui.ImVec2(p1.x, (pressed and p1.y + 3 or p1.y)), imgui.ImVec2(p1.x + 5, (pressed and p1.y + 32 or p1.y + sizeY)), imgui.GetColorU32(col))
            DL:AddRectFilled(imgui.ImVec2(p1.x, p1.y), imgui.ImVec2(p1.x + sizeX, p1.y + sizeY), imgui.GetColorU32(imgui.ImVec4(col.x, col.y, col.z, 0.6)), 15, 10)
        end
    else
        if imgui.IsItemHovered() then
            DL:AddRectFilled(imgui.ImVec2(p1.x, p1.y), imgui.ImVec2(p1.x + sizeX, p1.y + sizeY), 0x10FFFFFF, 15, 10)
        end
    end
    imgui.SameLine(10); imgui.SetCursorPosY(p2.y + 8)
    if bool then
        imgui.Text((' '):rep(3) .. icon)
        imgui.SameLine(60)
        imgui.PushFont(hellocum)
        imgui.Text(name)
        imgui.PopFont()
    else
        imgui.TextColored(imgui.ImVec4(0.60, 0.60, 0.60, 1.00), (' '):rep(3) .. icon)
        imgui.SameLine(60)
        imgui.TextColored(imgui.ImVec4(0.60, 0.60, 0.60, 1.00), name)
    end
    imgui.SetCursorPosY(p2.y + 40)
    return result
end

function drawCircleIn3d(x, y, z, radius, polygons,width,color)
    local step = math.floor(360 / (polygons or 36))
    local sX_old, sY_old
    for angle = 0, 360, step do
        local lX = radius * math.cos(math.rad(angle)) + x
        local lY = radius * math.sin(math.rad(angle)) + y
        local lZ = z
        local _, sX, sY, sZ, _, _ = convert3DCoordsToScreenEx(lX, lY, lZ)
        if sZ > 1 then
            if sX_old and sY_old then
                renderDrawLine(sX, sY, sX_old, sY_old, width, color)
            end
            sX_old, sY_old = sX, sY
        end
    end
end

function setAngle(x,y,z)
    local SMOOTH = 2
    local myPos = {getActiveCameraCoordinates()}
    local vector = {myPos[1] - x, myPos[2] - y, myPos[3] - z}
    if isWidescreenOnInOptions() then coefficentZ = 0.0778 else coefficentZ = 0.103 end
    local angle = {(math.atan2(vector[2], vector[1]) + 0.04253), (math.atan2((math.sqrt((math.pow(vector[1], 2) + math.pow(vector[2], 2)))), vector[3]) - math.pi / 2 - coefficentZ)}
    local view = {fix(representIntAsFloat(readMemory(0xB6F258, 4, false))), fix(representIntAsFloat(readMemory(0xB6F248, 4, false)))}
    local difference = {angle[1] - view[1], angle[2] - view[2]}
    local smooth = {difference[1] / SMOOTH, difference[2] / SMOOTH}
    setCameraPositionUnfixed((view[2] + smooth[2]), (view[1] + smooth[1]))
end

function fix(angle)
    if angle > math.pi then
        angle = angle - (math.pi * 2)
    elseif angle < -math.pi then 
        angle = angle + (math.pi * 2) 
    end
    return angle
end

function gameConvertText(text,conv)
    local t = {
        ['gametorus'] = {[69]=168,[101]=184,[65]=192,[128]=193,[139]=194,[130]=195,[131]=196,[69]=197,[132]=198,[136]=199,[133]=200,[133]=201,[75]=202,[135]=203,[77]=204,[72]=205,[79]=206,[140]=207,[80]=208,[67]=209,[143]=210,[89]=211,[129]=212,[88]=213,[137]=214,[141]=215,[142]=216,[138]=217,[167]=218,[145]=219,[146]=220,[147]=221,[148]=222,[149]=223,[97]=224,[151]=225,[162]=226,[153]=227,[154]=228,[101]=229,[155]=230,[159]=231,[156]=232,[157]=233,[107]=234,[158]=235,[175]=236,[174]=237,[111]=238,[163]=239,[112]=240,[99]=241,[166]=242,[121]=243,[63]=244,[120]=245,[36]=246,[164]=247,[165]=248,[161]=249,[144]=250,[168]=251,[169]=252,[170]=253,[171]=254,[172]=255},
        ['rustogame'] = {[230]=155,[231]=159,[247]=164,[234]=107,[250]=144,[251]=168,[254]=171,[253]=170,[255]=172,[224]=97,[240]=112,[241]=99,[226]=162,[228]=154,[225]=151,[227]=153,[248]=165,[243]=121,[184]=101,[235]=158,[238]=111,[245]=120,[233]=157,[242]=166,[239]=163,[244]=63,[237]=174,[229]=101,[246]=36,[236]=175,[232]=156,[249]=161,[252]=169,[215]=141,[202]=75,[204]=77,[220]=146,[221]=147,[222]=148,[192]=65,[193]=128,[209]=67,[194]=139,[195]=130,[197]=69,[206]=79,[213]=88,[168]=69,[223]=149,[207]=140,[203]=135,[201]=133,[199]=136,[196]=131,[208]=80,[200]=133,[198]=132,[210]=143,[211]=89,[216]=142,[212]=129,[214]=137,[205]=72,[217]=138,[218]=167,[219]=145},
    }
    local result = {}
    for i = 1, #text do
        local c = text:byte(i)
        result[i] = string.char(t[conv:lower()][c] or c)
    end
    return table.concat(result)
end

function renderFontDrawTextFromAlign(FONT,text,x,y,color,align)
    align = align or 1
    if align == 2 then
        x = x - renderGetFontDrawTextLength(FONT,text)/2 
    elseif align == 3 then
        x = x - renderGetFontDrawTextLength(FONT,text)
    end
    renderFontDrawText(FONT,text,x,y,-1)
end

function sendTelegramMessage(text,...)
    for l in (tostring(text)):format(...):gmatch('[^\n]+') do
        sampAddChatMessage('{0090FF}'..l)
    end
    text = '[crBot]'..(tostring(text)):format(...)
    text = text:gsub('{......}', '')
    text = text:gsub(' ', '%+')
    text = text:gsub('\n', '%%0A')
    text = u8:encode(text, 'CP1251')
    requests.get('https://api.telegram.org/bot' .. tg.token.v .. '/sendMessage?chat_id=' .. tg.chat_id.v .. '&text='..text)
end

function sendSyncKey(key)
    local keys = {
        ['W'] = {offset=1,key=32768},
        ['A'] = {offset=1,key=255},
        ['S'] = {offset=2,key=128},
        ['SPRINT'] = {offset=4,key=8},
        ['ALT'] = {offset=4,key=1024},
        ['F'] = {offset=4,key=16},
        ['CAPS LOCK'] = {offset=4,key=128},
        ['Y'] = {offset=36,key=64},
        ['N'] = {offset=36,key=128},
        ['H'] = {offset=36,key=192},
        ['C'] = {offset=36,key=256},
    }
    if keys[key]==nil then return end
    local _, myId = sampGetPlayerIdByCharHandle(PLAYER_PED)
    local data = allocateMemory(68)
    sampStorePlayerOnfootData(myId, data)
    setStructElement(data, keys[key].offset, 2, keys[key].key, false)
    sampSendOnfootData(data)
    freeMemory(data)
end


function coordMaster(px, py, pz)
    -- lua_thread.create(function()
        if not lavki.coordmaster.work then freezeCharPosition(PLAYER_PED,false) return end
        local step = lavki.coordmaster.step.v
        local delay = lavki.coordmaster.delay.v

        local x, y, z = getCharCoordinates(PLAYER_PED)
        local d = getDistanceBetweenCoords3d(px, py, pz, x, y, z)

        if getDistanceBetweenCoords3d(px,py,0,x,y,0) >= 3 then
            local dz = (-5) - z
            z = z + step / 20 * dz
        else
            local dz = pz - z
            z = z + step / d * dz
        end


        if d <= (step) then
            sampAddChatMessage("FIN")
            freezeCharPosition(PLAYER_PED,false)
            setCharCoordinates(PLAYER_PED, px, py, pz)
            lavki.coordmaster.work = false
            return
        end

        freezeCharPosition(PLAYER_PED,true)
        local dx, dy = px - x, py - y
        x = x + step / d * dx
        y = y + step / d * dy

        setCharCoordinates(PLAYER_PED, x, y, z)
        wait(delay)
        coordMaster(px, py, pz)
    -- end)
end

local OrigimguiTextColored = imgui.TextColored
function imgui.TextColored(color,text)
    local r,g,b,a = 0,0,0,0
    if type(color) ~= 'userdata' then
        a = bit.band(bit.rshift(color, 24), 0xFF);     r = bit.band(bit.rshift(color, 16), 0xFF);     g = bit.band(bit.rshift(color, 8), 0xFF);  b = bit.band(color, 0xFF)
    end
   OrigimguiTextColored(type(color) == 'userdata' and color or imgui.ImVec4(r/255,g/255,b/255,a/255),text)
end
function asyncHttpRequest(method, url, args, resolve, reject)
    local request_thread = (require'effil').thread(function (method, url, args)
    local requests = require 'requests'
    local result, response = pcall(requests.request, method, url, args)
    if result then
        response.json, response.xml = nil, nil
        return true, response
    else
        return false, response
    end
    end)(method, url, args)
    if not resolve then resolve = function() end end
    if not reject then reject = function() end end
    lua_thread.create(function()
        local runner = request_thread
        while true do
            local status, err = runner:status()
            if not err then
                if status == 'completed' then
                    local result, response = runner:get()
                    if result then; resolve(response)
                    else;   reject(response)   
                    end
                    return
                elseif status == 'canceled' then
                    return reject(status)
                end
            else
                return reject(err)
            end
        wait(0)
        end
    end)
end

function stringToLower(s)
    for i = 192, 223 do   
        s = s:gsub(_G.string.char(i), _G.string.char(i + 32))
    end
    s = s:gsub(_G.string.char(168), _G.string.char(184))
    return s:lower()
end

function bluetheme()
    imgui.SwitchContext()
    local colors = imgui.GetStyle().Colors;
    local icol = imgui.Col
    local ImVec4 = imgui.ImVec4

    imgui.GetStyle().WindowPadding = imgui.ImVec2(8, 8)
    imgui.GetStyle().WindowRounding = 16.0
    imgui.GetStyle().FramePadding = imgui.ImVec2(5, 3)
    imgui.GetStyle().ItemSpacing = imgui.ImVec2(4, 4)
    imgui.GetStyle().ItemInnerSpacing = imgui.ImVec2(5, 5)
    imgui.GetStyle().IndentSpacing = 9.0
    imgui.GetStyle().ScrollbarSize = 17.0
    imgui.GetStyle().ScrollbarRounding = 16.0
    imgui.GetStyle().GrabMinSize = 7.0
    imgui.GetStyle().GrabRounding = 6.0
    imgui.GetStyle().ChildWindowRounding = 6.0
    imgui.GetStyle().FrameRounding = 6.0

    colors[icol.Text]                   = ImVec4(0.90, 0.90, 0.90, 1.00);
    colors[icol.TextDisabled]           = ImVec4(0.60, 0.60, 0.60, 1.00);
    colors[icol.WindowBg]               = ImVec4(0.11, 0.11, 0.11, 1.00);
    colors[icol.ChildWindowBg]          = ImVec4(0.11, 0.11, 0.11, 1.00);
    colors[icol.PopupBg]                = ImVec4(0.11, 0.11, 0.11, 1.00);
    colors[icol.Border]                 = ImVec4(0.26, 0.46, 0.82, 1.00);
    colors[icol.BorderShadow]           = ImVec4(0.26, 0.46, 0.82, 1.00);
    colors[icol.FrameBg]                = ImVec4(0.26, 0.46, 0.82, 0.59);
    colors[icol.FrameBgHovered]         = ImVec4(0.26, 0.46, 0.82, 0.88);
    colors[icol.FrameBgActive]          = ImVec4(0.28, 0.53, 1.00, 1.00);
    colors[icol.TitleBg]                = ImVec4(0.26, 0.46, 0.82, 1.00);
    colors[icol.TitleBgActive]          = ImVec4(0.26, 0.46, 0.82, 1.00);
    colors[icol.TitleBgCollapsed]       = ImVec4(0.26, 0.46, 0.82, 1.00);
    colors[icol.MenuBarBg]              = ImVec4(0.26, 0.46, 0.82, 0.75);
    colors[icol.ScrollbarBg]            = ImVec4(0.11, 0.11, 0.11, 1.00);
    colors[icol.ScrollbarGrab]          = ImVec4(0.26, 0.46, 0.82, 0.68);
    colors[icol.ScrollbarGrabHovered]   = ImVec4(0.26, 0.46, 0.82, 1.00);
    colors[icol.ScrollbarGrabActive]    = ImVec4(0.26, 0.46, 0.82, 1.00);
    colors[icol.ComboBg]                = ImVec4(0.26, 0.46, 0.82, 0.79);
    colors[icol.CheckMark]              = ImVec4(1.000, 0.000, 0.000, 1.000)
    colors[icol.SliderGrab]             = ImVec4(0.263, 0.459, 0.824, 1.000)
    colors[icol.SliderGrabActive]       = ImVec4(0.66, 0.66, 0.66, 1.00);
    colors[icol.Button]                 = ImVec4(0.26, 0.46, 0.82, 0.80);
    colors[icol.ButtonHovered]          = ImVec4(0.26, 0.46, 0.82, 0.59);
    colors[icol.ButtonActive]           = ImVec4(0.26, 0.46, 0.82, 1.00);
    colors[icol.Header]                 = ImVec4(0.26, 0.46, 0.82, 1.00);
    colors[icol.HeaderHovered]          = ImVec4(0.26, 0.46, 0.82, 0.74);
    colors[icol.HeaderActive]           = ImVec4(0.26, 0.46, 0.82, 1.00);
    colors[icol.Separator]              = ImVec4(0.37, 0.37, 0.37, 1.00);
    colors[icol.SeparatorHovered]       = ImVec4(0.60, 0.60, 0.70, 1.00);
    colors[icol.SeparatorActive]        = ImVec4(0.70, 0.70, 0.90, 1.00);
    colors[icol.ResizeGrip]             = ImVec4(1.00, 1.00, 1.00, 0.30);
    colors[icol.ResizeGripHovered]      = ImVec4(1.00, 1.00, 1.00, 0.60);
    colors[icol.ResizeGripActive]       = ImVec4(1.00, 1.00, 1.00, 0.90);
    colors[icol.CloseButton]            = ImVec4(0.00, 0.00, 0.00, 1.00);
    colors[icol.CloseButtonHovered]     = ImVec4(0.00, 0.00, 0.00, 0.60);
    colors[icol.CloseButtonActive]      = ImVec4(0.35, 0.35, 0.35, 1.00);
    colors[icol.PlotLines]              = ImVec4(1.00, 1.00, 1.00, 1.00);
    colors[icol.PlotLinesHovered]       = ImVec4(0.90, 0.70, 0.00, 1.00);
    colors[icol.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00);
    colors[icol.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00);
    colors[icol.TextSelectedBg]         = ImVec4(0.00, 0.00, 1.00, 0.35);
    colors[icol.ModalWindowDarkening]   = ImVec4(0.20, 0.20, 0.20, 0.35);
end
bluetheme()

local origsampAddChatMessage = sampAddChatMessage
function sampAddChatMessage(text,...); origsampAddChatMessage('[crBot]{cccccc}' .. (tostring(text)):format(...),0x4275d1); end

function imgui.TextQuestion(text,tip)
    if text ~= nil then
        imgui.SameLine()
        imgui.TextDisabled('(?)')
    end
    if imgui.IsItemHovered() then
        imgui.BeginTooltip()
        imgui.Text((text == nil and tip or text))
        imgui.EndTooltip()
    end
end
