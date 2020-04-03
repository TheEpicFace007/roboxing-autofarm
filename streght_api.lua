--Game Variable--
local Players = game:GetService('Players')
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer.PlayerGui
local PlayerScript = LocalPlayer.PlayerScripts
local StarterPlayer = game.StarterPlayer
local StarterPlayerScript = game.StarterPlayer.StarterPlayerScripts
local StarterCharacterScript= StarterPlayer.StarterCharacterScripts
local StarterGui = game.StarterGui
local ReplicatedStorage = game.ReplicatedStorage
local ReplicatedFirst = game:GetService('ReplicatedFirst')
local Backpack = LocalPlayer.Backpack
local Character = LocalPlayer.Character
local Humanoid = Character.Humanoid
local HumanoidRootFrame = Character.HumanoidRootPart 
-- return an array that indicate which training device are used and which are not used
getgenv().strenghtAuto = {}
getgenv().strenghtAuto.timeItRepeat = 1 -- the default step of cycle of the auto farm

fireMb1Click = function(btn)
    for _,signal in pairs( getconnections(btn.MouseButton1Click )) do
        signal:Fire()
    end
end

isStrenghtToolUsed = function() 
    local trainingDevice = {
        Crunches    = workspace.Crunches.In_Use.Value;
        Leg_Lift    =  workspace.Leg_Lift.In_Use.Value;
        Squat_Jumps = workspace.Squat_Jumps.In_Use.Value;
        Push_Ups    = workspace.Push_Ups.In_Use.Value;
    }
    return trainingDevice
end

-- @timeItRepeat | amount of time it will repat the autofarm useful if you want to train on a specific thing  | intended for slider. if its not used the default value will be 1
setAmountItWillRepeat = function(timeItRepeat)
    if timeItRepeat < 1 then 
        error("error in #1, the number must be equal or bigger than 1")
    else
        getgenv().strenghtAuto.timeItRepeat = timeItRepeat
    end
end

doStreghtAutoFarm = function()
    
end