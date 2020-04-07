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
local timeItRepeatSpeed = 1

emulateBtnClick = function(btn)
    assert(btn,"Missing argument #1, must specify a btn")
    for _,signal in pairs( getconnections(btn.Activated )) do
        signal:Fire()
    end
end

-- @timeItRepeat | amount of time it will repat the autofarm useful if you want to train on a specific thing  | intended for slider. if its not used the default value will be 1
setAmountItWillRepeatStr = function(timeItRepeat)
    if timeItRepeat < 1 then
        error("error in #1, the number must be equal or bigger than 1")
    else
        timeItRepeatSpeed = timeItRepeat
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
    return path
end

doSpeedAutoFarm = function()
    local findAvailable = function() --> array {availableDevice: bool;Position: Vector3}
        trainingDevice = {
            Tramp1     = {workspace.Tramp1.In_Use.Value   ;Vector3.new(-144.58, 3.68, 62.54);
                            workspace.Tramp1.Player};
            Tramp2     = {workspace.Tramp2.In_Use.Value   ;Vector3.new(-144.73, 3.68, 51.47);
                            workspace.Tramp2.Player};
            Tramp3  = {workspace.Tramp3.In_Use.Value;Vector3.new(-142.98, 3.68, 40.14);
                            workspace.Tramp3.Player};
            Tramp4     = {workspace.Tramp4.In_Use.Value   ;Vector3.new(-145.60, 3.68, 30.45);
                            workspace.Tramp4.Player};
        }
        for i,v in pairs( trainingDevice ) do
            if v[1] == false then
                return v
            end
        end
    end
    onPathBlocked = function(blockedWaypointIndex)
        if blockedWaypointIndex > currentWaypointIndex then
            if workspace.breadcrumb then
                destroyBreadcrumb()
            end
            print(debug.traceback("Blocked. Repathing."))
            pathfind(findAvailaible()[2],true)
        end
    end
    -- TODO : FIX UP THE THING WHERE I CAN'T LOOP TWO OR MORE CYCLE(Issue #1)
    for _ = 1,timeItRepeatSpeed do
        repeat
            wait()
        until Humanoid.WalkSpeed == 16
        toolToFarmOn = findAvailable()
        local path = pathfind(toolToFarmOn[2],true)
        path.Blocked:Connect(onPathBlocked)
        print(debug.traceback())
        local timeSinceNoGui = tick()
        repeat wait()
            if tick() - timeSinceNoGui >= 3 then
                Humanoid.Jump = true
            end
        until trainingGui.Exercise_Prompt.Exercise_Name.Value ~= ""
        emulateBtnClick(trainingGui.Exercise_Prompt)
    end
    return true;
end

doSpeedAutoFarm()