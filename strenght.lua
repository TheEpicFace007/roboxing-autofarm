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

getgenv().RobBoxingAutoFarmAPI.strenght = {}

RobBoxingAutoFarmAPI.strenght.indNotUsedStreghtPad = function() --> return an array of the pad that arent used 
    local trainingToolUse = {
           workspace.Crunches.In_Use.Value;
           workspace.Leg_Lift.In_Use.Value;
        workspace.Squat_Jumps.In_Use.Value;
           workspace.Push_Ups.In_Use.Value;
    }
    print
end