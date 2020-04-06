--Game Variable--
Players = game:GetService('Players')
LocalPlayer = Players.LocalPlayer
PlayerGui = LocalPlayer.PlayerGui
    trainingGui = PlayerGui.Training_Guis
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

timeItRepeat = 2 -- the default step of cycle of the auto farm

emulateBtnClick = function(btn)
    assert(btn,"Missing argument #1, must specify a btn")
    for _,signal in pairs( getconnections(btn.Activated )) do
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

destroyBreadcrumb = function()
    for i,v in pairs( workspace:GetChildren() ) do
        if v.ClassName == "Folder" and v.Name == "breadcrumb" then
            v:Destroy()
        end
    end
end

pathfind = function(Position,isShowingBreadcrumb)
    local PathfindingService = game:GetService("PathfindingService");
    path = PathfindingService:CreatePath()
    if typeof(Position) ~= "Vector3" then
        error("ERROR IN #1 : The position must be a Vector",2)
        return
    end
    path:ComputeAsync(HumanoidRootPart.Position,Position)
    waypoints = {}
    if path.Status == Enum.PathStatus.Success then
        waypoints = path:GetWaypoints()
            if isShowingBreadcrumb then
                breadcrumb = Instance.new("Folder",workspace)
                breadcrumb.Name = "breadcrumb"
            end
            for _, waypoint in pairs(waypoints) do
                if isShowingBreadcrumb == true then
	                local part = Instance.new("Part")
	                part.Shape = "Ball"
	                part.Material = "Neon"
	                part.Size = Vector3.new(0.6, 0.6, 0.6)
	                part.Position = waypoint.Position
	                part.Anchored = true
	                part.CanCollide = false
                    part.Parent = game.Workspace.breadcrumb
                end
                Humanoid:MoveTo(waypoint.Position)
                Humanoid.MoveToFinished:Wait()
            end
            breadcrumb:Destroy()
    else
        error("Error: path not found");
        Humanoid:MoveTo(HumanoidRootPart.Position)
    end
end
doStreghtAutoFarm = function()
    local findAvailable = function() --> array {availableDevice: bool;Position: Vector3}
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
        for i,v in pairs( trainingDevice ) do
            if v[1] == false then
                return v
            end
        end
    end
    local isVerbose = true
    for k = 1,timeItRepeat do
        pathfind(findAvailable()[2],true)
        emulateBtnClick(trainingGui.Exercise_Prompt)
        local timeSinceNoGui = math.floor(tick())
        debug.traceback()
        repeat wait()
            if math.floor(tick()) - timeSinceNoGui > 3 then
                if isVerbose == true then
                    warn("It has been more than 3 second with no gui. Trying to show the gui again by jumping.")
                end
                Humanoid.Jump = true
                if trainingGui.Exercise_Prompt.Exercise_Name.Value == "" then
                    warn("There is no gui. Skipping the repeatation of the streght auto farm.");
                    return false; -- false mean did not succeed to run  the auto farm
                end;
            end
        until trainingGui.Exercise_Prompt.Exercise_Name.Value ~= ""
    end
    return true;
end

doStreghtAutoFarm()