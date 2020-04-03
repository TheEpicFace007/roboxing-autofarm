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

isStrenghtToolUsed = function() --> return an array of the pad that arent used 
    local trainingDevice = {
        ["workspace.Crunches"]    = workspace.Crunches.In_Use.Value;
        ["workspace.Leg_Lift"]    =  workspace.Leg_Lift.In_Use.Value;
        ["workspace.Squat_Jumps"] = workspace.Squat_Jumps.In_Use.Value;
        ["workspace.Push_Ups"]    = workspace.Push_Ups.In_Use.Value;
    }
    for k,v in pairs(trainingDevice) do
        if (k.v) == true then
            table.remove(trainingDevice,k)
        end
    end
    return trainingDevice
end

