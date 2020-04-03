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
isStrenghtToolUsed = function() 
    local trainingDevice = {
        Crunches    = workspace.Crunches.In_Use.Value;
        Leg_Lift    =  workspace.Leg_Lift.In_Use.Value;
        Squat_Jumps = workspace.Squat_Jumps.In_Use.Value;
        Push_Ups    = workspace.Push_Ups.In_Use.Value;
    }
    return trainingDevice
end

