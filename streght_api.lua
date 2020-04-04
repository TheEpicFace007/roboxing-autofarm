--Game Variable--
Players = game:GetService('Players')
LocalPlayer = Players.LocalPlayer
PlayerGui = LocalPlayer.PlayerGui
PlayerScript = LocalPlayer.PlayerScripts
StarterPlayer = game.StarterPlayer
StarterPlayerScript = game.StarterPlayer.StarterPlayerScripts
StarterCharacterScript= StarterPlayer.StarterCharacterScripts
StarterGui = game.StarterGui
ReplicatedStorage = game.ReplicatedStorage
ReplicatedFirst = game:GetService('ReplicatedFirst')
Backpack = LocalPlayer.Backpack
Character = LocalPlayer.Character
Humanoid = Character.Humanoid
HumanoidRootPart = Character.HumanoidRootPart 
-- return an array that indicate which training device are used and which are not used
getgenv().strenghtAuto = {}
getgenv().strenghtAuto.timeItRepeat = 1 -- the default step of cycle of the auto farm

fireMb1Click = function(btn)
    for _,signal in pairs( getconnections(btn.MouseButton1Click )) do
        signal:Fire()
    end
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
    trainingDevice = {       
       Crunches     = {workspace.Crunches.In_Use.Value   ;Vector3.new(-142.26973, 3.69035339, -64.4220047)};
       Leg_Lift     = {workspace.Leg_Lift.In_Use.Value   ;Vector3.new(-127.155914, 3.69005132, -65.509613)};
       Squat_Jumps  = {workspace.Squat_Jumps.In_Use.Value;Vector3.new(-113.031052, 3.69005132, -65.5107956)};
       Push_Ups     = {workspace.Push_Ups.In_Use.Value   ;Vector3.new(-97.0513, 3.69003153, -66.1871414)};
       Overhead1    = {workspace.Overhead1.In_Use.Value  ;Vector3.new(-95.6423416, 3.50129175, 63.8929062)};
       Bicep1       = {workspace.Bicep1.In_Use.Value     ;Vector3.new(-108.193413, 3.50129175, 60.8449173)};
       Squat1       = {workspace.Squat1.In_Use.Value     ;Vector3.new(-118.741066, 3.50129128, 61.4322205)};
       Bench1       = {workspace.Bench1.In_Use.Value     ;Vector3.new(-130.319031, 3.44129109, 57.6213875)};
    }
    local toolToFarmOn
    for i,v in pairs( trainingDevice ) do
        if v[1] == false then
            toolToFarmOn = v
            break
        end
    end
    local PathfindingService = game:GetService("PathfindingService")
    local path = PathfindingService:CreatePath()
    print( repr( toolToFarmOn ) )
    path:ComputeAsync(HumanoidRootPart.Position,toolToFarmOn[2])
    path:GetWaypoints()

end
doStreghtAutoFarm()