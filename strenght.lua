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


getNotUsedStreghtPad = function() --> return an array of the pad that arent used 
    local trainingTool = {
        workspace.Crunches;
        workspace.Leg_Lift;
        workspace.Squat_Jumps;
        workspace.Push_Ups;
    }
end